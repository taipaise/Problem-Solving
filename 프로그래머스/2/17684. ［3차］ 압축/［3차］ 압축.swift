import Foundation

var dic: [String: Int] = [:]

func solution(_ msg:String) -> [Int] {
    let str = msg.map { return String($0) }
    let len = msg.count
    let alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { return String($0) }
    
    for i in 1...26 {
        dic[alpha[i - 1]] = i
    }
    var res: [Int] = []
    var dicIndex = 27
    var index = 0
    
    while index < len {
        var curLen = 1
        
        while index + curLen < len {
            let curStr = str[index..<index + curLen].joined()
            if dic[curStr] == nil { break }
            
            curLen += 1
        }
        
        var curStr = str[index..<index + curLen].joined()
        if dic[curStr] != nil {
            res.append(dic[curStr]!)
        } else {
            dic[curStr] = dicIndex
            curLen -= 1
            curStr.removeLast() 
            res.append(dic[curStr]!)
            dicIndex += 1
        }
        index += curLen
    }
    
    return res
}

