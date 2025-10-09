import Foundation


func findIndex(_ n: Int, _ lis: [Int]) -> Int {
    var lo = -1
    var hi = lis.count

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        if lis[mid] < n {
            lo = mid
        } else {
            hi = mid
        }
    }
    return hi
}

func solution() {
    let n = Int(readLine()!)!
    let numbers = readLine()!.split(separator: " ").map { Int($0)! }

    var lis: [Int] = []
    var indices: [Int] = Array(repeating: -1, count: n)

    numbers.enumerated().forEach { (index, num) in
        let lisIndex = findIndex(num, lis)

        indices[index] = lisIndex

        if lisIndex == lis.count {
            lis.append(num)
        } else {
            lis[lisIndex] = num
        }
    }

    print(lis.count)
    var answer: [Int] = []
    var curLisIndex = lis.count - 1

    for i in stride(from: n - 1, through: 0, by: -1) {
        guard curLisIndex >= 0 else { break }

        let number = numbers[i]
        let lisIndex = indices[i]

        guard lisIndex == curLisIndex else { continue }

        answer.append(number)
        curLisIndex -= 1
    }

    print(answer.reversed().map { String($0) }.joined(separator: " "))
}

solution()
