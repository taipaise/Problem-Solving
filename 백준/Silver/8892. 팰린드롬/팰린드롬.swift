import Foundation

let tc = Int(readLine()!)!

func solution() {
    let count = Int(readLine()!)!

    var candidates: [String] = []
    for _ in 0..<count {
        candidates.append(readLine()!)
    }

    for i in 0..<candidates.count {
        for j in 0..<candidates.count {
            guard i != j else { continue }

            let target = candidates[i] + candidates[j]

            if isPelindrome(target) {
                print(target)
                return
            }
        }
    }

    print(0)
}


for _ in 0..<tc {
    solution()
}

func isPelindrome(_ str: String) -> Bool {
    let arr = str.map { String($0) }

    var isPelindrome = true

    for index in 0..<arr.count / 2 {
        guard arr[index] == arr[arr.count - 1 - index] else {
            isPelindrome = false
            break
        }
    }
    return isPelindrome
}

