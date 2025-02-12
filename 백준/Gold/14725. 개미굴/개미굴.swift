import Foundation

// 부모가 같다면, 자식끼리 먹이 종류는 unique하다
// 아이디어: 클래스를 이용한다. 각 방은 uuid로 구분한다.

final class Room: Comparable {
    let uuid: UUID
    let food: String
    var childs: [Room]
    weak var parent: Room?

    init(_ parent: Room?, _ food: String) {
        uuid = UUID()
        self.food = food
        self.parent = parent
        childs = []
    }

    static func == (_ lhs: Room, _ rhs: Room) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    static func < (_ lhs: Room, _ rhs: Room) -> Bool {
        return lhs.food < rhs.food
    }

    func printRoom(_ floor: Int = 0) {
        childs.sort()

        for _ in 0..<floor {
            print("--", terminator: "")
        }

        print(food)

        for child in childs {
            child.printRoom(floor + 1)
        }
    }
}

let n = Int(readLine()!)!
var roots: [Room] = []
var rootIndices: [String: Int] = [:]

// 트리 생성
for _ in 0..<n {
    var inputs = readLine()!.split(separator: " ").map { String($0) }

    // 루트 노드를 제외한 자식들의 수
    let childCount = Int(inputs.removeFirst())! - 1
    let rootFood = inputs.removeFirst()

    // 이 아래로는 inputs에 자식들의 음식 명만 있음
    let rootIndex = rootIndices[rootFood, default: roots.count]

    rootIndices[rootFood] = rootIndex
    if rootIndex == roots.count {
        roots.append(Room(nil, rootFood))
    }

    var parent = roots[rootIndex]
    for i in 0..<childCount {
        let curFood = inputs[i]
        let childs = parent.childs

        // child들 중에 같은 이름이 있으면 넘어가야 함
        if let firstIndex = childs.firstIndex( where: { $0.food == curFood }) {
            parent = childs[firstIndex]
            continue
        }

        //child 중에 같은 이름이 없으면, 방을 추가한다.
        let newRoom = Room(parent, curFood)
        parent.childs.append(newRoom)
        parent = newRoom
    }
}

// 루트 노드들을 정렬한다.
roots.sort()

for root in roots {
    root.printRoom()
}
