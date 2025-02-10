import Foundation

enum Length: Int {
    case same = 0
    case shorter = -1
    case longer = 1
}

let targetArr = readLine()!.map { Int(String($0))! }
let target = targetArr.reduce(0) { $0 * 10 + $1 }
let currentChannel = 100
let brokenCount = Int(readLine()!)!
var brokens: [Int] = []
if brokenCount != 0 {
    brokens = readLine()!.split(separator: " ").map { Int(String($0))! }
}
var res = abs(target - currentChannel)
var availableSet = Set("0123456789".map { Int(String($0))! })
availableSet.subtract(Set(brokens))
let availables = Array(availableSet)

func calSize(_ num: Int) -> Int {
    var num = num
    var res = 1

    while num / 10 > 0 {
        res += 1
        num /= 10
    }

    return res
}

func find(_ candidate: [Int], _ type: Length) {
    let targetCount = max(targetArr.count + type.rawValue, 0)

    if targetCount == 0 { return }
    if candidate.count == targetCount {
        let number = candidate.reduce(0) { $0 * 10 + $1 }
        let tapCount = calSize(number)
        let curResult = abs(target - number)  + tapCount
        res = min(curResult, res)
        return
    }

    for i in 0..<availables.count {
        let newCandiate = candidate + [availables[i]]
        find(newCandiate, type)
    }
}

if availables.count > 0 {
    find([], .shorter)
    find([], .same)
    find([], .longer)
}

print(res)
