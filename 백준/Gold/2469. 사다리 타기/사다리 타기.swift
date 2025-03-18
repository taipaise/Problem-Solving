// 시작 값을 ???? 바로 위까지 진행해 내린다. 순서a
// 결과 값을 ???? 바로 밑까지 역순으로 추적해 올린다. 순서b
// 적절하게 사다리 다리 결과를 만들어낸다.
// 사다리타기
// 왼쪽, 오른쪽에 다리가 있다면 다리를 타고 옆 줄로 이동해야 함.
// 다리는 칸 수(사람 수) - 1개만큼 존재한다.

enum Direction: Int {
    case left
    case right
}

let width = Int(readLine()!)! // 참가자 수. 곧 가로 길이
let height = Int(readLine()!)!

let target = readLine()!
var targetPos = Dictionary(uniqueKeysWithValues: target.enumerated().map { (index, value) in (String(value), index) })

let participants = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".prefix(width)
var participantsPos = Dictionary(uniqueKeysWithValues: participants.enumerated().map { (index, value) in (String(value), index) })

var unknownRow = 0 // ???가 나타나는 열의 index
var boards: [[[Bool]]] = Array(
    repeating: Array(repeating: Array(repeating: false, count: 2),
                     count: width),
    count: height) // [y][x][Direction] 으로 벽이 있는지 없는지 확인

// 다리 입력
for y in 0..<height {
    let line = readLine()!.map { String($0) }

    guard line.first! != "?" else {
        unknownRow = y
        continue
    }

    for x in 0..<width - 1 {
        guard line[x] == "-" else { continue }
        
        boards[y][x][Direction.right.rawValue] = true
        boards[y][x + 1][Direction.left.rawValue] = true
    }
}

// 위에서 아래로 내려감
func goDownUntilMeetUnknown() {
    guard unknownRow > 0 else { return }
    for name in participantsPos.keys {
        moveDown(name, unknownRow)
    }
}

func moveDown(_ name: String, _ targetRow: Int) {
    guard var xpos = participantsPos[name] else { return }
    //0부터 targetRow까지 내려감
    for y in 0..<targetRow {
        if boards[y][xpos][Direction.left.rawValue] {
            xpos -= 1
        } else if boards[y][xpos][Direction.right.rawValue] {
            xpos += 1
        }
    }
    participantsPos[name] = xpos
}

// 아래에서 위로 올라감
func goUpUntilMeetUnknown() {
    guard unknownRow < height - 1 else { return }
    for name in targetPos.keys {
        moveUp(name, unknownRow)
    }
}

func moveUp(_ name: String, _ targetRow: Int) {
    guard var xpos = targetPos[name] else { return }

    for y in stride(from: height - 1, to: targetRow, by: -1) {
        if boards[y][xpos][Direction.left.rawValue] {
            xpos -= 1
        } else if boards[y][xpos][Direction.right.rawValue] {
            xpos += 1
        }
    }
    targetPos[name] = xpos
}

func makeLadder() -> String {
    // 이제 ??? 줄을 기점으로 바로 위 아래에 문자열이 배치되어 있음
    var ladder: [Bool] = Array(repeating: false, count: width - 1) // 우선 다리가 모두 없다고 가정

    for (name, _) in participantsPos.sorted(by: {$0.value < $1.value}) {
        guard
            let prePos = participantsPos[name],
            let nextPos = targetPos[name],
            abs(prePos - nextPos) <= 1
        else { return Array(repeating: "x", count: width - 1).joined(separator: "") }

        if prePos == width - 1 { continue }

        if prePos < nextPos { // 현재 칸의 오른쪽에 다리를 놓는다.
            ladder[prePos] = true

            if
                prePos > 0,
                ladder[prePos - 1] // 만약 이전 칸에서 오른쪽에 이미 다리를 놓았다면, 다리를 연속으로 놓는것이기 때문에 불가능함
            { return Array(repeating: "x", count: width - 1).joined(separator: "") }
        }
    }

    return ladder.map { $0 ? "-" : "*" }.joined(separator: "")
}

func solution() {
    goDownUntilMeetUnknown()
    goUpUntilMeetUnknown()
    print(makeLadder())
}

solution()
