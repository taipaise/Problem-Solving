import Foundation

let n = Int(readLine()!)!
var isPrime = Array(repeating: true, count: n + 1)
isPrime[0] = false
isPrime[1] = false

let maxSqrt = Int(sqrt(Double(n))) + 1
if 2 < maxSqrt {
    for i in 2..<maxSqrt {
        if isPrime[i] {
            var mul = 2
            while i * mul <= n {
                isPrime[i * mul] = false
                mul += 1
            }
        }
    }
}

let primes: [Int] = isPrime
    .enumerated()
    .filter { $0.1 }
    .map { $0.0 }
var lo = 0
var hi = 0
var res = 0
var curSum = 0

while lo < primes.count {
    if curSum == n { res += 1 }

    if curSum < n {
        if hi == primes.count { break }
        curSum += primes[hi]
        hi += 1
    } else {
        curSum -= primes[lo]
        lo += 1
    }
}

print(res)
