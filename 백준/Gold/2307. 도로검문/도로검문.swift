import Foundation

// 우선 최단 시간 구하기
// 최단 거리에 포함된 도로를 하나씩 없애고 다시 최단 거리 구하기
// 비교하여 출력

struct Edge: Comparable {
    let id: Int
    let to: Int
    let cost: Int

    init(_ id: Int, _ t: Int, _ c: Int) {
        self.id = id
        to = t
        cost = c
    }

    static func <(_ lhs: Edge, _ rhs: Edge) -> Bool {
        return lhs.cost < rhs.cost
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



let maxDist = Int(1e8) + 1

func findShortest(_ forbiddenEdgeId: Int?, _ n: Int, _ edges: [[Edge]]) -> (dists: [Int], usedEdges: [Int]) {
    var dists = Array(repeating: maxDist, count: n + 1)
    var heap = Heap<Edge>(<)
    var usedEdges: [Int] = []
    heap.insert(Edge(-1, 1, 0))
    dists[1] = 0

    while let edge = heap.pop() {
        let node = edge.to
        let cost = edge.cost

        if dists[node] < cost { continue }

        for edge in edges[node] {
            if
                let forbiddenEdgeId = forbiddenEdgeId,
                forbiddenEdgeId == edge.id
            { continue }

            let next = edge.to
            let newCost = dists[node] + edge.cost

            if dists[next] < newCost { continue }

            dists[next] = newCost
            usedEdges.append(edge.id)
            heap.insert(Edge(edge.id, next, newCost))
        }
    }

    return (dists, usedEdges)
}

func solution() {
    let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = numbers[0]
    let m = numbers[1]
    var edges: [[Edge]] = Array(repeating: [], count: n + 1)

    for i in 0..<m {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! }
        let node1 = line[0]
        let node2 = line[1]
        let time = line[2]

        edges[node1].append(Edge(i, node2, time))
        edges[node2].append(Edge(i, node1, time))
    }

    let (dists, usedEdges) = findShortest(nil, n, edges)

    var res = dists[n]

    for edgeId in usedEdges {
        let (dists, _) = findShortest(edgeId, n, edges)
        res = max(res, dists[n])
    }

    if res == maxDist {
        print(-1)
    } else {
        print(res - dists[n])
    }
}

solution()
