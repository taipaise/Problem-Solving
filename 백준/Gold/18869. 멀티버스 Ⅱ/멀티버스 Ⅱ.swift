import Foundation

let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }

let m = numbers[0]
let n = numbers[1]
var universeKey: [String: Int] = [:]

struct Planet: Hashable, Comparable {
    let index: Int
    let size: Int

    init(_ index: Int, _ size: Int) {
        self.index = index
        self.size = size
    }

    static func <(_ lhs: Planet, _ rhs: Planet) -> Bool {
        if lhs.size != rhs.size {
            return lhs.size < rhs.size
        }
        return lhs.index < rhs.index
    }

    static func ==(_ lhs: Planet, _ rhs: Planet) -> Bool {
        return lhs.index == rhs.index
    }
}

for _ in 0..<m {
    // size 기준으로 정렬했을 때, index의 순서가 같으면 균등한 우주
    let planets = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    let sortedPlanets = Array(Set(planets).sorted())

    // size: index 형식으로 고유 사이즈에 대한 순서가 만들어짐
    let compressed: [Int: Int] = Dictionary(
        uniqueKeysWithValues: sortedPlanets
            .enumerated()
            .map { ($1, $0) })

    // 행성에 대하여 각 고유 사이즈에 대한 index로 key를 만든다.
    let key = planets
        .map { String(compressed[$0]!) }
        .joined(separator: "")

    universeKey[key, default: 0] += 1
}

var res = 0

let sameValues = universeKey
    .values
    .filter { $0 > 1 }

for value in sameValues {
    // n개에서 2개를 뽑는 가짓수와 같음
    res += value * (value - 1) / 2
}

print(res)
