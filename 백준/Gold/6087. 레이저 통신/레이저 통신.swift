import Foundation

enum Direction: Int {
    case up
    case down
    case left
    case right
}

struct Pos: Comparable {
    let y: Int
    let x: Int
    let direction: Direction
    let rotateCount: Int

    static func <(_ lhs: Pos, _ rhs: Pos) -> Bool {
        return lhs.rotateCount < rhs.rotateCount
    }
}

struct Heap<T: Comparable> {
    private var heap: [T?]
    var isEmpty: Bool {
        return heap.count < 2
    }

    init() {
        heap = [nil]
    }

    mutating func insert(_ element: T) {
        heap.append(element)
        heapifyUp()
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }

        heap.swapAt(1, heap.count - 1)
        defer { heapifyDown() }
        return heap.removeLast()
    }

    mutating private func heapifyUp() {
        var index = heap.count - 1

        while index > 1 {
            guard
                let parent = heap[index / 2],
                let child = heap[index],
                parent > child
            else { return }

            heap.swapAt(index, index / 2)
            index /= 2
        }
    }

    mutating private func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var minIndex = index * 2

            if
                minIndex + 1 < heap.count,
                let leftChild = heap[minIndex],
                let rightChild = heap[minIndex + 1],
                leftChild > rightChild
            { minIndex = minIndex + 1 }

            guard
                let parent = heap[index],
                let child = heap[minIndex],
                parent > child
            else { return }

            heap.swapAt(index, minIndex)
            index = minIndex
        }
    }
}

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let maxX = numbers[0]
let maxY = numbers[1]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var boards: [[String]] = []
var visited: [[[Int]]] = Array(
    repeating: Array(
        repeating: Array(repeating: Int.max, count: 4),
        count: maxX),
    count: maxY)
var rooms: [(y: Int, x: Int)] = []

for y in 0..<maxY {
    let line = readLine()!.map { String($0) }
    boards.append(line)
    if let x = line.firstIndex(where: { $0 == "C" }) {
        rooms.append((y: y, x: x))
    }
}
let start = (y: rooms[0].y, x: rooms[0].x)
boards[start.y][start.x] = "."

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < maxY && 0 <= x && x < maxX
}

func bfs(_ startY: Int, _ startX: Int) -> Int {
    var queue = Heap<Pos>()

    for dir in 0..<4 {
        queue.insert(Pos(
            y: startY,
            x: startX,
            direction: Direction(rawValue: dir)!,
            rotateCount: 0))
        visited[startY][startX][dir] = 0
    }

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return Int.max }

        if boards[pos.y][pos.x] == "C" {
            return pos.rotateCount
        }

        for dir in 0..<4 {
            let nDirection = Direction(rawValue: dir)!
            let ny = pos.y + dy[dir]
            let nx = pos.x + dx[dir]
            let nRotateCount = pos.direction == nDirection ? pos.rotateCount : pos.rotateCount + 1

            guard
                inRange(ny, nx),
                boards[ny][nx] != "*",
                nRotateCount < visited[ny][nx][dir]
            else { continue }

            visited[ny][nx][dir] = nRotateCount
            queue.insert(
                Pos(
                    y: ny,
                    x: nx,
                    direction: nDirection,
                    rotateCount: nRotateCount))
        }
    }
    return Int.max
}

print(bfs(start.y, start.x))
