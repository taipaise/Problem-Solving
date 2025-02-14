import Foundation

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
    let x: Int
    let time: Int
}

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }

let n = numbers[0]
let k = numbers[1]
let maxX = max(n, k) * 2
var visited = Array(repeating: Int.max, count: maxX + 1)

func bfs(_ start: Pos) -> Int {
    var queue = Queue<Pos>()
    visited[start.x] = 0
    queue.push(start)
    var count = 0

    while !queue.isEmpty {
        guard let pos = queue.pop() else { return count }

        let x = pos.x
        let time = pos.time

        if x == k {
            count += 1
            continue
        }


        for nx in [x - 1, x + 1, x * 2] {
            guard
                0 <= nx && nx <= maxX,
                time + 1 <= visited[nx]
            else { continue }

            visited[nx] = time + 1
            queue.push(Pos(x: nx, time: time + 1))
        }
    }

    return count
}

let route = bfs(Pos(x: n, time: 0))
print(visited[k], route, separator: "\n")
