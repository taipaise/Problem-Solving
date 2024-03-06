import Foundation

let n = Int(readLine()!)!

var count = 0
var res = 666

func contains(str: Int) -> Bool {
    let chars = String(str).map{ String($0) }
    var isDevil = 0
    
    for i in 0..<chars.count {
        if chars[i] == "6" {
            isDevil += 1
        } else {
            isDevil = 0
        }
        
        if isDevil == 3 { return true }
    }
    
    return false
}

while count != n {
    if contains(str: res) {
        count += 1
    }
    res += 1
}

print(res - 1)
