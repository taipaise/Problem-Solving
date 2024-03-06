import Foundation

struct Size: Comparable {
    let weight: Int
    let height: Int
    
    static func < (lhs: Size, rhs: Size) -> Bool {
        return lhs.height < rhs.height && lhs.weight < rhs.weight
    }
}

let n = Int(readLine()!)!
var people: [Size] = []

func getRank(_ my_size: Size) -> Int {
    var res = 1
    
    people.forEach { other_size in
        if my_size < other_size {
            res += 1
        }
    }
    
    return res
}

for _ in 0..<n {
    let size = readLine()!.split(separator: " ").map { Int($0)! }
    people.append(Size(weight: size.first!, height: size.last!))
}

people.forEach { size in
    print(getRank(size), terminator: " ")
}


