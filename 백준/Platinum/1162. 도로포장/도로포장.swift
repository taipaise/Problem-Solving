import Foundation

struct Heap<T: Comparable> {
    private let compare: (T, T) -> Bool
    private var heap: [T?] = [nil]
    var isEmpty: Bool { return heap.count <= 1 }
    var peak: T? {
        guard !isEmpty else { return nil }
        return heap[1]
    }

    init(_ compare: @escaping (T, T) -> Bool) {
        self.compare = compare
    }

    mutating func insert(_ element: T) {
        heap.append(element)
        heapifyUp()
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        defer { heapifyDown() }

        heap.swapAt(1, heap.count - 1)
        return heap.removeLast()
    }

    private mutating func heapifyUp() {
        var index = heap.count - 1

        while index > 1 {
            guard
                let parent = heap[index / 2],
                let child = heap[index],
                compare(child, parent)
            else { return }

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

struct Edge: Comparable {
    let to: Int
    let cost: Int64
    let coveredCount: Int

    init(_ t: Int, _ d: Int, _ c: Int) {
        to = t
        cost = Int64(d)
        coveredCount = c
    }

    init(_ t: Int, _ d: Int64, _ c: Int) {
        to = t
        cost = d
        coveredCount = c
    }

    static func <(lhs: Edge, rhs: Edge) -> Bool {
        return lhs.cost < rhs.cost
    }
}

let inputs = readLine()!.split(separator: " ").map { Int($0)! }
let n = inputs[0]
let m = inputs[1]
let k = inputs[2]
// costs[i][j] := i 번 포장했을때, j까지 도달하기 위한 최소 비용
var costs: [[Int64]] = Array(
    repeating: Array(repeating: Int64(1e10), count: n + 1),
    count: k + 1)
var heap = Heap<Edge>(<)
var edges: [[Edge]] = Array(repeating: [], count: n + 1)
var answer = Int64.max

for _ in 0..<m {
    let inputs = readLine()!.split(separator: " ").map { Int($0)! }

    edges[inputs[0]].append(Edge(inputs[1], inputs[2], 0))
    edges[inputs[1]].append(Edge(inputs[0], inputs[2], 0))
}

// 시작할 간선들을 힙에 넣어줌
costs[0][1] = 0
heap.insert(.init(1, 0, 0))

while let edge = heap.pop() {
    let to = edge.to
    let cost = edge.cost
    let coveredCount = edge.coveredCount

    if costs[coveredCount][to] != cost { continue }

    for nextEdge in edges[to] {
        // 포장하지 않기
        var newCost = nextEdge.cost + cost

        if newCost < costs[coveredCount][nextEdge.to] {
            costs[coveredCount][nextEdge.to] = newCost
            heap.insert(Edge(nextEdge.to, newCost, coveredCount))
        }

        // 포장하기
        guard coveredCount < k  else { continue }
        newCost = cost

        if newCost < costs[coveredCount + 1][nextEdge.to] {
            costs[coveredCount + 1][nextEdge.to] = newCost
            heap.insert(Edge(nextEdge.to, newCost, coveredCount + 1))
        }
    }
}

for i in 0...k {
    answer = min(answer, costs[i][n])
}

print(answer)
