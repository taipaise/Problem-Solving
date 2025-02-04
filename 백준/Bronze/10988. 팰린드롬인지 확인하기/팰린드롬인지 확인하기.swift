import Foundation

let word = readLine()!

extension String {
    subscript(_ i: Int) -> Self {
        let target = index(startIndex, offsetBy: i)
        return String(self[target])
    }
}

func check(_ word: String) -> Bool {
    let count = word.count

    for i in 0..<count {
        guard word[i] == word[count - (1 + i)] else { return false }

    }

    return true
}

if check(word) {
    print(1)
} else {
    print(0)
}
