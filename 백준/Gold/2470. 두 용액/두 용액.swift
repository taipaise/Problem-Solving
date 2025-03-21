import Foundation

func solution() {
    let n = Int(readLine()!)!
    var numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
    var minValue = Int.max
    var lo = 0
    var hi = n - 1
    var res = [0, 0]

    numbers.sort()

    while lo < hi {
        let value = abs(numbers[lo] + numbers[hi])

        if value < minValue {
            minValue = value
            res = [numbers[lo], numbers[hi]]
        }


        if numbers[hi] + numbers[lo] >= 0 {
            hi -= 1
        } else {
            lo += 1
        }
    }

    print(res[0], res[1])
}

solution()
