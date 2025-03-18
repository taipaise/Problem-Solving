import Foundation

// 특정 칸에서 이동할 수 있는 최대 칸 수는 정해져 있다.
// 대나무 양이 큰 칸부터, 이동할 수 있는 최대 칸 수를 구한다면? -> 힙 구조를 이용해 가장 큰 칸부터 시작한다
// 재귀를 이용한 탑 다운 풀이.
//   - memorization이 되어 있는 칸을 만나면 return.
//    - 또는 움직일 수 없는 칸을 만나면 return

enum Direction: Int, CaseIterable {
    case up
    case down
    case left
    case right
}

struct Pos {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

struct Heap<T> {
    private var heap: [T?] = [nil]
    private var compare: (T, T) -> Bool

    init(_ comp: @escaping (T, T) -> Bool) {
        compare = comp
    }

    var isEmpty: Bool {
        return heap.count <= 1
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

    private mutating func heapifyUp() {
        var index = heap.count - 1

        while
            index > 1,
            let parent = heap[index / 2],
            let child = heap[index],
            compare(child, parent)
        {
            heap.swapAt(index, index / 2)
            index /= 2
        }
    }

    private mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var candidate = index * 2

            if
                candidate + 1 < heap.count,
                let left = heap[candidate],
                let right = heap[candidate + 1],
                compare(right, left)
            { candidate += 1 }

            guard
                let parent = heap[index],
                let child = heap[candidate],
                compare(child, parent)
            else { return }

            heap.swapAt(index, candidate)
            index = candidate
        }
    }
}

let size = Int(readLine()!)!
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]
var bamboo: [[Int]] = Array(
    repeating: Array(repeating: 0, count: size),
    count: size)
var memorization: [[Int]] = Array(
    repeating: Array(repeating: 0, count: size),
    count: size)
var res = 0

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < size && 0 <= x && x < size
}

func calculateMaxCount(_ pos: Pos) -> Int {
    var res = 0

    for dir in Direction.allCases {
        let ny = pos.y + dy[dir.rawValue]
        let nx = pos.x + dx[dir.rawValue]

        guard
            inRange(ny, nx),
            bamboo[ny][nx] > bamboo[pos.y][pos.x]
        else { continue }

        res = max(res, memorization[ny][nx])
    }

    return res + 1
}

func solution() {
    var heap = Heap<(pos: Pos, value: Int)>({ $0.value > $1.value })

    for y in 0..<size {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! }
        for x in 0..<size {
            bamboo[y][x] = line[x]
            heap.insert((pos: Pos(y, x), value: line[x]))
        }
    }


    while let (pos, _) = heap.pop() {
        memorization[pos.y][pos.x] = calculateMaxCount(pos)
        res = max(res, memorization[pos.y][pos.x])
    }

    print(res)
}

solution()
