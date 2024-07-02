var intersection: [String: Int] = [:]
var union: [String: Int] = [:]

func isAlpha(_ str: String) -> Bool {
    return "A" <= str && str <= "Z"
}

func convert(_ str: [String]) -> [String: Int] {
    var res: [String: Int] = [:]
    
    for i in 0..<str.count - 1 {
        
        guard
            isAlpha(str[i]),
            isAlpha(str[i + 1])
        else { continue }
        
        let curStr = str[i...i + 1].joined()
        
        if res[curStr] != nil {
            res[curStr]! += 1
        } else {
            res[curStr] = 1
        }
    }

    return res
}

func solution(_ str1:String, _ str2:String) -> Int {
    let strArr1 = str1.uppercased().map { String($0) }
    let strArr2 = str2.uppercased().map { String($0) }
    
    let convertedDic1 = convert(strArr1)
    let convertedDic2 = convert(strArr2)
    
    for str1 in convertedDic1 {
        let key = str1.key
        let value = str1.value
        
        if convertedDic2[key] != nil {
            let minValue = min(value, convertedDic2[key]!)
            let maxValue = max(value, convertedDic2[key]!)
            //교집합엔 최솟값
            intersection[key] = minValue
            //합집합에는 최댓값
            union[key] = maxValue
        } else {
            union[key] = value
        }
    }
    
    for str2 in convertedDic2 {
        let key = str2.key
        let value = str2.value
        
        if union[key] == nil {
            union[key] = value
        }
    }
    
    
    let intersectionCount = intersection.reduce(0) { $0 + $1.value }
    let unionCount = union.reduce(0) { $0 + $1.value }
    if unionCount == 0 { return 65536 }
    
    let res = Double(intersectionCount) / Double(unionCount) * 65536
    
    return Int(res)
}
