import Foundation

struct DisjointSet {
    private var parents: [Int]
    private var ranks: [Int]

    init(_ size: Int) {
        parents = (0...size).map { $0 }
        ranks = Array(repeating: 1, count: size + 1)
    }

    mutating func merge(_ u: Int, _ v: Int) {
        var u = find(u)
        var v = find(v)

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
        if parents[u] == u { return u }

        parents[u] = find(parents[u])
        return parents[u]
    }
}

struct Planet {
    let n: Int
    let x: Int
    let y: Int
    let z: Int

    init(_ n: Int, _ x: Int, _ y: Int, _ z: Int) {
        self.n = n
        self.x = x
        self.y = y
        self.z = z
    }
}

struct Edge {
    let start: Int
    let end: Int
    let cost: Int

    init(_ start: Int, _ end: Int, _ cost: Int) {
        self.start = start
        self.end = end
        self.cost = cost
    }
}

let number = Int(readLine()!)!
var planets = Array(repeating: Planet(0, 0, 0, 0), count: number)
var disjointSet = DisjointSet(number)
var res = 0
for i in 0..<number {
    let line = readLine()!.split(separator: " ").map { Int(String($0))! }
    planets[i] = Planet(i, line[0], line[1], line[2])
}

var sortedByX = planets.sorted(by: { $0.x < $1.x })
var sortedByY = planets.sorted(by: { $0.y < $1.y })
var sortedByZ = planets.sorted(by: { $0.z < $1.z })
var sortedEdges: [Edge] = []

for i in 0..<number - 1 {
    let diffX = abs(sortedByX[i].x - sortedByX[i + 1].x)
    let diffY = abs(sortedByY[i].y - sortedByY[i + 1].y)
    let diffZ = abs(sortedByZ[i].z - sortedByZ[i + 1].z)

    sortedEdges.append(Edge(
        sortedByX[i].n,
        sortedByX[i + 1].n,
        diffX))

    sortedEdges.append(Edge(
        sortedByY[i].n,
        sortedByY[i + 1].n,
        diffY))

    sortedEdges.append(Edge(
        sortedByZ[i].n,
        sortedByZ[i + 1].n,
        diffZ))
}
sortedEdges.sort(by: { $0.cost < $1.cost })

for edge in sortedEdges {
    guard disjointSet.find(edge.start) != disjointSet.find(edge.end) else { continue }

    res += edge.cost
    disjointSet.merge(edge.start, edge.end)
}

print(res)
