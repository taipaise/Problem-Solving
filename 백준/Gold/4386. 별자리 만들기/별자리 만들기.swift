import Foundation

// mst 문제
// 100 * 100의 간선 거리를 먼저 구한다
// 좌표를 일단 정수로 처리!! 추후 거리 계산 시 10000으로 나누고, 다시 제곱근을 구해줘야 함
//

struct Star {
    let id: Int
    let x: Double
    let y: Double

    init (_ id: Int, _ x: Double, _ y: Double) {
        self.id = id
        self.x = x
        self.y = y
    }
}

struct Edge: Comparable {
    let start: Int
    let end: Int
    let dist: Double

    init(_ s: Int, _ e: Int, _ d: Double) {
        start = s
        end = e
        dist = d
    }

    static func <(lhs: Edge, rhs: Edge) -> Bool {
        return lhs.dist < rhs.dist
    }
}

struct DisjointSet {
    private var parents: [Int]
    private var ranks: [Int]

    init(_ n: Int) {
        parents = Array(repeating: -1, count: n + 1)
        ranks = Array(repeating: 1, count: n + 1)

        for i in 0...n {
            parents[i] = i
        }
    }

    mutating func merge(_ u: Int, _ v: Int) {
        var u = find(u)
        var v = find(v)

        // 부모가 같으면 이미 같은 집합
        guard u != v else { return }

        // rank 최적화
        if ranks[u] > ranks[v] {
            swap(&u, &v)
        }

        // 한 집합으로 합침
        parents[u] = parents[v]

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
    let n = Int(readLine()!)!
    var stars: [Star] = []
    var edges: [Edge] = []

    // 별 입력받기
    for i in 0..<n {
        let inputs = readLine()!.split(separator: " ").map { Double($0)! }
        stars.append(Star(i, inputs[0], inputs[1]))
    }

    // 각 성간 거리 구하기
    for i in 0..<n {
        for j in (i + 1)..<n {
            if i == j { continue }

            let dist: Double = calcDist(star1: stars[i], star2: stars[j])
            let edge: Edge = .init(stars[i].id, stars[j].id, dist)
            edges.append(edge)
        }
    }

    // kruskal 통해 mst 구하기
    var answer: Double = 0
    var disjointSet = DisjointSet(n)

    edges.sort()

    for edge in edges {
        let start = edge.start
        let end = edge.end

        // 이미 연결되어 있음
        if disjointSet.find(start) == disjointSet.find(end) { continue }

        // 연결되어 있지 않으면 가중치 누적 후 합치기
        answer += edge.dist
        disjointSet.merge(start, end)
    }

    print(answer)
}

func calcDist(star1: Star, star2: Star) -> Double {
    let distX = (star2.x - star1.x) * (star2.x - star1.x)
    let distY = (star2.y - star1.y) * (star2.y - star1.y)

    return sqrt(distX + distY)
}

solution()
