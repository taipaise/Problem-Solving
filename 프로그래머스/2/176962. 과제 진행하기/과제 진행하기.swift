import Foundation

struct Task: Comparable {
    let name: String
    let startTime: Int
    var playTime: Int
    
    static func < (lhs: Task, rhs: Task) -> Bool {
        return lhs.startTime < rhs.startTime
    }
}

func solution(_ plans:[[String]]) -> [String] {
    var result: [String] = []
    var tasks: [Task] = plans.map {
        let times = $0[1]
            .split(separator: ":")
            .map { Int($0)! }
        guard
            let hour = times.first,
            let min = times.last,
            let playTime = Int($0[2])
        else {
            return Task(
                name: "",
                startTime: 0,
                playTime: 0
            )
        }
        
        let startTime = hour * 60 + min
        
        return Task(
            name: $0[0],
            startTime: startTime,
            playTime: playTime
        )
    }
    
    tasks.sort()
    var stack = Stack<Task>()
    var curTime = tasks[0].startTime
    
    for task in tasks {
        guard !stack.isEmpty else {
            stack.push(task)
            continue
        }

        var givenTime = task.startTime - curTime
        
        while true {
            if givenTime == 0 { break }
            guard var prevTask = stack.pop() else { break }
            
            if prevTask.playTime <= givenTime {
                givenTime -= prevTask.playTime
                result.append(prevTask.name)
            } else {
                prevTask.playTime -= givenTime
                stack.push(prevTask)
                givenTime = 0
            }
        }
        
        stack.push(task)
        curTime = task.startTime
    }
    
    while(!stack.isEmpty) {
        guard let task = stack.pop() else { break }
        result.append(task.name)
    }
    
    return result
}

struct Stack<T> {
   private var stack: [T]

   var count: Int {
       return stack.count
   }

   var isEmpty: Bool {
       return stack.isEmpty
   }

   var top: T? {
       if stack.isEmpty {
           return nil
       }
       return stack.last
   }
   
   init() {
       stack = []
   }

   mutating func push(_ item: T) {
       stack.append(item)
   }

   mutating func pop() -> T? {
       stack.popLast()
   }

   mutating func removeAll() {
       stack.removeAll()
   }
}