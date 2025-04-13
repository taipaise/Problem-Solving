import Foundation

class Node: Equatable {
    let number: Int
    var next: Node?

    init(_ number: Int) {
        self.number = number
    }

    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.number == rhs.number
    }
}

class CircularList {
    private var tail: Node?
    var isEmpty: Bool {
        return tail == nil
    }

    func append(_ number: Int) {
        let newNode = Node(number)

        if let tailNode = tail {
            newNode.next = tailNode.next
            tailNode.next = newNode
        } else {
            newNode.next = newNode
        }

        tail = newNode
    }

    func remove(_ stride: Int) -> Int? {

        if stride > 1 {
            for _ in 0..<stride - 1 {
                tail = tail?.next
            }
        }

        guard let tail = tail else { return nil }
        let head = tail.next

        guard head != tail else {
            defer { self.tail = nil }
            return tail.number
        }

        tail.next = head?.next
        return head?.number
    }
}


let input = readLine()!.split(separator: " ").map { Int(String($0))! }
let size = input[0]
let stride = input[1]
var circularList = CircularList()
var res: [String] = []

for number in 1...size {
    circularList.append(number)
}


while !circularList.isEmpty {
    guard let number = circularList.remove(stride) else { break }
    res.append("\(number)")
}

print("<\(res.joined(separator: ", "))>")
