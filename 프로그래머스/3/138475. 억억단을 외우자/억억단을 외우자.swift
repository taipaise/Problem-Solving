import Foundation
var dic: [Int: Int] = [:]
var offset = 1000000000
var divisorCount = 0
var checkedOffset = 1000000000

func makeDic(from startNum: Int, to endNum: Int, _ divisors: [Int]) {
      for i in stride(from: endNum, through: startNum, by: -1) {
          guard divisorCount <= divisors[i] else { 
              dic[i] = offset
              continue
          }
        
          divisorCount = divisors[i]
          offset = i
          dic[i] = offset
      }
}

func solution(_ e:Int, _ starts:[Int]) -> [Int] {
    offset = e
    checkedOffset = e
    var res: [Int] = []
    var divisors = Array(repeating: 0, count: e + 1)
    
    let startNum = starts.min() ?? 1
    
    for i in 1...e {
        for j in 1...(e / i) {
            divisors[i * j] += 1
        }
    }

    starts.forEach { 
        if dic[$0] == nil {
            makeDic(from: $0, to: checkedOffset, divisors)
            checkedOffset = $0
        }
        res.append(dic[$0]!)
    }

    return res
}