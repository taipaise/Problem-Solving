import Foundation


struct Edge: Comparable {
    let from: Int
    let to: Int
    let time: Int

    init(_ from: Int, _ to: Int, _ time: Int) {
        self.from = from
        self.to = to
        self.time = time
    }

    static func <(_ lhs: Edge, _ rhs: Edge) -> Bool {
        return lhs.time < rhs.time
    }
}

struct Heap<T: Comparable> {
    private let compare: (T, T) -> Bool
    private var heap: [T?] = [nil]
    var isEmpty: Bool {
        return heap.count <= 1
    }

    init(_ cmp: @escaping (T, T) -> Bool) {
        compare = cmp
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

func solution() {
    let tc = Int(readLine()!)!
    let maxTime = 100000 * 1000 + 1

    for _ in 0..<tc {
        let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
        let n = numbers[0]
        let edgeCount = numbers[1]
        let target = numbers[2]

        var edges = Heap<Edge>(<)
        var computers: [[Edge]] = Array(repeating: [], count: n + 1)
        var timeDist = Array(repeating: maxTime, count: n + 1)

        for _ in 0..<edgeCount {
            let line = readLine()!.split(separator: " ").map { Int(String($0))! }
            let start = line[1]
            let to = line[0]
            let time = line[2]
            let edge = Edge(start, to, time)
            computers[start].append(edge)
        }

        // 시작 간선들을 힙에 넣기
        timeDist[target] = 0
        for edge in computers[target] {
            edges.insert(edge)
        }

        while let edge = edges.pop() {
            guard timeDist[edge.to] > timeDist[edge.from] + edge.time else { continue }
            timeDist[edge.to] = timeDist[edge.from] + edge.time

            for toEdge in computers[edge.to] {
                guard timeDist[toEdge.to] > timeDist[toEdge.from] + toEdge.time else { continue }
                edges.insert(toEdge)
            }
        }

        var resCount = 0
        var resTime = 0

        for time in timeDist.dropFirst() {
            guard time < maxTime else { continue }
            resCount += 1
            resTime = max(resTime, time)
        }

        print(resCount, resTime)
    }


}

solution()
