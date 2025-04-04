import Foundation

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

func solve() {
    let _ = readLine()!
    let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
    var lis: [Int] = []

    for number in numbers {
        let index = findIndex(number, lis)

        if index == lis.count {
            lis.append(number)
        } else {
            lis[index] = number
        }
    }

    print(lis.count)
}

solve()
