import Foundation

func solvePuzzle(
    _ level: Int,
    _ diffs: [Int],
    _ times: [Int]
) -> Int {
    var totalTime = 0
    
    let firstIncorrectCount = max(diffs.first! - level, 0)
    let firstSolveTime = times.first! * (firstIncorrectCount + 1)
    var prevTime = times.first!
    totalTime = firstSolveTime

    let diffs = diffs.dropFirst()
    let times = Array(times.dropFirst())
    
    for (index, diff) in diffs.enumerated() {
        let incorrectCount = max(diff - level, 0)
        let curTime =  times[index] + incorrectCount * (prevTime + times[index])
        
        totalTime += curTime
        prevTime = times[index]
    }
    
    return totalTime
}

func solution(
    _ diffs:[Int],
    _ times:[Int], 
    _ limit:Int64
) -> Int {
    var hi = diffs.max()! + 1
    var lo = 0
    
    while lo + 1 < hi {
        let mid = (lo + hi)  >> 1
        
        if solvePuzzle(mid, diffs, times) <= limit {
            hi = mid
        } else {
            lo = mid
        }
    }
    
    return hi
}