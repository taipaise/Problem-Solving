import Foundation

func solution() {
    let n = Int(readLine()!)!
    var numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
    let target = Int(readLine()!)!
    var lo = 0
    var hi = n - 1
    var res = 0

    guard n > 1 else {
        print(0)
        return
    }

    numbers.sort()

    while lo < hi {
        if numbers[hi] + numbers[lo] == target { res += 1 }

        if numbers[hi] + numbers[lo] < target {
            lo += 1
        } else {
            hi -= 1
        }
    }

    print(res)
}

solution()