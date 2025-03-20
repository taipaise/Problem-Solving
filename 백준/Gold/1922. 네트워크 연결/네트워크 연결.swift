import Foundation

struct DisjointSet {
    private var parents: [Int]
    private var ranks: [Int]

    init(_ n: Int) {
        parents = (0...n).map { $0 }
        ranks = Array(repeating: 1, count: n + 1)
    }

    mutating func find(_ index: Int) -> Int {
        if parents[index] == index {
            return index
        }

        parents[index] = find(parents[index])
        return parents[index]
    }

    mutating func merge(_ u: Int, _ v: Int) {
        var u = find(u)
        var v = find(v)

        if u == v { return } // 이미 같은 그룹임

        if ranks[u] > ranks[v] {
            swap(&u, &v)
        }

        parents[u] = v

        if ranks[u] == ranks[v] {
            ranks[v] += 1
        }
    }
}

struct Heap<T: Comparable> {
    private var heap: [T?] = [nil]
    private let compare: (T, T) -> Bool
    var count: Int {
        return heap.count - 1
    }
    var isEmpty: Bool {
        return heap.count <= 1
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
        heap.swapAt(1, heap.count - 1)
        defer { heapifyDown() }
        return heap.removeLast()
    }

    private mutating func heapifyUp() {
        var index = heap.count - 1

        while
            index > 1,
            let child = heap[index],
            let parent = heap[index / 2],
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
                let child = heap[candidate],
                let parent = heap[index],
                compare(child, parent)
            else { return }

            heap.swapAt(candidate, index)
            index = candidate
        }
    }
}

struct Edge: Comparable {
    let start: Int
    let end: Int
    let weight: Int

    init(_ s: Int, _ e: Int, _ w: Int) {
        start = s
        end = e
        weight = w
    }

    static func <(_ lhs: Edge, _ rhs: Edge) -> Bool {
        return lhs.weight < rhs.weight
    }
}

let nodeCount = Int(readLine()!)!
let edgeCount = Int(readLine()!)!
var disjointSet = DisjointSet(nodeCount)
var edges = Heap<Edge>(<)
var selectedEdgeCount = 0
var res = 0

for _ in 0..<edgeCount {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }

    let edge = Edge(line[0], line[1], line[2])
    edges.insert(edge)
}


while
    let edge = edges.pop(),
    selectedEdgeCount < nodeCount - 1
{
    let node1 = edge.start
    let node2 = edge.end

    guard disjointSet.find(node1) != disjointSet.find(node2) else { continue }
    disjointSet.merge(node1, node2)
    res += edge.weight
    selectedEdgeCount += 1
}

print(res)
