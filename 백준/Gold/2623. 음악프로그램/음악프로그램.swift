import Foundation

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0
    var isEmpty: Bool {
        return queue.count <= head
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

struct Node {
    let number: Int
    var inDegree: Int = 0
    var next: [Int] = []

    init(_ number: Int) {
        self.number = number
    }
}

func readNumbers() -> [Int] {
    return readLine()!.split(separator: " ").map { Int(String($0))! }
}

let numbers = readNumbers()
let singerCount = numbers[0]
let pdCount = numbers[1]
var singers: [Node] = (0...singerCount).map { Node($0) }
var queue = Queue<Node>()
var res: [Int] = []

for _ in 0..<pdCount {
    let input = readNumbers()

    guard input[0] > 1 else { continue }

    for i in 1...input[0] - 1 {
        singers[input[i]].next.append(input[i + 1])
        singers[input[i + 1]].inDegree += 1
    }
}


for singer in singers.dropFirst() {
    guard singer.inDegree == 0 else { continue }

    queue.push(singer)
}


while let singer = queue.pop() {
    res.append(singer.number)

    for nextSinger in singer.next {
        singers[nextSinger].inDegree -= 1

        if singers[nextSinger].inDegree == 0 {
            queue.push(singers[nextSinger])
        }
    }
}

if res.count == singerCount {
    for i in 0..<res.count {
        print(res[i])
    }
} else {
    print(0)
}
