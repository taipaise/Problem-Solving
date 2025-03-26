import Foundation

struct Heap<T: Comparable> {
    private var heap: [T?] = [nil]
    var isEmpty: Bool {
        return heap.count <= 1
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

        while
            index > 1,
            let parent = heap[index / 2],
            let child = heap[index],
            parent > child
        {
            heap.swapAt(index, index / 2)
            index /= 2
        }
    }

    mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var candidate = index * 2

            if
                candidate + 1 < heap.count,
                let left = heap[candidate],
                let right = heap[candidate + 1],
                left > right
            { candidate += 1 }

            guard
                let child = heap[candidate],
                let parent = heap[index],
                parent > child
            else { return }

            heap.swapAt(index, candidate)
            index = candidate
        }
    }
}

struct Edge: Comparable {
    let to: Int
    let weight: Int

    init(_ to: Int, _ weight: Int) {
        self.to = to
        self.weight = weight
    }

    static func <(_ lhs: Edge, _ rhs: Edge) -> Bool {
        return lhs.weight < rhs.weight
    }
}

// MARK: 변수 및 상수
let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let nodeCount = numbers[0]
let edgeCount = numbers[1]
var dist = Array(repeating: Int.max, count: nodeCount + 1)
var edges: [[Edge]] = Array(repeating: [], count: nodeCount + 1)
var routes = Array(repeating: -1, count: nodeCount + 1)

// 입력
for _ in 0..<edgeCount {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let nodeA = input[0]
    let nodeB = input[1]

    edges[nodeA].append(Edge(nodeB, input[2]))
    edges[nodeB].append(Edge(nodeA, input[2]))
}

// MARK: - 풀이
func dijkstra() {
    var heap = Heap<Edge>()
    dist[2] = 0

    heap.insert(Edge(2, 0))

    while let edge = heap.pop() {
        let cur = edge.to
        let cost = edge.weight
        if dist[cur] > cost { continue }
        for edge in edges[cur] {
            let next = edge.to
            let edgeCost = edge.weight

            guard dist[cur] + edgeCost < dist[next] else { continue }

            dist[next] = dist[cur] + edgeCost
            heap.insert(Edge(next, dist[next]))
        }
    }
}

func findRoute(_ node: Int) -> Int {
    if node == 2 { return 1 }
    if routes[node] != -1 { return routes[node] }

    routes[node] = 0
    for edge in edges[node] {
        let next = edge.to
        guard dist[node] > dist[next] else { continue }
        routes[node] += findRoute(next)
    }
    return routes[node]
}

func solution() {
    dijkstra()
    print(findRoute(1))
}

solution()
