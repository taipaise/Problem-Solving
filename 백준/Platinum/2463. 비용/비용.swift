import Foundation

// 최대 신장 트리를 구성한다.
// u와 v사이의 경로를 모두 더한 합에서, u와 v를 잇는데 사용된 최대 신장 트리의 비용을 제거한다.

struct Edge: Comparable {
    let start: Int
    let end: Int
    let dist: Int

    init(_ s: Int, _ e: Int, _ d: Int) {
        start = s
        end = e
        dist = d
    }

    static func <(lhs: Edge, rhs: Edge) -> Bool {
        return lhs.dist > rhs.dist
    }
}

struct DisjointSet {
    private var parents: [Int] = []
    private var ranks: [Int] = []
    private var sizes: [Int] = []

    init(_ n: Int) {
        parents = Array(repeating: -1, count: n + 1)
        ranks = Array(repeating: 1, count: n + 1)
        sizes = Array(repeating: 1, count: n + 1)

        for i in 0...n {
            parents[i] = i
        }
    }

    mutating func find(_ u: Int) -> Int {
        if parents[u] == u { return u }

        parents[u] = find(parents[u])
        return parents[u]
    }

    // 합쳐진 그룹에 속한 정점 쌍의 수 반환
    mutating func merge(_ u: Int, _ v: Int) -> Int {
        var u = find(u)
        var v = find(v)

        if u == v { return 0 }

        if ranks[u] > ranks[v] {
            swap (&u, &v)
        }

        parents[u] = parents[v]

        let pairs = Int((Int64(sizes[u]) * Int64(sizes[v])) % Int64(1e9))
        sizes[v] += sizes[u]

        if ranks[u] == ranks[v] {
            ranks[v] += 1
        }

        return pairs
    }
}

let inputs = readLine()!.split(separator: " ").map { Int($0)! }
let n = inputs[0]
let m = inputs[1]
var cost = 0
var answer = 0
var edges: [Edge] = []
var totalPairs = 0

for _ in 0..<m {
    let inputs = readLine()!.split(separator: " ").map { Int($0)! }

    let edge = Edge(inputs[0], inputs[1], inputs[2])
    edges.append(edge)

    cost += edge.dist
}

edges.sort()

// 최대 신장 트리 구성
var disjointSet = DisjointSet(n)

for edge in edges {
    let start = edge.start
    let end = edge.end
    let dist = edge.dist
    let pairs = disjointSet.merge(start, end)

    answer += Int((Int64(cost) * Int64(pairs)) % Int64(1e9))
    cost -= dist
}

print(answer % Int(1e9))
