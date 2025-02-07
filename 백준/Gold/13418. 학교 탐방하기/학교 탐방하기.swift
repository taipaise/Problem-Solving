import Foundation

struct DisjointSet {
    var parent: [Int]
    var rank: [Int]

    init(_ n: Int) {
        parent = Array(repeating: 0, count: n + 1)
        rank = Array(repeating: 1, count: n + 1)

        for i in 0...n {
            parent[i] = i
        }
    }

    mutating func merge(_ u: Int, _ v: Int) {
        var u = find(u)
        var v = find(v)

        guard parent[u] != parent[v] else { return }

        if rank[u] > rank[v] {
            swap(&u, &v)
        }

        parent[u] = parent[v]

        if rank[u] == rank[v] {
            rank[v] += 1
        }
    }

    mutating func find(_ u: Int) -> Int {
        if parent[u] == u  {
            return u
        }

        parent[u] = find(parent[u])
        return parent[u]
    }
}

struct Edge: Comparable {
    var start: Int
    var end: Int
    var weight: Int

    init (_ s: Int, _ e: Int, _ w: Int) {
        start = s
        end = e
        weight = w * -1
    }

    static func <(_ lhs: Edge, _ rhs: Edge) -> Bool {
        return lhs.weight < rhs.weight
    }
}

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let n = numbers[0]
let m = numbers[1]
var edges: [Edge] = []


var minST = DisjointSet(n)
var maxST = DisjointSet(n)

let startEdgeInput = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let startEdge = Edge(startEdgeInput[0], startEdgeInput[1], startEdgeInput[2])

for _ in 0..<m {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }
    let edge = Edge(line[0], line[1], line[2])
    edges.append(edge)
}

var edgeMins = edges.sorted()
var edgeMaxs = Array(edgeMins.reversed())

func makeMin() -> Int {
    var totalWeight = 0

    for edge in edgeMins {
        let start = edge.start
        let end = edge.end
        let weight = edge.weight

        guard minST.find(start) != minST.find(end) else { continue }
        minST.merge(start, end)
        totalWeight += weight
    }

    totalWeight *= -1
    // 총 간선의 수는 (n - 1)개
    let upperCount = (n - 1) - totalWeight

    return upperCount
}

func makeMax() -> Int {
    var totalWeight = 0

    for edge in edgeMaxs {
        let start = edge.start
        let end = edge.end
        let weight = edge.weight

        guard maxST.find(start) != maxST.find(end) else { continue }
        maxST.merge(start, end)
        totalWeight += weight
    }

    totalWeight *= -1

    // 총 간선의 수는 (n - 1)개
    let upperCount = (n - 1) - totalWeight
    return upperCount
}

var maxUpper = makeMax()
var minUpper = makeMin()

if startEdge.weight == 0 {
    maxUpper += 1
    minUpper += 1
}

print(maxUpper * maxUpper - minUpper * minUpper)
