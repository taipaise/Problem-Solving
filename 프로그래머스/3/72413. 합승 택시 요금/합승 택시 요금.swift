import Foundation

// 플로이드 워셜을 사용해 모든 간선에서 간선까지의 가중치를 구함
// 각자 택시를 탄 경우와, 특정지점까지 택시를 탄 이후 해당 지점에서 각자 집을 가는 경우를 모두 비교

var dist: [[Int]] = []

func floyd(_ n: Int) {
    for sub in 1...n {
        for start in 1...n {
            for dest in 1...n {
                dist[start][dest] = min(
                    dist[start][dest],
                    dist[start][sub] + dist[sub][dest])
            }
        }
    }
}

func findCheapest(
    _ n: Int,
    _ start: Int,
    _ destA: Int,
    _ destB: Int
) -> Int {
    var minPrice = dist[start][destA] + dist[start][destB]
    
    for sub in 1...n {
        let totalPrice = dist[start][sub] + dist[sub][destA] + dist[sub][destB]
        minPrice = min(minPrice, totalPrice)
    }
    
    return minPrice
}

func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    dist = Array(
        repeating: Array(repeating: 999999, count: n + 1),
        count: n + 1)

    for i in 1...n {
        dist[i][i] = 0
    }
    
    for fare in fares {
        dist[fare[0]][fare[1]] = fare[2]
        dist[fare[1]][fare[0]] = fare[2]
    }
    
    floyd(n)
    
    return findCheapest(n, s, a, b)
}

