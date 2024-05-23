import Foundation

func solution(_ e:Int, _ starts:[Int]) -> [Int] {
    var res: [Int] = []
    var dic: [Int: Int] = [:]
    var divisors = Array(repeating: 0, count: e + 1)
    
    let startNum = starts.min() ?? 1
    
    for i in 1...e {
        for j in 1...(e / i) {
            divisors[i * j] += 1
        }
    }

    var offset = e
    var maxDivisorCount = 0
    for i in stride(from: e, through: 1, by: -1) {
        guard maxDivisorCount <= divisors[i] else { 
            dic[i] = offset
            continue
        }
        
        maxDivisorCount = divisors[i]
        offset = i
        dic[i] = offset
    }
    
    starts.forEach { res.append(dic[$0]!) }

    return res
}