import Foundation

var board: [[Int]] = [[]]
var visited: [Int] = []

func bfs(_ start: Int) {
    var q = Deque<Int>()
    visited[start] = 0
    q.pushLast(start)
    
    while(!q.isEmpty) {
        let v = q.popFirst()!

        for adj in board[v] {
            if visited[adj] != -1 { continue }
            
            visited[adj] = visited[v] + 1
            q.pushLast(adj)
        }
    }
}

func solution(
    _ n:Int, //총 지역의 수
    _ roads:[[Int]], // 길 정보
    _ sources:[Int], // 부대원들의 현 위치
    _ destination:Int // 목적지
) -> [Int] {
    
    var result: [Int] = []
    visited = Array(repeating: -1, count: n + 1)
    board = Array(repeating: [], count: n + 1)
    
    roads.forEach {
        let loc1 = $0[0]
        let loc2 = $0[1]
        
        board[loc1].append(loc2)
        board[loc2].append(loc1)
    }
    
    bfs(destination)
    
    for source in sources {
        let count = visited[source]
        result.append(count)
    }
    
    return result
}

struct Deque<T> {
   private var enqueue: [T]
   private var dequeue: [T] = []
   
   var count: Int {
       return enqueue.count + dequeue.count
   }
   
   var isEmpty: Bool {
       return enqueue.isEmpty && dequeue.isEmpty
   }
   
   var first: T? {
       if dequeue.isEmpty {
           return enqueue.first
       }
       return dequeue.last
   }
   
   var last: T? {
       if enqueue.isEmpty {
           return dequeue.first
       }
       return enqueue.last
   }
   
   init() {
       enqueue = []
   }
   
   mutating func pushFirst(_ item: T) {
       dequeue.append(item)
   }
   
   mutating func pushLast(_ item: T) {
       enqueue.append(item)
   }
   
   mutating func popFirst() -> T? {
       if dequeue.isEmpty {
           dequeue = enqueue.reversed()
           enqueue.removeAll()
       }
       return dequeue.popLast()
   }
   
   mutating func popLast() -> T? {
       if enqueue.isEmpty {
           enqueue = dequeue.reversed()
           dequeue.removeAll()
       }
       return enqueue.popLast()
   }
   
   mutating func removeAll() {
       enqueue.removeAll()
       dequeue.removeAll()
   }
}