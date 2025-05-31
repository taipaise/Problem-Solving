import Foundation

var res: [[Int]] = []

func solution(_ n:Int) -> [[Int]] {
    hanoi(n, 1, 2, 3)
    return res
}

func hanoi (
    _ num: Int,
    _ from: Int,
    _ by: Int,
    _ dest: Int
) {
    if num == 1 {
        res.append([from, dest])
        return
    }
    
    hanoi(num - 1, from, dest, by)
    res.append([from, dest])
    hanoi(num - 1, by, from, dest)
}
