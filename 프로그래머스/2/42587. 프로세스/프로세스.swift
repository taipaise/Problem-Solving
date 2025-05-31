import Foundation

// 최대 힙과 큐를 동시에 사용
struct Process: Comparable {
    let number: Int
    let priority: Int
    
    static func <(_ lhs: Process, _ rhs: Process) -> Bool {
        return lhs.priority < rhs.priority
    }
}

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

struct Heap<T> {
    private var heap: [T?] = [nil]
    private let compare: (T, T) -> Bool
    var isEmpty: Bool {
        return heap.count <= 1
    }
    var peek: T? {
        guard !isEmpty else { return nil }
        return heap[1]
    }
    
    init(compare: @escaping (T, T) -> Bool) {
        self.compare = compare
    }
    
    mutating func insert(_ element: T) {
        heap.append(element)
        heapifyUp()
    }
    
    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        defer { heapifyDown() }
        heap.swapAt(1, heap.count - 1)
        return heap.removeLast()
    }
    
    mutating func heapifyUp() {
        var index = heap.count - 1
        
        while index / 2 > 0 {
            guard
                let child = heap[index],
                let parent = heap[index / 2],
                compare(child, parent)
            else { return }
            heap.swapAt(index, index / 2)
            index /= 2
        }
    }
    
    mutating func heapifyDown() {
        var index = 1
        
        while index * 2 < heap.count {
            var candidate = index * 2
            
            if
                candidate + 1 < heap.count,
                let left = heap[candidate],
                let right = heap[candidate + 1],
                compare(right, left)
            { candidate += 1 }
            
            guard
                let child = heap[candidate],
                let parent = heap[index],
                compare(child, parent)
            else { return }
            
            heap.swapAt(index, candidate)
            index = candidate
        }
    }
}

func solution(_ priorities:[Int], _ location:Int) -> Int {
    var queue = Queue<Process>()
    var heap = Heap<Int>(compare: >)
    
    priorities.enumerated().forEach { (index, priority) in
        let process = Process(number: index, priority: priority)
        queue.push(process)
        heap.insert(priority)
    }
    
    var count = 0
    
    while true {
        guard
            let currentProcess = queue.pop(),
            let nextPiority = heap.peek
        else { return -1 }
        
        guard currentProcess.priority == nextPiority else {
            queue.push(currentProcess)
            continue
        }
        
        _ = heap.pop()
        count += 1
        
        if location == currentProcess.number {
            return count
        }
    }
    
    return -1
}