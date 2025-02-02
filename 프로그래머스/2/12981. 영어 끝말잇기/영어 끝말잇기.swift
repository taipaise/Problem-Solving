import Foundation

func check(_ cur: String, _ prev: String, _ records: Set<String>) -> Bool {
    guard
        cur.count > 1,
        !records.contains(cur)
    else { return false }

    return cur.first == prev.last
}

func solution(_ n: Int, _ words: [String]) -> [Int] {
    var curSeq = 0 // 현재 순서
    var isSurvive = Array(repeating: true, count: n) // 생존 여부 배열
    var prev = words.first!
    var records: Set<String> = [prev]
    var result: [Int] = []
    
    for word in words.dropFirst() {
        curSeq += 1

        guard isSurvive[(curSeq - 1) % n] else { continue }
        
        let canSurvive = check(word, prev, records)
        
        if !canSurvive {
            result.append(curSeq % n + 1)
            result.append(curSeq / n + 1)
            return result
        }
        
        records.insert(word)
        prev = word
    }
    
    return [0, 0]
}