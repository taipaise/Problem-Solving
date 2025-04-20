import Foundation

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }

let a = numbers[0]
let b = numbers[1]
let c = numbers[2]
var powers: [Int: Int] = [:]


func mult(_ power: Int) -> Int {
    if power == 0 {
        return 1
    }

    if power == 1 {
        return a % c
    }

    if let record = powers[power] {
        return record
    }

    let res = (mult(power / 2) * mult(power - (power / 2))) % c
    powers[power] = res

    return res
}

print(mult(b))
