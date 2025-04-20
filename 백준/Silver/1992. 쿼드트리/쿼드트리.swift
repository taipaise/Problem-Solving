import Foundation

let number = Int(readLine()!)!
var boards: [[Int]] = []

for _ in 0..<number {
    let line = readLine()!.map{ Int(String($0))! }
    boards.append(line)
}

func compress(_ y: Int, _ x: Int, _ size: Int) -> String {
    if size == 1 {
        return "\(boards[y][x])"
    }

    let res = [
        compress(y, x, size / 2),
        compress(y, x + size / 2, size / 2),
        compress(y + size / 2, x, size / 2),
        compress(y + size / 2, x + size / 2, size / 2)
    ]

    if
        (res[0] == "1" || res[0] == "0"),
        res.allSatisfy({ $0 == res[0] })
    {
        return res[0]
    } else {
        return "(\(res.joined(separator: "")))"
    }
}


print(compress(0, 0, number))
