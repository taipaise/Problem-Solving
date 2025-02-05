import Foundation

struct Computer: Comparable {
    let id: Int
    let endTime: Int

    static func <(_ lhs: Computer, _ rhs: Computer) -> Bool {
        if lhs.endTime != rhs.endTime {
            return lhs.endTime < rhs.endTime
        }
        return lhs.id < rhs.id
    }
}

struct Time: Comparable {
    let start: Int
    let end: Int

    static func <(_ lhs: Time, _ rhs: Time) -> Bool {
        if lhs.start != rhs.start {
            return lhs.start < rhs.start
        }
        return lhs.end < rhs.end
    }
}

struct PriorityQueue<T: Comparable> {
    private var heap: Heap<T>
    var isEmpty: Bool {
        return heap.isEmpty
    }
    var front: T? {
        return heap.peek
    }
    var count: Int {
        return heap.count
    }

    init(_ e: T) {
        heap = Heap(e)
    }

    mutating func push(_ e: T) {
        heap.insert(e)
    }

    mutating func pop() -> T? {
        return heap.pop()
    }
}

struct Heap<T: Comparable> {
    private var heap: [T]
    var isEmpty: Bool {
        return heap.count <= 1
    }
    var count: Int {
        return heap.count - 1
    }
    var peek: T? {
        if isEmpty { return nil }
        return heap[1]
    }

    init(_ element: T) {
        heap = [element, element]
    }

    mutating func insert(_ e: T) {
        heap.append(e)
        heapifyUp()
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }

        heap.swapAt(1, heap.count - 1)
        let result = heap.removeLast()
        heapifyDown()

        return result
    }

    mutating func heapifyUp() {
        var index = heap.count - 1
        while
            index > 1,
            heap[index / 2] > heap[index]
        {
            heap.swapAt(index, index / 2)
            index = index / 2
        }
    }

    mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var minIndex = index * 2

            if
                minIndex + 1 < heap.count,
                heap[minIndex] > heap[minIndex + 1]
            {
                minIndex += 1
            }

            guard heap[index] > heap[minIndex] else { return }

            heap.swapAt(index, minIndex)
            index = minIndex
        }
    }
}

let n = Int(readLine()!)!
var times: [Time] = []
var result: [Int: Int] = [:]

for _ in 0..<n {
    let input = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    let time = Time(start: input[0], end: input[1])
    times.append(time)
}

times.sort()

func isPossible(_ count: Int) -> Bool {
    var usedInfo: [Int: Int] = [:]

    // 사용 가능한 pc의 id를 idPq에 넣어줌
    var idPq = PriorityQueue<Int>(0)
    _ = idPq.pop()
    for id in 0..<count {
        idPq.push(id)
    }

    guard let firstId = idPq.pop() else { return false }
    var comPq = PriorityQueue<Computer>(Computer(
        id: firstId,
        endTime: times.first!.end))
    usedInfo[firstId, default: 0] += 1

    for time in times.dropFirst() {
        let startTime = time.start
        let endTime = time.end

        while
            let computer = comPq.front,
            computer.endTime < startTime
        {
            let computer = comPq.pop()!
            idPq.push(computer.id)
        }

        guard let id = idPq.pop() else { return false }

        usedInfo[id, default: 0] += 1
        comPq.push(Computer(id: id, endTime: endTime))
    }

    result = usedInfo
    return true
}

var lo = 0
var hi = n + 1

while lo + 1 < hi {
    let mid = (lo + hi) >> 1

    if isPossible(mid) {
        hi = mid
    } else {
        lo = mid
    }
}

print(hi)

for i in 0..<hi {
    print(result[i, default: 0], terminator: " ")
}
