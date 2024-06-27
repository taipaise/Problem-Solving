func intToString(_ i: Int, _ base: [String]) -> String {
    var res: [String] = []
    var num = i
    
    while num / base.count > 0 {
        let index = num % base.count
        res.append(base[index])
        num /= base.count
    }
    res.append(base[num])
    
    return res.reversed().joined()
}

func solution(_ n:Int, _ t:Int, _ m:Int, _ p:Int) -> String {
    var base = "0123456789ABCDEF".map { String($0) }
    
    base = Array(base[0..<n])
    var res: [String] = []
    var index = 0
    var number = -1
    
    while true {
        if res.count == t { break }
        number += 1
        let numberString = intToString(number, base).map { String($0) }
        var stringIndex = 0
        
        while stringIndex < numberString.count {
            if res.count == t { break }
            if index == p - 1 { res.append(numberString[stringIndex]) }
            stringIndex += 1
            index = (index + 1) % m
        }
    }

    return res.joined()
}
