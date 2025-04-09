import Foundation

let numbers = readLine()!.split(separator: " ").map { Int64(String($0))! }
let a = numbers[0]
let b = numbers[1]

// a, b가 있을 때 a와 b의 최대공약수 d는 a와 a - b의 공약수와 같습니다. (a >= b)
// a = d * n (n은 자연수)
// b = d * m (m은 자연수)
// 이때 a - b = d*(n + m). 따라서 a - b역시 d로 나누어 떨어지는 것을 알 수 있습니다.
// 위 과정을 계속 반복하게 되면 gcd(a, b) = gcd(b, a % b) 인 것을 알 수 있다.

func gcd(_ a: Int64, _ b: Int64) -> Int64 {
    guard b > 0 else { return a }
    return gcd(b, a % b)
}

let count = a > b ? gcd(a, b) : gcd(b, a)
let res = Array(repeating: "1", count: Int(count)).joined()
print(res)