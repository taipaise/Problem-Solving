import Foundation

func fibo(_ n: Int, _ cur: Int, _ next: Int) -> Int {
    if n == 0 { return cur }
    return fibo(n - 1, next, cur + next)
}

print(fibo(Int(readLine()!)!, 0, 1))