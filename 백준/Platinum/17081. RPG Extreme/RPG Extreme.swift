import Foundation

protocol Character {
    var maxHp: Int { get }
    var hp: Int { get set }
    var atk: Int { get }
    var def: Int { get }
    var exp: Int { get }
}

extension Character {
    mutating func takeDamage(_ enemy: Character, _ multiplier: Int = 1) -> Bool {
        let damage = max(1, enemy.atk * multiplier - def)
        hp -= damage

        return hp > 0
    }

    mutating func heal(_ point: Int? = nil) {
        if let point = point {
            hp = min(hp + point, maxHp)
        } else {
            hp = maxHp
        }
    }
}

enum Space: String, CustomStringConvertible {
    case blank = "."
    case wall = "#"
    case trap = "^"
    case treasure = "B"
    case monster = "&"
    case boss = "M"
    case hero = "@"

    var description: String {
        return self.rawValue
    }
}

enum Equipment {
    case weapon(value: Int)
    case armor(value: Int)
    case acc(type: AccType)
}

enum AccType: String {
    case HR
    case RE
    case CO
    case EX
    case DX
    case HU
    case CU
}

enum Direction: String {
    case left = "L"
    case right = "R"
    case up = "U"
    case down = "D"

    var index: Int {
        switch self {
        case .left:
            return 0
        case .right:
            return 1
        case .up:
            return 2
        case .down:
            return 3
        }
    }
}

enum ResultMessage: String, CustomStringConvertible {
    case lost
    case trapped
    case win
    case `continue`

    var description: String {
        switch self {
        case .lost:
            return "YOU HAVE BEEN KILLED BY"
        case .trapped:
            return "YOU HAVE BEEN KILLED BY SPIKE TRAP.."
        case .win:
            return "YOU WIN!"
        case .continue:
            return "Press any key to continue."
        }
    }
}

struct Hero: Character, CustomStringConvertible {
    var hp: Int
    private(set) var maxHp: Int
    private(set) var originAtk: Int
    private(set) var originDef: Int
    private(set) var exp: Int
    private(set) var level: Int
    private(set) var weapon: Int?
    private(set) var armor: Int?
    private(set) var accs: Set<AccType>

    var requiredExp: Int {
        return 5 * level
    }
    var atk: Int {
        var atk: Int = originAtk
        if let weapon = weapon { atk += weapon }
        return atk
    }
    var def: Int {
        var def: Int = originDef
        if let armor = armor { def += armor }
        return def
    }
    var description: String {
        """
        LV : \(level)
        HP : \(max(hp, 0))/\(maxHp)
        ATT : \(originAtk)+\(weapon ?? 0)
        DEF : \(originDef)+\(armor ?? 0)
        EXP : \(exp)/\(requiredExp)
        """
    }

    init() {
        maxHp = 20
        hp = 20
        originAtk = 2
        originDef = 2
        exp = 0
        level = 1
        accs = []
    }

    mutating func trapped() -> Bool {
        if accs.contains(.DX) {
            hp -= 1
        } else {
            hp -= 5
        }

        return hp > 0
    }

    // 경험치 올리는 함수
    mutating func levelUp(_ enemy: Character) {
        let expGain: Int

        if accs.contains(.EX) {
            expGain = Int(Double(enemy.exp) * 1.2)
        } else {
            expGain = enemy.exp
        }
        exp += expGain

        guard exp >= requiredExp else { return }

        level += 1
        exp = 0
        maxHp += 5
        originAtk += 2
        originDef += 2
        hp = maxHp
    }

    // 장비 장착하는 함수
    mutating func equip(_ equipment: Equipment) {
        switch equipment {
        case .weapon(let value):
            weapon = value
        case .armor(let value):
            armor = value
        case .acc(let acc):
            guard accs.count < 4 else { return }
            accs.insert(acc)
        }
    }

    mutating func unEquip(_ equipment: Equipment) {
        switch equipment {
        case .weapon:
            weapon = nil
        case .armor:
            armor = nil
        case .acc(let acc):
            accs.remove(acc)
        }
    }
}

struct Monster: Character {
    let name: String
    var hp: Int
    private(set) var maxHp: Int
    private(set) var atk: Int
    private(set) var def: Int
    private(set) var exp: Int

    init(
        name: String,
        maxHp: Int,
        atk: Int,
        def: Int,
        exp: Int
    ) {
        self.name = name
        self.maxHp = maxHp
        self.atk = atk
        self.def = def
        self.exp = exp
        hp = maxHp
    }
}

struct Pos: Hashable, CustomStringConvertible {
    let y: Int
    let x: Int
    var description: String {
        "y: \(y), x: \(x)"
    }

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

// MARK: -

let dy = [0, 0, -1, 1]
let dx = [-1, 1, 0, 0]
var height = 0
var width = 0
var equipments: [Pos: Equipment] = [:]
var monsters: [Pos: Monster] = [:]
var boards: [[Space]] = []
var commands: [Direction] = []
var initialHeroPos = Pos(0, 0)
var heroPos: Pos = Pos(0, 0)
var bossPos: Pos = Pos(0, 0)
var turn = 0
var hero = Hero()

// 입력 받는 함수
func input() {
    let size = readLine()!.split(separator: " ").map { Int(String($0))! }
    height = size[0]
    width = size[1]

    var treasureCount = 0
    var monsterCount = 0

    for y in 0..<height {
        let line = readLine()!.map { Space(rawValue: String($0))! }

        boards.append(line)
        for (x, element) in line.enumerated() {
            switch element {
            case .monster:
                monsterCount += 1
            case .boss:
                bossPos = Pos(y, x)
                monsterCount += 1
            case .hero:
                initialHeroPos = Pos(y, x)
                heroPos = initialHeroPos
                boards[y][x] = .blank
            case .treasure:
                treasureCount += 1
            default:
                break
            }
        }

    }

    commands = readLine()!.map { Direction(rawValue: String($0))! }

    for _ in 0..<monsterCount {
        let info = readLine()!.split(separator: " ").map { String($0) }
        let y = Int(info[0])! - 1
        let x = Int(info[1])! - 1
        let name = info[2]
        let atk = Int(info[3])!
        let def = Int(info[4])!
        let hp = Int(info[5])!
        let exp = Int(info[6])!

        let monster = Monster(name: name, maxHp: hp, atk: atk, def: def, exp: exp)
        monsters[Pos(y, x)] = monster
    }

    for _ in 0..<treasureCount {
        let info = readLine()!.split(separator: " ").map { String($0) }
        let y = Int(info[0])! - 1
        let x = Int(info[1])! - 1
        let type = info[2]
        let detail = info[3]

        if type == "W" {
            equipments[Pos(y, x)] = Equipment.weapon(value: Int(detail)!)
        } else if type == "A" {
            equipments[Pos(y, x)] = Equipment.armor(value: Int(detail)!)
        } else {
            equipments[Pos(y, x)] = Equipment.acc(type: AccType(rawValue: detail)!)
        }
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

// move, action
func move(_ command: Direction) {
    let ny = dy[command.index] + heroPos.y
    let nx = dx[command.index] + heroPos.x

    guard
        inRange(ny, nx),
        boards[ny][nx] != .wall
    else { return }

    heroPos = Pos(ny, nx)
}

func action(_ space: Space) -> Bool {
    switch space {
    case .trap:
        return trapped()
    case .treasure:
        equip()
        return true
    case .monster, .boss:
        return fight()
    default:
        return true
    }
}

func trapped() -> Bool {
    if hero.trapped() {
        return true
    } else {
        if hero.accs.contains(.RE) {
            hero.unEquip(Equipment.acc(type: .RE))
            hero.heal()
            heroPos = initialHeroPos
            return true
        } else {
            return false
        }
    }
}

func equip() {
    guard let equipment = equipments[heroPos] else { return }

    hero.equip(equipment)
    boards[heroPos.y][heroPos.x] = .blank
}

func fight() -> Bool {
    guard var monster = monsters[heroPos] else { return false }

    var multiplier = 1
    var protection = false

    if
        boards[heroPos.y][heroPos.x] == .boss,
        hero.accs.contains(.HU)
    {
        hero.heal()
        protection = true
    }

    if hero.accs.contains(.CO) {
        multiplier = hero.accs.contains(.DX) ? 3 : 2
    }

    while true {
        let isMonsterAlive = monster.takeDamage(hero, multiplier)
        multiplier = 1

        if !isMonsterAlive { break }

        if protection {
            protection = false
            continue
        }

        let isHeroAlive = hero.takeDamage(monster)
        if !isHeroAlive { break }
    }




    guard hero.hp > 0 else {
        // 부활 아이템이 있다면
        if hero.accs.contains(.RE) {
            hero.unEquip(Equipment.acc(type: .RE))
            heroPos = initialHeroPos
            hero.heal()
            return true
        } else {
            return false
        }
    }

    if hero.accs.contains(.HR) {
        hero.heal(3)
    }

    hero.levelUp(monster)
    monsters[heroPos] = nil
    boards[heroPos.y][heroPos.x] = .blank

    return true
}

// print
func printGrid(_ isHeroDead: Bool) {
    if !isHeroDead {
        boards[heroPos.y][heroPos.x] = .hero
    }

    let grid = boards.map { line in
        line.map { $0.rawValue }.joined(separator: "")
    }.joined(separator: "\n")

    print(grid)
}

func printResult(isHeroDead: Bool) {
    printGrid(isHeroDead)
    print("Passed Turns : \(turn)")
    print(hero)
}

func solution() {
    input()

    for command in commands {
        turn += 1
        move(command)
        let space = boards[heroPos.y][heroPos.x]
        let result = action(space)

        // 죽거나, 보스 몬스터를 만난 상황
        switch space {
        case .trap:
            guard !result else { continue }
            printResult(isHeroDead: true)
            print(ResultMessage.trapped)
            return
        case .monster:
            guard !result else { continue }
            guard let monster = monsters[heroPos] else { break }
            printResult(isHeroDead: true)
            print("\(ResultMessage.lost) \(monster.name)..")
            return
        case .boss:
            if result {
                guard monsters[bossPos] == nil else { continue }
                printResult(isHeroDead: false)
                print(ResultMessage.win)
                return
            } else {
                guard let monster = monsters[heroPos] else { break }
                printResult(isHeroDead: true)
                print("\(ResultMessage.lost) \(monster.name)..")
                return
            }
        default:
            continue
        }
    }

    printResult(isHeroDead: false)
    print(ResultMessage.continue)
}

solution()
