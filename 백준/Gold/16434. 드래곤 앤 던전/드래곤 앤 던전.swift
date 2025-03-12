import Foundation

// 몬스터가 있는 경우
//   용사 먼저 공격
//   몬스터 체력 확인
//   몬스터 공격
//   용사 체력 확인
// 포션이 있는 경우
//  생명력 회복 (최대 생명력 넘을 수 없음)
//  공격력 증가

enum RoomType: Int {
    case monster = 1
    case potion
}

struct Room {
    let type: RoomType
    let atk: Int64
    let hp: Int64

    init(_ type: Int, _ atk: Int64, _ hp: Int64) {
        self.type = RoomType(rawValue: type)!
        self.atk = atk
        self.hp = hp
    }
}

struct Character {
    var hp: Int64
    var atk: Int64

    init(_ hp: Int64, _ atk: Int64) {
        self.hp = hp
        self.atk = atk
    }
}

let inputs = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let roomCount = inputs[0]
let initialHeroAtkPoint = Int64(inputs[1])
var rooms: [Room] = []

for _ in 0..<roomCount {
    let line = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }

    let room = Room(line[0], Int64(line[1]), Int64(line[2]))
    rooms.append(room)
}

// 싸움 후 용사를 반환
func fight(_ hero: Character, _ monster: Character) -> Character {
    // 용사가 몬스터를 없애는 데 필요한 턴 수
    var turnCount = monster.hp / hero.atk
    if monster.hp > hero.atk * turnCount {
        turnCount += 1
    }

    // 해당 턴 수를 진행했을 때, 용사가 살 수 있는지 확인. 다만 마지막 턴은 맞지 않고 때리기 가능
    let leftHeroHp = hero.hp - (monster.atk * (turnCount - 1))
    return Character(leftHeroHp, hero.atk)
}

func check(_ hero: Character, _ maxHp: Int64) -> Bool {
    var hero = hero

    for room in rooms {
        switch room.type {
        case .monster:
            let monster = Character(room.hp, room.atk)
            hero = fight(hero, monster)
            // 용사 체력이 0이하인 경우 불가능
            guard hero.hp > 0 else { return false }
        case .potion:
            hero.hp = min(maxHp, hero.hp + room.hp)
            hero.atk += room.atk
        }
    }

    return true
}

func find() -> Int64 {
    // 이분탐색에 사용하기 위한 변수
    var lo: Int64 = 0
    var hi = Int64.max

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1
        let hero = Character(mid, initialHeroAtkPoint)

        if check(hero, mid) {
            hi = mid
        } else {
            lo = mid
        }
    }

    return hi
}

print(find())
