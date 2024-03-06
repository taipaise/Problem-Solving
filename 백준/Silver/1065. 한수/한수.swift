import Foundation

var n = Int(readLine()!)!
var res = 0

func isHansu(_ num: Int) -> Bool {
    let digits = String(num).compactMap { Int(String($0)) }
    
    guard digits.count > 1 else { return true }
    
    let d = digits[1] - digits[0]
    
    return digits
        .enumerated()
        .allSatisfy { index, digit in
            return index == 0 || digit - digits[index - 1] == d
        }
}

for i in 1...n {
    if isHansu(i) {
        res += 1
    }
}

print(res)
