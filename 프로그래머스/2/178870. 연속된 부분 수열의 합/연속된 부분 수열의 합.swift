import Foundation
let MAX = 1000001

func solution(_ sequence:[Int], _ k:Int) -> [Int] {
    var count = sequence.count
    var len = MAX
    var lo = 0
    var hi = 0
    var startIndex = 0
    var sum = sequence[hi]
    
    while true {
        if 
            sum == k,
            hi - lo + 1 < len
        {
            len = hi - lo + 1
            startIndex = lo
        }
        
        if lo == count && hi == count { break }
        
        if
            sum <= k,
            hi < count
        {
            hi += 1
            if hi < count { sum += sequence[hi] }
        } else {
            if lo < count { sum -= sequence[lo] }
            lo += 1
        }
    }
    
    let endIndex = startIndex + len - 1
    return [startIndex, endIndex]
}