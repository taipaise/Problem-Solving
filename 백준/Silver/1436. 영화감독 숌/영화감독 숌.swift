import Foundation

let n = Int(readLine()!)!

var count = 0
var res = 666

func contains(num: Int) -> Bool {
    var nextNum = num
    
    while nextNum >= 666 {
        if nextNum % 1000 == 666 {
            return true
        }
        
        nextNum /= 10
    }
    
    return nextNum % 1000 == 666
}

while count != n {
    if contains(num: res) {
        count += 1
    }
    res += 1
}

print(res - 1)
