//
//  main.swift
//  Algoritm_swift
//
//  Created by 이동현 on 12/2/23.
//
import Foundation

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

enum Operation: Substring {
    case push
    case pop
    case front
    case back
    case size
    case empty
}

var queue = Deque<Int>()
let n = Int(readLine()!)!
var str: String
var str_arr: [Substring]
var res: Int?
for _ in 0..<n {
    str = readLine()!
    str_arr = str.split(separator: " ")
    
    switch str_arr.first {
    case Operation.push.rawValue:
        queue.pushLast(Int(str_arr.last!)!)
    case Operation.pop.rawValue:
        res = queue.popFirst()
        if let res = res {
            print(res)
        } else {
            print(-1)
        }
    case Operation.front.rawValue:
        if let res = queue.first {
            print(res)
        } else {
            print(-1)
        }
    case Operation.back.rawValue:
        if let res = queue.last {
            print(res)
        } else {
            print(-1)
        }
    case Operation.size.rawValue:
        print(queue.count)
    default:
        if queue.isEmpty {
            print(1)
        } else {
            print(0)
        }
    }
}
