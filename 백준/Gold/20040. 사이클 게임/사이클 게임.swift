import Foundation

struct DisjointSet {
    private var parents: [Int] = []
    private var ranks: [Int] = []

    init(_ n: Int) {
        parents = (0...n).map { $0 }
        ranks = Array(repeating: 1, count: n + 1)
    }

    mutating func merge(_ u: Int, _ v: Int) {
        var (u, v) = (find(u), find(v))

        if u == v { return }

        if ranks[u] > ranks[v] {
            swap(&u, &v)
        }

        parents[u] = v

        if ranks[u] == ranks[v] {
            ranks[v] += 1
        }
    }

    mutating func find(_ u: Int) -> Int {
        guard parents[u] != u else { return u }

        parents[u] = find(parents[u])
        return parents[u]
    }
}

func solution() {
    let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
    let vertexCount = numbers[0]
    let turnCount = numbers[1]
    var disjointSet = DisjointSet(vertexCount)
    var turn = 0

    for _ in 0..<turnCount {
        turn += 1
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        
        if disjointSet.find(input[0]) == disjointSet.find(input[1]) {
            print(turn)
            return
        } else {
            disjointSet.merge(input[0], input[1])
        }
    }
    print(0)
}


solution()
