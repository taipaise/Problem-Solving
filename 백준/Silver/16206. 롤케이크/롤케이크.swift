import Foundation

struct Heap<T: Comparable> {
    private var heap: [T?]
    var isEmpty: Bool {
        return heap.count < 2
    }

    init() { heap = [nil] }

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

    private mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var minIndex = index * 2

            if
                minIndex + 1 < heap.count,
                let leftChild = heap[minIndex],
                let rightChild = heap[minIndex + 1],
                leftChild > rightChild
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

    private mutating func heapifyUp() {
        var index = heap.count - 1

        while index > 1 {
            guard
                let parent = heap[index / 2],
                let child = heap[index],
                parent > child
            else { return }

            heap.swapAt(index, index / 2)
            index /= 2
        }
    }
}

struct Cake: Comparable {
    var length: Int

    init(_ l: Int) {
        length = l
    }

    static func < (_ lhs: Self, _ rhs: Self) -> Bool {
        // 10의 배수가 되는 것이 우선 순위가 높아야 (다시 말해 크기가 더 작아야 함)

        // 둘 다 10의 배수 인 경우
        if
            lhs.length % 10 == 0,
            rhs.length % 10 == 0
        { return lhs.length < rhs.length }

        // lhs 만 10의 배수인 경우
        if lhs.length % 10 == 0 { return true }
        // rhs 만 10의 배수인 경우
        if rhs.length % 10 == 0 { return false }

        return lhs.length < rhs.length
    }
}

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = numbers[0]
var cuttingCount = numbers[1]
var heap = Heap<Cake>()
var res = 0

let cakes = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
    .filter { $0 >= 10 }
    .map { Cake($0) }

for cake in cakes {
    heap.insert(cake)
}

while !heap.isEmpty {
    guard let cake = heap.pop() else { break }
    // 케이크 길이가 10보다 작으면 필요 없음
    guard cake.length >= 10 else { continue }

    // 케이크 길이가 10이면 결과 1 증가
    if cake.length == 10 {
        res += 1
        continue
    }

    guard cuttingCount > 0 else { break }

    cuttingCount -= 1
    let newCake = Cake(cake.length - 10)
    res += 1
    heap.insert(newCake)
}

print(res)
