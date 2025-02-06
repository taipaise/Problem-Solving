import Foundation

struct MinHeap<T: Comparable> {
    private var heap: [T?]
    var isEmpty: Bool {
        return heap.count < 2
    }
    var count: Int {
        return heap.count - 1
    }

    init() {
        heap = [nil]
    }

    mutating func insert(_ e: T) {
        heap.append(e)
        heapifyUp()
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }

        heap.swapAt(1, heap.count - 1)
        let res = heap.removeLast()

        heapifyDown()

        return res
    }

    mutating func heapifyUp() {
        var index = heap.count - 1

        while index > 1 {
            guard
                let current = heap[index],
                let parent = heap[index / 2],
                current < parent
            else { return }

            heap.swapAt(index, index / 2)
            index /= 2
        }
    }

    mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var minIndex = index * 2

            if
                minIndex + 1 < heap.count,
                let left = heap[minIndex],
                let right = heap[minIndex + 1],
                left > right
            {
                minIndex += 1
            }

            guard
                let current = heap[index],
                let child = heap[minIndex],
                current > child
            else { return }

            heap.swapAt(index, minIndex)
            index = minIndex
        }
    }
}

struct PriorityQueue<T: Comparable> {
    private var heap = MinHeap<T>()
    var isEmpty: Bool {
        return heap.isEmpty
    }
    var count: Int {
        return heap.count
    }

    mutating func push(_ e: T) {
        heap.insert(e)
    }

    mutating func pop() -> T? {
        return heap.pop()
    }
}

struct Pos: Comparable {
    let start: Int
    let end: Int

    static func < (_ lhs: Pos, _ rhs: Pos) -> Bool {
        if lhs.start != rhs.start {
            return lhs.start < rhs.start
        }

        return lhs.end > rhs.end
    }
}

var m = 0
var targetStart = 0
var targetEnd = 0
// 시작점이 작고, 길이가 길 수록 우선 순위가 높다
var lines = PriorityQueue<Pos>()

func input() {
    while
        let numString = readLine(),
        let num = Int(numString)
    {
        m = num
        executeCase()
    }
}

func executeCase() {
    lines = PriorityQueue<Pos>()
    targetStart = min(m, 0)
    targetEnd = max(m, 0)

    while let line = readLine() {
        guard line != "0 0" else {
            print(solve() ?? 0)
            return
        }

        let numbers = line
            .split(separator: " ")
            .map { Int(String($0))! }
        // 작은 것이 시작점, 큰 것이 끝점임
        let start = min(numbers[0], numbers[1])
        let end = max(numbers[0], numbers[1])

        if
            start >= targetEnd || // 시작점이 목표 끝점보다 크거나 작으면 답에 포함되지 않음
            end <= targetStart // 끝 점이 목표 시작점보다 같거나 작으면 답에 포함되지 않음,
        { continue }

        guard start < end else { continue } // 길이가 1 이상이어야 함

        lines.push(Pos(start: start, end: end))
    }
}

func solve() -> Int? { // 가능한 선분 갯수를 return
    var res = 0
    var prevEnd = targetStart

    // 우선 순위 큐가 비어있지 않고, 목표치 달성 못했으면 반복
    while
        let pos = lines.pop(),
        prevEnd < targetEnd
    {
        let start = pos.start
        let end = pos.end

        // 만약 시작점이 이전 끝점보다 크다면, 불가능함
        if start > prevEnd { return nil }

        // 시작점이 끝점보다 작다면, 겹치는 만큼 자르고 다시 우선 순위 큐에 넣음
        if start < prevEnd {
            guard prevEnd < end else { continue } // 자른 길이가 1 이상이어야 함

            let newPos = Pos(start: prevEnd, end: end)
            lines.push(newPos)
            continue
        }

        // 이전 끝점과 시작점이 같다면, 선분을 덮음
        prevEnd = end // 이전 끝점을 갱신
        res += 1
    }

    return targetEnd <= prevEnd ? res : nil
}

input()
