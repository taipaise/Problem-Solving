import Foundation
var result: [[Int]] = []

func move(_ n: Int, _ start: Int, _ sub: Int, _ end: Int) {
    if n == 1 {
        // 가장 아래에 있는 원판(n)을 도착점으로 이동
        result.append([start, end])
        return
    }
    
    // 1. 아래에서 두번째 ~ 맨 위의 원반을 시작점에서 도착점을 경유하여 경유지로 옮김
    move(n - 1, start, end, sub)
    
    // 가장 아래에 있는 원판(n)을 도착지로 이동시킨다.
    result.append([start, end])
    
    // 1번에서 옮긴 나머지 원판들을 end로 옮김
    move(n - 1, sub, start, end)
}

func solution(_ n:Int) -> [[Int]] {
    move(n, 1, 2, 3)
    return result
}