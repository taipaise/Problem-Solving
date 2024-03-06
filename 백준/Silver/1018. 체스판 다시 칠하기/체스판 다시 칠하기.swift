import Foundation

let input = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = input.first!
let m = input.last!
var res = 64
var board: [[String]] = Array(repeating: [], count: n)

for i in 0..<n {
    board[i] = Array(readLine()!.map { String($0) })
}

func getCount(start_y: Int, start_x: Int, startColor: String) {
    var sum = 0
    
    for y in 0...7 {
        for x in 0...7 {
            let location = y + x
            
            if location % 2 == 0 {
                if board[start_y + y][start_x + x] != startColor { sum += 1 }
            } else {
                if board[start_y + y][start_x + x] == startColor { sum += 1 }
            }
        }
    }
    res = min(res, sum)
}

for y in 0...n - 8 {
    for x in 0...m - 8 {
        getCount(start_y: y, start_x: x, startColor: "W")
        getCount(start_y: y, start_x: x, startColor: "B")
    }
}

print(res)
