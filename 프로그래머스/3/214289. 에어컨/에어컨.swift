import Foundation

//dp[i][j] = i분에 j온도를 유지할 때 사용하는 최소 에너지의 양

let MAX_ENERGY = 10000000
let MIN_TEMP = 0
let MAX_TEMP = 50

func inRange(t1: Int, t2: Int, curT: Int) -> Bool {
    return t1 <= curT && curT <= t2
}

func solution(
    _ temperature:Int,
    _ t1:Int,
    _ t2:Int,
    _ a:Int,
    _ b:Int,
    _ onboard:[Int]
) -> Int {
    let count = onboard.count
    let temp = temperature + 10
    let _t1 = t1 + 10
    let _t2 = t2 + 10
    var dp: [[Int]] = Array(repeating: Array(repeating: MAX_ENERGY, count: MAX_TEMP + 1),
                            count: count)
    dp[0][temp] = 0
    
    for i in 1..<count {
        let isBoarding = onboard[i] == 1
        
        for j in 0..<(MAX_TEMP + 1) {
            if 
                isBoarding,
                !inRange(t1: _t1, t2: _t2, curT: j)
            { 
                dp[i][j] = MAX_ENERGY
                continue
            }
            
            var tempUp = a
            var tempDown = a
            var tempSame = b
            
            
            if j - 1 >= MIN_TEMP { 
                if j - 1 < temp {
                    tempUp = 0
                }
                
                dp[i][j] = min(dp[i][j], dp[i - 1][j - 1] + tempUp)
            }
            
            if j + 1 <= MAX_TEMP {
                if j + 1 > temp {
                    tempDown = 0
                }
                
                dp[i][j] = min(dp[i][j], dp[i - 1][j + 1] + tempDown)
            }
            
            if j == temp {
                tempSame = 0
            }
            dp[i][j] = min(dp[i][j], dp[i - 1][j] + tempSame)
        }
    }
    
    let result = dp[count - 1].min()!
    return result
}