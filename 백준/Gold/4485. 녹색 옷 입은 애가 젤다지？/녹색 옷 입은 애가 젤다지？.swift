import Foundation

// 최소 힙
struct Heap<T: Comparable> {
    private var heap: [T?]
    var isEmpty: Bool {
        return heap.count < 2
    }

    init() {
        heap = [nil]
    }

    mutating func push(_ e: T) {
        heap.append(e)
        heapifyUp()
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }

        heap.swapAt(1, heap.count - 1)

        defer { heapifyDown() }

        return heap.removeLast()
    }

    mutating func heapifyUp() {
        var index = heap.count - 1

        while
            index / 2 > 0,
            let child = heap[index],
            let parent = heap[index / 2],
            child < parent
        {
            heap.swapAt(index, index / 2)
            index /= 2
        }
    }

    mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {

            var minIndex = index * 2
            if
                minIndex + 1 < heap.count,
                let left = heap[minIndex],
                let right = heap[minIndex + 1],
                left > right
            { minIndex += 1 }

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

struct Pos: Comparable {
    let y: Int
    let x: Int
    let w: Int

    static func < (_ lhs: Pos, _ rhs: Pos) -> Bool {
        return lhs.w < rhs.w
    }
}

var caseCount = 1
let dy = [1, -1, 0, 0]
let dx = [0, 0, 1, -1]

func execute() {
    // 입력이 한 글자, 정수로 바꿀 수 있다면
    while
        let input = readLine(),
        let n = Int(input)
    {
        guard n > 0 else { return }

        let boards = makeBoard(n)
        solve(boards)
    }
}

func makeBoard(_ size: Int) -> [[Int]] {
    var boards: [[Int]] = []
    for _ in 0..<size {
        let line = readLine()!
            .split(separator: " ")
            .map { Int(String($0))! }

        boards.append(line)
    }

    return boards
}

func inRange(_ y: Int, _ x: Int, _ size: Int) -> Bool {
    return 0 <= y && y < size && 0 <= x && x < size
}

func solve(_ boards: [[Int]]) {
    // y, x 지점에 다다르기 위해 필요한 비용
    print("Problem \(caseCount):", terminator: " ")

    print(bfs(
        Pos(y: 0, x: 0, w: boards[0][0]),
        boards))
    caseCount += 1
}

func bfs(
    _ start: Pos,
    _ boards: [[Int]]
) -> Int {
    var costs: [[Int]] = Array(
        repeating: Array(repeating: Int.max, count: boards.count),
        count: boards.count)
    var pq = Heap<Pos>()
    pq.push(start)
    costs[start.y][start.x] = boards[start.y][start.x]

    while !pq.isEmpty {
        guard let pos = pq.pop() else { return -1 }

        let y = pos.y
        let x = pos.x
        let weight = pos.w

        if
            y == boards.count - 1,
            x == boards.count - 1
        { return weight }

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx, boards.count),
                weight + boards[ny][nx] < costs[ny][nx]
            else { continue }

            costs[ny][nx] = weight + boards[ny][nx]
            let newPos = Pos(y: ny, x: nx, w: costs[ny][nx])
            pq.push(newPos)
        }
    }
    return -1
}


execute()