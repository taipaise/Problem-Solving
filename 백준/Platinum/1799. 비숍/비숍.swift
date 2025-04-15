import Foundation

// 비숍은 같은 대각선 위에 있으면 공격 가능
// 다시 말해 y증가량과 x증가량이 같으면 됨
// n queen의 경우 한 행에 한 개의 퀸 -> n bishop은 한 대각선에 하나의 비숍
// 하나의 대각선을 어떻게 구현할 것인가..
// 행을 하나씩 내려가되, (n행 0열)부터 위로 하나씩 올라가는 흐름. 즉 y, x 값을 모두!! 1씩 감소시키는 방식 (따라서 범위 체크 함수가 필요)
// 그렇다면 남은 반쪽은 어떻게 확인할 것인가? -> 보드 사이즈의 세로를 2배 증가 시켜서 확인해보자. 대신 비숍을 둘 수 없는 상태로 표시하는것임
// 정확히는 세로 길이를 size * 2 - 1로 두면 될듯
struct Pos {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

let size = Int(readLine()!)!
var boards: [[Bool]] = Array(
    repeating: Array(repeating: false, count: size),
    count: size * 2 - 1)
var bishops: [Pos] = []
var res = 0

for y in 0..<size {
    let input = readLine()!.split(separator: " ")

    for x in 0..<size {
        boards[y][x] = input[x] == "1"
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < size * 2 - 1
        && 0 <= x && x < size
}

func canAttack(_ pos1: Pos, _ pos2: Pos) -> Bool {
    return abs(pos1.y - pos2.y) == abs(pos1.x - pos2.x)
}


func selectBishop(_ y: Int) {
    if y == size * 2 - 1 {
        res = max(res, bishops.count)
        return
    }

    var isPlaced = false
    // x의 크기가 곧 y의 증가량이 될 것이다.
    for x in 0..<size {
        let curY = y - x

        guard
            inRange(curY, x), // 범위 안에 있고
            boards[curY][x] // 비숍을 놓을 수 있는 위치인가?
        else { continue }

        let pos = Pos(curY, x)

        // 이전 비숍들과 비교
        var isValidPosition = true
        for bishop in bishops {
            guard !canAttack(pos, bishop) else {
                isValidPosition = false
                break
            }
        }

        guard isValidPosition else { continue }
        bishops.append(pos)
        isPlaced = true
        selectBishop(y + 1)
        bishops.removeLast()
    }
    
    if !isPlaced {
        selectBishop(y + 1)        
    }
}

selectBishop(0)
print(res)
