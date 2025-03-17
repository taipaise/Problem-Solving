import Foundation

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let wordCount = numbers[0]
let charCount = numbers[1] - 5
let alphabets = "abcdefghijklmnopqrstuvwxyz".map { $0 }
let necessaryToTeach = "acint"
let startAscii = Int(Character("a").asciiValue!)
var learned: Int = 0 // 배운 영단어를 기록하는 배열
var words: [Int] = Array(repeating: 0, count: wordCount)
var res = 0

func input() {


    for i in 0..<wordCount {
        let word = readLine()!
            .map { $0 }
            .dropFirst(4)
            .dropLast(4)

        var res = 0
        for char in word {
            let index = fetchIndex(char)
            res |= (1 << index)
        }

        words[i] = res
    }
}


func solution() {
    guard charCount >= 0 else { // 필수 글자는 배워야 글을 읽을 수 있음
        print(0)
        return
    }

    // 입력 받기
    input()

    // 필수 글자를 먼저 가르침
    for element in necessaryToTeach.map({ $0 }) {
        let index = fetchIndex(element)
        learned |= (1 << index)
    }

    // 재귀적으로 가르칠 글자를 고르기
    select(index: 0, count: 0)

    print(res)
}

func fetchIndex(_ char: Character) -> Int {
    return Int(char.asciiValue!) - startAscii
}

func select(index: Int, count: Int) {
    if count == charCount {
        res = max(res, check())
        return
    }

    for i in index..<alphabets.count {
        let alpha = alphabets[i]
        let alphaIndex = fetchIndex(alpha)
        guard learned & (1 << alphaIndex) == 0 else { continue } // 이미 집합에 포함되어 있으면 넘어가기

        learned |= (1 << alphaIndex) // 원소 추가
        select(index: i, count: count + 1) // 재귀적으로 탐색
        learned &= ~(1 << alphaIndex) // 원소 삭제
    }
}


func check() -> Int {
    var res = 0
    for word in words {
        if (learned & word) == word {
            res += 1
        }
    }
    return res
}

solution()
