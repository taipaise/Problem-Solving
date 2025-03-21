import Foundation

func findLisIndex(_ lis: [Int], _ number: Int) -> Int {
    var lo = -1
    var hi = lis.count

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        if lis[mid] < number {
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
    var lisIndexRecord = Array(repeating: 0, count: n)

    for (index, number) in numbers.enumerated() {
        let lisIndex = findLisIndex(lis, number)
        lisIndexRecord[index] = lisIndex

        if lis.count == lisIndex {
            lis.append(number)
        } else {
            lis[lisIndex] = number
        }
    }

    // lis 길이
    print(lis.count)


    // lis 역추적하기
    var result: [Int] = []
    var curLisIndex = lisIndexRecord.max()!

    for i in stride(from: n - 1, through: 0, by: -1) {
        guard curLisIndex >= 0 else { break }

        if curLisIndex == lisIndexRecord[i] {
            result.append(numbers[i])
            curLisIndex -= 1
        }
    }

    print(result.reversed().map { "\($0)" }.joined(separator: " "))
}

solution()
