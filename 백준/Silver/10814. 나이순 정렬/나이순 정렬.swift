import Foundation

struct Member: Comparable, CustomStringConvertible {
    let age: Int
    let name: String

    var description: String {
        return "\(age) \(name)"
    }

    static func <(_ lhs: Member, _ rhs: Member) -> Bool {
        return lhs.age < rhs.age
    }
}

//func insertionSort<T: Comparable>(_ arr: [T]) -> [T] {
//    guard arr.count > 1 else { return arr }
//    var res = arr
//
//    for i in 1..<arr.count {
//        var j = i
//        let temp = res[j]
//
//        while
//            j > 0,
//            res[j - 1] > temp
//        {
//            res[j] = res[j - 1]
//            j -= 1
//        }
//
//        res[j] = temp
//    }
//
//    return res
//}

let n = Int(readLine()!)!
var members: [Member] = []
for _ in 0..<n {
    let input = readLine()!.split(separator: " ").map { String($0) }

    let newMember = Member(age: Int(input[0])!, name: input[1])
    members.append(newMember)
}

for member in members.sorted() {
    print(member)
}
