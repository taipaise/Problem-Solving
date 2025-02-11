import Foundation

let flipCases = [
    0b111000000,
    0b000111000,
    0b000000111,
    0b100100100,
    0b010010010,
    0b001001001,
    0b100010001,
    0b001010100]
let answerStates = [0b111111111, 0b000000000]
var testCaseCount = 0

func convertToBit(_ board: [[String]]) -> Int {
    var result = 0

    for i in stride(from: 2, through: 0, by: -1) {
        for j in stride(from: 2, through: 0, by: -1) {
            if board[i][j] == "H" {
                result |= (1 << (3 * i + j))
            }
        }
    }

    return result
}

func bfs(_ startState: Int) -> Int {
    var visited: Set<Int> = [startState]
    var queue: [(state: Int, count: Int)] = [(startState, 0)]

    while !queue.isEmpty {
        let (state, count) = queue.removeFirst()

        if answerStates.contains(state) { return count }

        for flipCase in flipCases {
            let newState = (state ^ flipCase)

            guard !visited.contains(newState) else { continue }
            visited.insert(newState)
            queue.append((newState, count + 1))
        }
    }

    return -1
}


testCaseCount = Int(readLine()!)!

for _ in 0..<testCaseCount {
    var board: [[String]] = []

    for _ in 0..<3 {
        let line = readLine()!.split(separator: " ").map { String($0) }
        board.append(line)
    }

    let curState = convertToBit(board)
    let result = bfs(curState)

    print(result)
}
