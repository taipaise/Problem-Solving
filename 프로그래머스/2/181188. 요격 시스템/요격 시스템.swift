import Foundation

var sortedTargets: [[Int]] = []

func solution(_ targets:[[Int]]) -> Int {
    var result = 0
    
    var end = 0
    sortedTargets = targets.sorted(by: {$0[1] < $1[1]})
    
    sortedTargets.forEach {
        let start = $0[0]
        if start >= end {
            result += 1
            end = $0[1]
        }
    }
    
    return result
}