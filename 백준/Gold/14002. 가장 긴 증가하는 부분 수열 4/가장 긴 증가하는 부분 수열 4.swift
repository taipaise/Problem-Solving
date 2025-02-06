import Foundation

let n = Int(readLine()!)!

var nums = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }

var lis: [Int] = []
var records: [Int] = Array(repeating: n, count: n)

func findIndex(_ num: Int) -> Int {
    var lo = -1
    var hi = lis.count

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        // 숫자가 더 크면
        if lis[mid] < num {
            lo = mid
        } else {
            hi = mid
        }
    }

    return hi
}

for (index, num) in nums.enumerated() {
    let lisIndex = findIndex(num)
    records[index] = lisIndex

    if lisIndex == lis.count {
        lis.append(num)
    } else {
        lis[lisIndex] = num
    }
}

var prev = -1
var results: [Int] = []
var maxIndex = records.max()!

for i in 0..<records.count {
    let index = records.count - 1 - i
    if maxIndex == records[index] {
        results.append(nums[index])
        maxIndex -= 1
    }
}

results = results.reversed()

print(results.count)
for r in results {
    print(r, terminator: " ")
}

