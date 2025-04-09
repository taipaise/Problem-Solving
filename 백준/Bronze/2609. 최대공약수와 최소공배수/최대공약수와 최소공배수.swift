import Foundation

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let a = numbers[0]
let b = numbers[1]

func gcd(_ a: Int, _ b: Int) -> Int {
    guard b > 0 else { return a }
    return gcd(b, a % b)
}

let greatestCommonDivision = a > b ? gcd(a, b) : gcd(b, a)
print(greatestCommonDivision)
print(a * b / greatestCommonDivision)
