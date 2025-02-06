import Foundation

struct Pos {
    let y: Int
    let x: Int
}

var homes: [Pos] = []
var chickens: [Pos] = []
var selected: [Pos] = []
var n: Int = 0
var m: Int = 0
var result = Int.max

func input() {
    let numbers = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    n = numbers.first!
    m = numbers.last!

    for y in 0..<n {
        let line = readLine()!
            .split(separator: " ")
            .map { Int(String($0))! }

        for (x, num) in line.enumerated() {
            if num == 2 {
                let chicken = Pos(y: y, x: x)
                chickens.append(chicken)
            } else if num == 1 {
                let home = Pos(y: y, x: x)
                homes.append(home)
            }
        }
    }
}

func getDist(_ pos1: Pos, _ pos2: Pos) -> Int {
    return abs(pos1.y - pos2.y) + abs(pos1.x - pos2.x)
}

func checkDist() -> Int {
    var totalDist = 0

    for home in homes {
        var minDist = Int.max
        for chicken in selected {
            minDist = min(minDist, getDist(home, chicken))
        }
        totalDist += minDist
    }

    return totalDist
}

// 재귀적으로 치킨집 m개 선택
func select(_ index: Int) {

    // 종료 조건
    if selected.count == m {
        let dist = checkDist()
        result = min(result, dist)
        return
    }

    for i in index..<chickens.count {
        let chicken = chickens[i]

        selected.append(chicken)
        select(i + 1)
        selected.removeLast()
    }
}

// 입력 받음
input()
select(0)
print(result)
