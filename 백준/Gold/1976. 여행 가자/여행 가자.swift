import Foundation

struct DisjointSet {
    private var parent: [Int]
    private var rank: [Int]

    init(_ n: Int) {
        parent = (0...n).map { $0 }
        rank = Array(repeating: 1, count: n + 1)
    }

    mutating func merge(_ u: Int, _ v: Int) {
        var u = find(u)
        var v = find(v)

        guard u != v else { return }

        if rank[u] > rank[v] { swap(&u, &v) }

        parent[u] = v

        if rank[u] == rank[v] { rank[v] += 1 }
    }

    mutating func find(_ u: Int) -> Int {
        if parent[u] == u { return u }

        parent[u] = find(parent[u])
        return parent[u]
    }
}

func solution() {
    let n = Int(readLine()!)!
    let _ = Int(readLine()!)!
    var edges: [[Int]] = []
    var cities: [Int] = []
    var disjointSet = DisjointSet(n)

    for _ in 0..<n {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! }
        edges.append(line)
    }

    cities = readLine()!.split(separator: " ").map { Int(String($0))! }

    for i in 0..<n {
        for j in 0..<n {
            guard edges[i][j] == 1 else { continue }
            disjointSet.merge(i + 1, j + 1)
        }
    }

    let parent = disjointSet.find(cities.first!)
    for city in cities {
        guard disjointSet.find(city) == parent else {
            print("NO")
            return
        }
    }

    print("YES")
}

solution()
