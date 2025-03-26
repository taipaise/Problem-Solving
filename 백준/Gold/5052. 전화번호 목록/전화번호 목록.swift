import Foundation

func solution() -> Bool {
    let numberCount = Int(readLine()!)!
    var numbers: [String] = []

    for _ in 0..<numberCount {
        numbers.append(readLine()!)
    }

    numbers.sort()

    for i in 0..<numberCount - 1 {
        if numbers[i + 1].hasPrefix(numbers[i]) { return false }
    }
    return true
}

func start() {
    let tc = Int(readLine()!)!

    for _ in 0..<tc {
        if solution() {
            print("YES")
        } else {
            print("NO")
        }
    }
}

start()
