import Foundation

enum BlockType: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven

    var shape: [[[String]]] {
        switch self {
        case .one:
            return [
                [
                    ["x", "."],
                    ["x", "x"],
                    [".", "x"]],
                [
                    [".", "x", "x"],
                    ["x", "x", "."]],
                [
                    ["x", "."],
                    ["x", "x"],
                    [".", "x"]],
                [
                    [".", "x", "x"],
                    ["x", "x", "."]]]
        case .two:
            return [
                [
                    [".", "x"],
                    ["x", "x"],
                    ["x", "."]],
                [
                    ["x", "x", "."],
                    [".", "x", "x"]],
                [
                    [".", "x"],
                    ["x", "x"],
                    ["x", "."]],
                [
                    ["x", "x", "."],
                    [".", "x", "x"]]]
        case .three:
            return [
                [
                    ["x", "."],
                    ["x", "."],
                    ["x", "x"]],
                [
                    [".", ".", "x"],
                    ["x", "x", "x"]],
                [
                    ["x", "x"],
                    [".", "x"],
                    [".", "x"]],
                [
                    ["x", "x", "x"],
                    ["x", ".", "."]]]
        case .four:
            return [
                [
                    [".", "x"],
                    [".", "x"],
                    ["x", "x"]],
                [
                    ["x", "x", "x"],
                    [".", ".", "x"]],
                [
                    ["x", "x"],
                    ["x", "."],
                    ["x", "."]],
                [
                    ["x", ".", "."],
                    ["x", "x", "x"]]]
        case .five:
            return [
                [
                    ["x", "x"],
                    ["x", "x"]],
                [
                    ["x", "x"],
                    ["x", "x"]],
                [
                    ["x", "x"],
                    ["x", "x"]],
                [
                    ["x", "x"],
                    ["x", "x"]]]
        case .six:
            return [
                [
                    ["x"],
                    ["x"],
                    ["x"],
                    ["x"]],
                [["x", "x", "x", "x"]],
                [
                    ["x"],
                    ["x"],
                    ["x"],
                    ["x"]],
                [["x", "x", "x", "x"]]]
        case .seven:
            return [
                [
                    [".", "x", "."],
                    ["x", "x", "x"]],
                [
                    [".", "x"],
                    ["x", "x"],
                    [".", "x"]],
                [
                    ["x", "x", "x"],
                    [".", "x", "."]],
                [
                    ["x", "."],
                    ["x", "x"],
                    ["x", "."]]]
        }
    }
}

struct Block {
    let type: BlockType
    let rotation: Int
    let pos: Int

    init(_ type: Int, _ rotation: Int, _ pos: Int) {
        self.type = BlockType(rawValue: type)!
        self.rotation = rotation
        self.pos = pos
    }
}

let maxBoardSize = 20
let testCaseCount = Int(readLine()!)!
var curCaseCount = 0

var (w, h, n) = (0, 0, 0)
var boards: [[String]] = []
var blocks: [Block] = []

// step1. 초기화
func initialize() {
    curCaseCount += 1
    boards = Array(
        repeating: Array(repeating: ".", count: maxBoardSize),
        count: maxBoardSize)
    blocks.removeAll()
}

// step2. 입력받기
func input() {
    let numbers = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    w = numbers[0]
    h = numbers[1]
    n = numbers[2]

    for _ in 0..<n {
        let blockInput = readLine()!
            .split(separator: " ")
            .map { Int(String($0))! }
        blocks.append(Block(blockInput[0], blockInput[1], blockInput[2]))
    }
}

// step3. 블록 쌓기
func downBlock(_ startLine: Int, _ pos: Int, _ shape: [[String]]) -> Bool {
    var curY = startLine

    // 윗줄 + 1부터 쌓을 수 있는 위치까지 이동
    while checkIsPossible(shape, pos, curY + 1) {
        curY += 1
    }

    guard checkIsPossible(shape, pos, curY) else { return false }

    // 블록 쌓기
    for y in 0..<shape.count {
        for x in 0..<shape[0].count {
            if shape[y][x] == "x" {
                boards[curY + y][pos + x] = "x"
            }
        }
    }
    return true
}

func checkIsPossible(_ shape: [[String]], _ xpos: Int, _ ypos: Int) -> Bool {
    guard ypos + shape.count <= maxBoardSize else { return false }

    for y in 0..<shape.count {
        for x in 0..<shape[0].count {
            if
                shape[y][x] == "x",
                boards[ypos + y][xpos + x] == "x"
            { return false }
        }
    }

    return true
}

// step4. 라인 클리어 확인하기
func checkLine(_ startLine: Int) {
    // 윗 라인부터 확인
    for i in startLine..<maxBoardSize {
        let hasToClear = boards[i][0..<w].allSatisfy { $0 == "x" }
        if hasToClear {
            lineClear(startLine, i)
        }
    }
}

// step5. 라인 클리어하기
func lineClear(_ startLine: Int, _ lineNumber: Int) {
    for i in stride(from: lineNumber, to: startLine, by: -1) {
        boards[i] = boards[i - 1]
    }

    for i in 0..<w {
        boards[startLine][i] = "."
    }
}

// step6. 보드 상태 출력하기
func printBoard(_ startLine: Int) {
    print("Case #\(curCaseCount):")

    for i in startLine..<maxBoardSize {
        for j in 0..<w {
            print(boards[i][j], terminator: "")
        }
        print("")
    }
}


func solve() {
    for _ in 0..<testCaseCount {
        var isPossible = true
        initialize()
        input()

        let startLine = maxBoardSize - h

        for block in blocks {
            let shape = block.type.shape[block.rotation]
            let linePossible = downBlock(startLine, block.pos, shape)

            guard linePossible else {
                isPossible = false
                break
            }

            for i in startLine..<maxBoardSize {
                checkLine(i)
            }
        }

        guard isPossible else {
            print("Case #\(curCaseCount):")
            print("Game Over!")
            continue
        }

        printBoard(startLine)
    }
}

solve()
