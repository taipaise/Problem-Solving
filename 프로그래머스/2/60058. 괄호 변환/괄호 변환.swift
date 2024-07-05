import Foundation


func isCorrect(_ str: String) -> Bool {
    let strs = str.map { String($0) }
    var openCnt = 0
    var closeCnt = 0
    
    for element in strs {
        if element == "(" {
            openCnt += 1
        } else {
            closeCnt += 1
        }
        
        if openCnt < closeCnt { return false }
    }
    
    return openCnt == closeCnt
}

func separate(_ str: String) -> (String, String) {
        let strArr = str.map { String($0) }
    var openCnt = 0
    var closeCnt = 0
    var u = ""
    var v = ""
    var index = 0
    
    while true {
        if strArr[index] == "(" {
            openCnt += 1
            u += "("
        } else {
            closeCnt += 1
            u += ")"
        }
        index += 1
        if openCnt == closeCnt { break }
    }
    
    if index < strArr.count {
        for i in index..<strArr.count {
            v += strArr[i]
        }
    }
    
    return (u, v)
}

func reverseString(_ str: String) -> String {
    var strArr = str.map { String($0) }
    strArr.removeFirst()
    strArr.removeLast()
    
    return strArr.map {
        if $0 == "(" {
            return ")"
        } else {
            return "("
        }
    }.joined()
}

func convert(_ str: String) -> String {
    if str.isEmpty { return "" }

    let uv = separate(str)
    let u = uv.0
    let v = uv.1
    
    if isCorrect(u) {
        return u + convert(v)
    } else {
        var res = "(" + convert(v)
        res += ")"
        res += reverseString(u)
        return res
    }
}


func solution(_ p:String) -> String {
    return convert(p)
}