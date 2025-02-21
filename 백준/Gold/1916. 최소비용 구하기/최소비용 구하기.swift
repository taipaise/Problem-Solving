import Foundation

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

    mutating func heapifyUp() {
        var index = heap.count - 1

        while index > 1 {
            guard
                let child = heap[index],
                let parent = heap[index / 2],
                parent > child
            else { return }

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
                let leftChild = heap[minIndex],
                let rightChild = heap[minIndex + 1],
                leftChild > rightChild
            { minIndex += 1 }

            guard
                let child = heap[minIndex],
                let parent = heap[index],
                parent > child
            else { return }

            heap.swapAt(index, minIndex)
            index = minIndex
        }
    }
}

struct Edge: Comparable {
    let end: Int
    let cost: Int

    init(_ end: Int, _ cost: Int) {
        self.end = end
        self.cost = cost
    }

    static func <(_ lhs: Edge, _ rhs: Edge) -> Bool {
        return lhs.cost < rhs.cost
    }
}

let n = Int(readLine()!)!
let m = Int(readLine()!)!
var heap = Heap<Edge>()
var graph: [[Edge]] = Array(repeating: [], count: n + 1)
var dist = Array(repeating: 100000000, count: n + 1)
var (start, end) = (0, 0)
for _ in 0..<m {
    let input = readLine()!.split(separator: " ").map{ Int(String($0))! }
    let (start, end, cost) = (input[0], input[1], input[2])
    graph[start].append(Edge(end, cost))
}
let points = readLine()!.split(separator: " ").map{ Int(String($0))! }
(start, end) = (points[0], points[1])
heap.insert(Edge(points[0], 0))
dist[start] = 0
while !heap.isEmpty {
    guard let edge = heap.pop() else { break }

    let cur = edge.end
    let cost = edge.cost

    if dist[cur] < cost { continue }

    for edge in graph[cur] {
        let newCost = dist[cur] + edge.cost
        guard newCost < dist[edge.end] else { continue }

        dist[edge.end] = newCost
        heap.insert(Edge(edge.end, newCost))
    }
}
print(dist[end])
