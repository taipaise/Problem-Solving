import Foundation

func solution() {
    while
        let input = readLine(),
        let count = Int(input)
    {
        guard count > 0 else { return }
        print(find(count))
    }
}

func find(_ layoutCount: Int) -> Int {
    let string = readLine()!.map { String($0) }
    var lo = 0
    var hi = 0
    var maxCount = 0
    var layout: [String: Int] = [:]

    while hi < string.count {
        let hiLetter = string[hi]
        layout[hiLetter, default: 0] += 1

        while layout.count > layoutCount {
            let loLetter = string[lo]
            layout[loLetter]! -= 1
            if layout[loLetter]! == 0 {
                layout[loLetter] = nil
            }
            lo += 1
        }

        maxCount = max(maxCount, hi - lo + 1)
        hi += 1
    }

    return maxCount
}

solution()
