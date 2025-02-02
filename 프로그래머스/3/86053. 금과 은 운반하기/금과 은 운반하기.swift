import Foundation

func check(
    _ goal: Int64,
    _ gold_r: Int64,
    _ silver_r: Int64,
    _ golds: [Int64],
    _ silvers: [Int64],
    _ weights: [Int64],
    _ times: [Int64]
) -> Bool {
    var totalWeight: Int64 = 0
    var totalGold: Int64 = 0
    var totalSilver: Int64 = 0
    
    for city in 0..<times.count {
        var moveCount = goal / (times[city] * 2) // 왕복으로 갈 수 있는 횟수
        if (goal - moveCount * times[city] * 2) >= times[city] { // 목표시간 - 왕복 시간이 time[city]보다 크면 편도 이동 가능
            moveCount += 1
        }
        var maxGold = min(weights[city] * moveCount, golds[city])
        var maxSilver = min(weights[city] * moveCount, silvers[city])
        totalGold += maxGold
        totalSilver += maxSilver
        totalWeight += min(weights[city] * moveCount, golds[city] + silvers[city])
    }
    
    return totalGold >= gold_r
        && totalSilver >= silver_r
        && totalWeight >= (gold_r + silver_r)
}

func solution(
    _ a: Int,
    _ b: Int,
    _ g: [Int],
    _ s: [Int],
    _ w: [Int],
    _ t: [Int]
) -> Int64 {
    let gold_r = Int64(a)
    let silver_r = Int64(b)
    let golds = g.map { Int64($0) }
    let silvers = s.map { Int64($0) }
    let weights = w.map { Int64($0) }
    let times = t.map { Int64($0) }
    
    var lo: Int64 = 0
    var hi: Int64 = 400000000000000

    
    while lo + 1 < hi {
        let mid = (lo + hi) >> 1
    
        let isPossible = check(
            mid,
            gold_r,
            silver_r,
            golds,
            silvers,
            weights,
            times)
        
        if isPossible {
            hi = mid   
        } else {
            lo = mid
        }
    }
    
    return hi
}