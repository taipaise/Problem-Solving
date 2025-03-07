import Foundation

struct Heap<T: Comparable> {
    private var heap: [T?] = [nil]
    var count: Int {
        return heap.count - 1
    }
    var peek: T? {
        guard !isEmpty else { return nil }
        return heap[1]
    }
    var isEmpty: Bool {
        return heap.count <= 1
    }

    mutating func insert(_ element: T) {
        heap.append(element)
        heapifyUp()
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        heap.swapAt(1, heap.count - 1)
        defer { heapifyDown() }
        return heap.removeLast()
    }

    private mutating func heapifyUp() {
        var index = heap.count - 1

        while
            index > 1,
            let child = heap[index],
            let parent = heap[index / 2],
            parent > child
        {
            heap.swapAt(index, index / 2)
            index /= 2
        }
    }

    private mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var minIndex = index * 2

            if
                minIndex + 1 < heap.count,
                let left = heap[minIndex],
                let right = heap[minIndex + 1],
                left > right
            { minIndex += 1 }

            guard
                let parent = heap[index],
                let child = heap[minIndex],
                parent > child
            else { return }

            heap.swapAt(index, minIndex)
            index = minIndex
        }
    }
}

struct Time: Comparable {
    let start: Int
    let end: Int

    static func <(_ lhs: Time, _ rhs: Time) -> Bool {
        if lhs.end != rhs.end {
            return lhs.end < rhs.end
        }
        return lhs.start < rhs.start
    }
}

let n = Int(readLine()!)!
var times: [Time] = []
var res = 0

for _ in 0..<n {
    let input = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    times.append(Time(
        start: input[0],
        end: input[1]))
}

times.sort {
    if $0.start != $1.start {
        return $0.start < $1.start
    }
    return $0.end < $1.end
}

var heap = Heap<Int>()

for time in times {
    while
        let endTime = heap.peek,
        endTime <= time.start
    { _ = heap.pop() }

    heap.insert(time.end)
    res = max(res, heap.count)
}

print(res)
