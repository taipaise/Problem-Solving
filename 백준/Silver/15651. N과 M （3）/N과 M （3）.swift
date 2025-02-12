import Foundation

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = numbers[0]
let targetCount = numbers[1]


func select(_ selected: String, _ count: Int) {
    if count == targetCount {
        print(selected)
        return
    }

    for i in 1...n {
        select(selected + "\(i) ", count + 1)
    }
}

select("", 0)
