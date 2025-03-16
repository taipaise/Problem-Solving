import Foundation

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0
    var isEmpty: Bool {
        return head >= queue.count
    }

    mutating func push(_ element: T) {
        queue.append(element)
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        defer { head += 1 }
        return queue[head]
    }
}

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var boards: [[Int]] = []
var areaInfo = Array(
    repeating: Array(repeating: 0, count: width),
    count: height)
var areaSizes: [Int: Int] = [:]
var result = Array(
    repeating: Array(repeating: 0, count: width),
    count: height)

for _ in 0..<height {
    let line = readLine()!.map { Int(String($0))! }
    boards.append(line)
}

// MARK: -

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

func breakWall(_ y: Int, _ x: Int) {
    var adjacentAreas: Set<Int> = []
    for dir in 0..<4 {
        let ny = y + dy[dir]
        let nx = x + dx[dir]

        guard
            inRange(ny, nx),
            boards[ny][nx] == 0
        else { continue }

        adjacentAreas.insert(areaInfo[ny][nx])
    }

    let size = (calculateSize(adjacentAreas) + 1) % 10
    result[y][x] = size
}

func calculateSize(_ areas: Set<Int>) -> Int {
    var res = 0
    for areaNumber in areas {
        res += areaSizes[areaNumber, default: 0]
    }
    return res
}

// 영역 표시
func checkArea() {
    var areaNumber = 0
    for y in 0..<height {
        for x in 0..<width {
            guard
                boards[y][x] == 0,
                areaInfo[y][x] == 0
            else { continue }
            areaNumber += 1
            areaSizes[areaNumber] = bfs(y, x, areaNumber)
        }
    }
}

// 영역을 표시하고 해당 영역 너비 리턴
func bfs(_ startY: Int, _ startX: Int, _ areaNum: Int) -> Int {
    var areaSize = 0
    var queue = Queue<(Int, Int)>()
    queue.push((startY, startX))

    areaInfo[startY][startX] = areaNum

    while let pos = queue.pop() {
        let (y, x) = pos
        areaSize += 1

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx),
                boards[ny][nx] == 0,
                areaInfo[ny][nx] == 0
            else { continue }

            areaInfo[ny][nx] = areaNum
            queue.push((ny, nx))
        }
    }
    return areaSize % 10
}

func printAns() {
    var answer = ""
    for line in result {
        answer += line
            .map{ String($0) }
            .joined(separator: "")
        answer += "\n"
    }
    print(answer)
}

func solve() {
    checkArea()

    for y in 0..<height {
        for x in 0..<width {
            guard boards[y][x] == 1 else { continue }
            breakWall(y, x)
        }
    }

    printAns()
}

solve()
