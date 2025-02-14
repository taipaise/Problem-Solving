import Foundation

// 100,000 개의 숫자 배열을 매번 정렬하여 값을 출력하는 것은 시간 초과로 불가능
// 힙을 이용해서 중간값을 구한다.
// 최소힙, 최대힙을 모두 사용
// 최대힙, 최소힙 순으로 숫자를 집어 넣는다. 최대힙의 루트가 최소힙의 루트보다 작은 상태를 유지 -> 최대 힙의 루트가 항상 중간값이다.

struct Heap<T: Comparable> {
    private let compare: (T, T) -> Bool
    private var heap: [T?] = []
    var count: Int {
        return heap.count - 1
    }
    var isEmpty: Bool {
        return heap.count < 2
    }
    var top: T? {
        guard !isEmpty else { return nil }
        return heap[1]
    }

    init(compare: @escaping (T, T) -> Bool) {
        self.compare = compare
        heap = [nil]
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

    mutating func heapifyUp() {
        var index = heap.count - 1

        while index > 1 {
            guard
                let parent = heap[index / 2],
                let child = heap[index],
                compare(child, parent)
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
                let leftChild = heap[minIndex],
                let rightChild = heap[minIndex + 1],
                compare(rightChild, leftChild)
            { minIndex += 1 }

            guard
                let parent = heap[index],
                let child = heap[minIndex],
                compare(child, parent)
            else { return }

            heap.swapAt(index, minIndex)
            index = minIndex
        }
    }
}

struct MediumHeap {
    private var minHeap: Heap<Int>
    private var maxHeap: Heap<Int>
    var top: Int? {
        guard let maxHeapTop = maxHeap.top else { return nil }
        return maxHeapTop
    }

    init() {
        minHeap = Heap(compare: <)
        maxHeap = Heap(compare: >)
    }

    mutating func insert(_ num: Int) {
        // 현재 넣어야 하는 힙에 숫자를 집어 넣는다.
        if maxHeap.isEmpty || maxHeap.count == minHeap.count {
            maxHeap.insert(num)
        } else {
            minHeap.insert(num)
        }

        guard
            let maxHeapTop = maxHeap.top,
            let minHeapTop = minHeap.top,
            maxHeapTop >= minHeapTop
        else { return }

        let newMinHeapElement = maxHeap.pop()!
        let newMaxHeapElement = minHeap.pop()!

        maxHeap.insert(newMaxHeapElement)
        minHeap.insert(newMinHeapElement)
    }
}

let count = Int(readLine()!)!
var mediumHeap = MediumHeap()
var res: [String] = []

for i in 0..<count {
    let number = Int(readLine()!)!

    mediumHeap.insert(number)
    res.append("\(mediumHeap.top!)")
}

print(res.joined(separator: "\n"))
