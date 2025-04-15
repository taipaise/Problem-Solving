import Foundation

// 퀸이 공격할 수 없으려면
// 1. 가로가 달라야 함
// 2. 세로가 달라야 함
// 3. 대각선이 달라야 함 -> 기울기로 확인

struct Pos {
    let y: Int
    let x: Int

    init(_ x: Int, _ y: Int) {
        self.y = y
        self.x = x
    }
}

let size = Int(readLine()!)!
var queens: [Pos] = []
var res = 0

func canAttack(_ pos1: Pos, _ pos2: Pos) -> Bool {
    return pos1.y == pos2.y
        || pos1.x == pos2.x
        || (abs(pos1.y - pos2.y) == abs(pos1.x - pos2.x))
}

func selectQueen(_ y: Int) {
    if y == size {
        res += 1
        return
    }

    // 다음 퀸 놓기
    for x in 0..<size {
        let pos = Pos(y, x)
        // 이전 퀸 검사
        var isValidPosition = true
        for queen in queens {
            guard !canAttack(pos, queen) else {
                isValidPosition = false
                break
            }
        }

        guard isValidPosition else { continue }
        queens.append(pos)
        selectQueen(y + 1)
        queens.removeLast()
    }
}

selectQueen(0)
print(res)
