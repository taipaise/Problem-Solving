import Foundation

enum Command {
    case insert(number: Int)
    case deleteMin
    case deleteMax
    
    static func parse(_ command: String) -> Self? {
        let elements = command.components(separatedBy: " ")

        if elements.first == "I" {
            return .insert(number: Int(elements.last!)!)
        }
        
        if elements.last == "1" {
            return .deleteMax
        } else {
            return .deleteMin
        }
        
        return nil
    }
}

// 최소 힙
struct MinHeap {
    private var heap: [Int] = [0]
    var isEmpty: Bool {
        return heap.count < 2
    }
    var count: Int {
        return heap.count - 1
    }
    
    func peek() -> Int? {
        return heap.count > 1 ? heap[1] : nil
    }
    
    mutating func clear() {
        heap = [0]
    }
    
    mutating func push(_ element: Int) {
        heap.append(element)
       
        heapifyUp()
    }
    
    mutating func pop() -> Int? {
        guard heap.count > 1 else { return nil }
        
        heap.swapAt(1, heap.count - 1)
        
        let result = heap.removeLast()
        heapifyDown()
        
        return result
    }
    
   mutating func heapifyUp() {
       var index = heap.count - 1
       
       while index > 1, heap[index] < heap[index / 2] {
           heap.swapAt(index, index / 2)
           index /= 2
       }
    }
    
    mutating func heapifyDown() {
        var index = 1
        
        while index * 2 < heap.count {
            var minIndex = index * 2
            
            if 
                minIndex + 1 < heap.count, // 오른쪽 자식이 있는지 확인
                heap[minIndex] > heap[minIndex + 1] // 왼쪽보다 오른쪽 자식이 작은지 확인
            { minIndex += 1 }
            
            guard heap[index] > heap[minIndex] else { return }
            
            heap.swapAt(index, minIndex)
            index = minIndex
        }
    }
}

// 우선 순위 큐 (작을 수록 우선순위 높음)
struct PriorityQueue {
    var heap = MinHeap()
    var isEmpty: Bool {
        return heap.isEmpty
    }
    var count: Int {
        return heap.count
    }
    
    mutating func clear() {
        heap.clear()
    }
    
    mutating func push(_ element: Int) {
        heap.push(element)
    }
    
    mutating func pop() -> Int? {
        return heap.pop()
    }
}

func solution(_ operations:[String]) -> [Int] {
    let commands = operations.compactMap { Command.parse($0) }
    var minQueue = PriorityQueue()
    var maxQueue = PriorityQueue()
    var record: [Int: Int] = [:]
    var count = 0
    
    for command in commands {
        switch command {
        case .insert(let number):
            minQueue.push(number)
            maxQueue.push(-number)
            record[number, default: 0] += 1
            count += 1
        case .deleteMax:
            guard count > 0 else { continue }
            while let maxNum = maxQueue.pop() {
                if record[-maxNum, default: 0] > 0 {
                    record[-maxNum]! -= 1
                    count -= 1
                    break
                }
            }
        case .deleteMin:
            guard count > 0 else { continue }
            while let minNum = minQueue.pop() {
                if record[minNum, default: 0] > 0 {
                    record[minNum]! -= 1
                    count -= 1
                    break
                }
            }
        }
        
        if count == 0 {
            maxQueue.clear()
            minQueue.clear()
            record = [:]
        }
    }
    
    guard count > 0 else { return [0, 0] }
    
    var maxValue = 0
    var minValue = 0
    
    while let num = maxQueue.pop() {
        if record[-num, default: 0] > 0 {
            maxValue = -num
            break
        }
    }
    
    while let num = minQueue.pop() {
        if record[num, default: 0] > 0 {
            minValue = num
            break
        }
    }

    return [maxValue, minValue]
}
