import Foundation

let inputString = readLine()!
let treesString = readLine()!
let nm = inputString
    .split(separator: " ")
    .compactMap { Int($0)! }

let treeCount = nm[0]
let targetHeight = nm[1]
var trees = treesString
    .split(separator: " ")
    .compactMap { Int64($0)! }

func isSatisfy(_ height: Int64) -> Bool {
    var result: Int64 = 0
    
    result = trees
        .map { $0 > height ? $0 - height : 0 }
        .reduce(0, { $0 + $1 })

    return result >= targetHeight
}

func bs() -> Int64 {
    var lo: Int64 = 0
    var hi = trees.last! + 1
    var mid: Int64 = 0
    
    while lo + 1 < hi {
        mid = (lo + hi) >> 1
        
        if isSatisfy(mid) {
            lo = mid
        } else {
            hi = mid
        }
    }
    
    return lo
}

trees.sort()
print(bs())
