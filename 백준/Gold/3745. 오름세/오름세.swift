import Foundation


func findIndex(_ lis: [Int], _ num: Int) -> Int {
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

func findLisLength(_ numbers: [Int]) -> Int {
    var lis: [Int] = []

    for number in numbers {
        let index = findIndex(lis, number)

        if index == lis.count {
            lis.append(number)
        } else {
            lis[index] = number
        }
    }

    return lis.count
}


func solution() {

    while let _ = readLine() {
        let numbers = readLine()!.split(whereSeparator: { $0.isWhitespace} ).map { Int(String($0))! }
        print(findLisLength(numbers))
    }
}

solution()
