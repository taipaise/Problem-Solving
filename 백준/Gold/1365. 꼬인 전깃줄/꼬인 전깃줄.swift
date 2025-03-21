import Foundation

// LIS 를 구하여 전체 전봇대 수에서 빼준다.

func findIndex(_ num: Int, _ lis: [Int]) -> Int {
    var lo = -1
    var hi = lis.count

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        if lis[mid] < num {
            lo = mid
        } else {
            hi = mid
        }
    }

    return hi
}

func solution() {
    let n = Int(readLine()!)!
    let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
    var lis: [Int] = []

    for num in numbers {
        let lisIndex = findIndex(num, lis)

        if lisIndex == lis.count {
            lis.append(num)
        } else {
            lis[lisIndex] = num
        }
    }

    print(n - lis.count)
}

solution()
