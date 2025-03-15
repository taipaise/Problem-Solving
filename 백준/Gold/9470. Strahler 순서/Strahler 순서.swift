import Foundation

// 위상 정렬
// 진입차수가 적은 것부터 일단 처리한다.
// 진입 차수가 0인것 부터 처리하면 해당 강의 값을 알 수 있을 것. -> 어떻게?
// 강을 나타내는 구조체에 원류에 해당하는 강들의 number를 집어 넣는다.
// 진입 차수가 0이 되어 해당 강을 처리할 때, 원류에 해당하는 강들을 확인해보면 될듯

struct Heap<T: Comparable> {
    private var heap: [T?] = [nil]
    private let compare: (T, T) -> Bool
    var isEmpty: Bool {
        return heap.count <= 1
    }
    var count: Int {
        return heap.count - 1
    }

    init(_ compare: @escaping (T, T) -> Bool) {
        self.compare = compare
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
            let parent = heap[index / 2],
            let child = heap[index],
            compare(child, parent)
        {
            heap.swapAt(index, index / 2)
            index /= 2
        }
    }

    private mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var candidateIndex = index * 2

            if
                candidateIndex + 1 < heap.count,
                let left = heap[candidateIndex],
                let right = heap[candidateIndex + 1],
                compare(right, left)
            { candidateIndex += 1 }

            guard
                let parent = heap[index],
                let child = heap[candidateIndex],
                compare(child, parent)
            else { return }

            heap.swapAt(index, candidateIndex)
            index = candidateIndex
        }
    }
}

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

struct River {
    let number: Int
    var fromRivers: [Int] = []
    var toRivers: [Int] = []
}

let tcCount = Int(readLine()!)!

func solve() {
    let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
    let testNumber = numbers[0]
    let nodeCount = numbers[1]
    let edgeCount = numbers[2]
    var rivers: [River] = []
    var topology = Queue<River>()
    var strahler: [Int] = []

    var inDegrees = Array(repeating: 0, count: nodeCount + 1)
    strahler = Array(repeating: 1, count: nodeCount + 1)
    rivers = (0...nodeCount).map { River(number: $0) }

    for _ in 0..<edgeCount {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! }
        let from = line[0]
        let to = line[1]


        rivers[to].fromRivers.append(from)
        rivers[from].toRivers.append(to)
        inDegrees[to] += 1
    }

    for i in 1...nodeCount {
        if inDegrees[i] == 0 {
            topology.push(rivers[i])
        }
    }

    while let river = topology.pop() {
        // 원류들을 돌면서 스트롤러 값을 찾는다.
        var strahlerHeap = Heap<Int>(>)
        for fromRiver in river.fromRivers {
            strahlerHeap.insert(strahler[fromRiver])
        }

        var value = 1
        if strahlerHeap.count == 1 {
            value = strahlerHeap.pop()!
        } else if strahlerHeap.count >= 2 {
            let first = strahlerHeap.pop()!
            let second = strahlerHeap.pop()!
            if first == second {
                value = first + 1
            } else {
                value = first
            }
        }

        strahler[river.number] = value

        // 연결된 다른 강들의 진입 차수를 1씩 감소시킨다.
        for to in river.toRivers {
            inDegrees[to] -= 1
            if inDegrees[to] == 0 {
                topology.push(rivers[to])
            }
        }
    }

    print(testNumber, strahler[nodeCount])
}

for _ in 0..<tcCount {
    solve()
}
