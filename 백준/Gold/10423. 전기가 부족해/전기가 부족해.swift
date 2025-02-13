import Foundation

// 각 트리에는 발전소가 단 하나만 있어야 함. -> 각 발전소를 루트로 하자
// MST를 생성

struct DisjointSet {
    var parent: [Int] = []
    var height: [Int] = []

    init(_ size: Int) {
        parent = Array(0...size)
        height = Array(repeating: 1, count : size + 1)
    }

    mutating func mergeWithPower(_ power: Int, _ target: Int) {
        let target = find(target)

        guard target != power else { return }

        parent[target] = power

        if height[target] == height[power] {
            height[power] += 1
        }
    }

    mutating func merge(_ target1: Int, _ target2: Int) {
        var target1 = find(target1)
        var target2 = find(target2)

        // 이미 같은 그룹이면 return
        if target1 == target2 { return }

        // 트리의 높이가 낮은 걸 높은 것에다 붙인다
        if height[target1] > height[target2] {
            swap(&target1, &target2)
        }

        parent[target1] = target2

        if height[target1] == height[target2] {
            height[target2] += 1
        }
    }

    mutating func find(_ target: Int) -> Int {
        if parent[target] == target { return target }

        parent[target] = find(parent[target])

        return parent[target]
    }
}

struct Edge: Comparable {
    let from: Int
    let to: Int
    let weight: Int

    init(_ from: Int, _ to: Int, _ weight: Int) {
        self.from = from
        self.to = to
        self.weight = weight
    }

    static func < (_ lhs: Edge, _ rhs: Edge) -> Bool {
        return lhs.weight < rhs.weight
    }
}

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let n = numbers[0]
let m = numbers[1]
let k = numbers[2]
let powers = Set(readLine()!
    .split(separator: " ")
    .map { Int(String($0))! })
var edges: [Edge] = []
var disjointSet = DisjointSet(n)
var res = 0

for _ in 0..<m {
    let edgeInfo = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    edges.append(Edge(
        edgeInfo[0],
        edgeInfo[1],
        edgeInfo[2]))
}

edges.sort()

for edge in edges {
    guard
        disjointSet.find(edge.from) != disjointSet.find(edge.to)
    else { continue }

    let isFromPower = powers.contains(disjointSet.find(edge.from))
    let isToPower = powers.contains(disjointSet.find(edge.to))

    if isFromPower && isToPower { continue }

    if isFromPower {
        disjointSet.mergeWithPower(edge.from, edge.to)
    } else if isToPower {
        disjointSet.mergeWithPower(edge.to, edge.from)
    } else {
        disjointSet.merge(edge.from, edge.to)
    }

    res += edge.weight
}

print(res)
