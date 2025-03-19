import Foundation

// 물의 높이를 1부터 채운다. 채울 수 있는지 확인한다.
// 물의 높이가 h일 때, 방문할 수 있다 -> 밖으로 넘쳐 흐른다.
// 물은 높이가 낮은 칸으로만 흐른다. 벽의 높이가 물의 높이와 같아도 채울 수 없음
// visited 배열 -> 물의 높이로 표시한다. 벽의 높이가 물의 높이와 같아도 채울 수 없지만, visited 배열 재사용을 위해 visted[y][x] := (y, x)에서 채울 수 있는 최대 물의 높이 + 1 로 설정한다.
// 구현의 편의성을 위해 전체 수영장의 테두리에 땅을 나타내는 0 패딩을 추가하는 것이 좋겠다.


struct Queue<T> {
    private var queue: [T] = []
    private var head = 0
    var isEmpty: Bool {
        return head >= queue.count
    }

    mutating func push(_ element: T) {
        queue.append(element)
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        defer { head += 1 }
        return queue[head]
    }
}

struct Pos {
    let y: Int
    let x: Int
    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
let dy = [-1, 1, 0, 0]
let dx = [0, 0, -1, 1]

var pool: [[Int]] = Array(repeating: Array(repeating: 0, count: width + 2), count: height + 2)
var visited: [[Int]] = Array(repeating: Array(repeating: 0, count: width + 2), count: height + 2)

for y in 1...height {
    let line = readLine()!.map { Int(String($0))! }
    for x in 1...width {
        pool[y][x] = line[x - 1]
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height + 2 && 0 <= x && x < width + 2
}

// 채울 수 없는 칸들에 표시한다.
func fill(_ waterHeight: Int) {
    let start = Pos(0, 0)
    var queue = Queue<Pos>()
    queue.push(start)
    visited[start.y][start.x] = waterHeight

    while let pos = queue.pop() {
        let y = pos.y
        let x = pos.x

        for dir in 0..<4 {
            let ny = y + dy[dir]
            let nx = x + dx[dir]

            guard
                inRange(ny, nx),
                pool[ny][nx] < waterHeight, // 수영장 벽의 높이가 채우려는 물의 낮아야 함
                visited[ny][nx] < waterHeight // 방문한 적이 없어야 함
            else { continue }

            visited[ny][nx] = waterHeight
            queue.push(Pos(ny, nx))
        }
    }
    //visited에 waterHeight로 표시된 칸은 waterHeight만큼 채울 수 없는 칸들이다.
}

// waterHeight만큼 채울 수 있는 칸의 수
func calculate(_ waterHeight: Int) -> Int {
    var res = 0

    for y in 1...height {
        for x in 1...width {
            if visited[y][x] < waterHeight && pool[y][x] < waterHeight { res += 1 }
        }
    }

    return res
}


func solution() {
    var res = 0
    for waterHeight in 1...9 {
        fill(waterHeight)
        res += calculate(waterHeight)
    }

    print(res)
}

solution()