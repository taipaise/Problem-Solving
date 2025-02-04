import Foundation

let numbers = readLine()!
    .components(separatedBy: " ")
    .map { Int($0)! }
let a = numbers[0]
let b = numbers[1]
let c = numbers[2]

func mul(_ count: Int) -> Int64 {
    if count == 1 {
        return Int64(a % c)
    }

    if count == 0 {
        return 1
    }

    let half = mul(count / 2)

    if count % 2 == 0 {
        return (half * half) % Int64(c)
    } else {
        return (half * half) % Int64(c) * Int64(a) % Int64(c)
    }
}

print(mul(b))
