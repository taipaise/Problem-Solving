import Foundation

struct Heap<T> {
    private var heap: [T?] = [nil]
    private let compare: (T, T) -> Bool
    var isEmpty: Bool {
        return heap.count <= 1
    }
    var top: T? {
        guard !isEmpty else { return nil }
        return heap[1]
    }

    init(_ cmp: @escaping (T, T) -> Bool) {
        compare = cmp
    }

    mutating func push(_ element: T) {
        heap.append(element)
        heapifyUp()
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }

        heap.swapAt(1, heap.count - 1)

        defer { heapifyDown(from: 1) }
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

    private mutating func heapifyDown(from: Int) {
        var index = from

        while index * 2 < heap.count {
            var candidate = index * 2

            if
                candidate + 1 < heap.count,
                let left = heap[candidate],
                let right = heap[candidate + 1],
                compare(right, left)
            { candidate += 1 }

            guard
                let parent = heap[index],
                let child = heap[candidate],
                compare(child, parent)
            else { return }

            heap.swapAt(index, candidate)
            index = candidate
        }
    }
}

struct Juwel {
    let weight: Int
    let cost: Int

    init(_ w: Int, _ c: Int) {
        weight = w
        cost = c
    }
}

let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let juwelCount = numbers[0]
let bagCount = numbers[1]
var juwels: [Juwel] = Array(repeating: Juwel(0, 0), count: juwelCount)
var bags: [Int] = Array(repeating: 0, count: bagCount)
var totalCost = 0

func sortByWeightASC(_ lhs: Juwel, _ rhs: Juwel) -> Bool {
    if lhs.weight != rhs.weight { return lhs.weight < rhs.weight }
    return lhs.cost > rhs.cost
}

func sortByCostDESC(_ lhs: Juwel, _ rhs: Juwel) -> Bool {
    if lhs.cost != rhs.cost { return lhs.cost > rhs.cost }
    return lhs.weight < rhs.weight
}


func solution() {
    for i in 0..<juwelCount {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        juwels[i] = (Juwel(input[0], input[1]))
    }
    juwels.sort(by: sortByWeightASC)

    for i in 0..<bagCount {
        bags[i] = Int(readLine()!)!
    }
    bags.sort()


    var heap = Heap<Juwel>(sortByCostDESC)

    var juwelIndex = 0
    for bag in bags {
        while
            juwelIndex < juwels.count,
            juwels[juwelIndex].weight <= bag
        {
            heap.push(juwels[juwelIndex])
            juwelIndex += 1
        }

        if let juwel = heap.pop() {
            totalCost += juwel.cost
        }
    }

    print(totalCost)
}

solution()
