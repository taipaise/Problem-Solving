import Foundation

func solution(_ sequence:[Int]) -> Int64 {
    let sequence = sequence.map { Int64($0) }
    var result = Int64.min
    
    var sum1: Int64 = 0 // 1로 시작하는 펄스 부분 수열 합
    var sum2: Int64 = 0 // -1로 시작하는 펄스 부분 수열 합

    var min1: Int64 = 0
    var min2: Int64 = 0
    
    var pulse: Int64 = 1
    
    for number in sequence {
        sum1 += (number * pulse)
        sum2 += (number * -pulse)
        
        // 누적합 이용하여 최대 구간을 탐색
        result = max(
            result,
            sum1 - min1,
            sum2 - min2)
        
        min1 = min(min1, sum1)
        min2 = min(min2, sum2)
        
        pulse *= -1
    }
    
    return result
}