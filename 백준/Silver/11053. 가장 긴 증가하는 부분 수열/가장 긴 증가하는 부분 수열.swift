import Foundation

let n = Int(readLine()!)!

let nums = readLine()!.split(separator: " ").map { Int(String($0))! }
var lis: [Int] = []

func findIndex(_ target: Int) -> Int {
    var lo = -1
    var hi = lis.count

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        if lis[mid] < target {
            lo = mid
        } else {
            hi = mid
        }
    }

    return hi
}

for num in nums {
    let index = findIndex(num)

    if index == lis.count {
        lis.append(num)
    } else {
        lis[index] = num
    }
}

print(lis.count)
