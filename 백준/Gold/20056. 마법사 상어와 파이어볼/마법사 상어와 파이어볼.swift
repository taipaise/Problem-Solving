import Foundation

// 파이어볼을 나타내기 위한 자료구조가 필요함. + 방향을 나타내기 위한 열거형
// 이동 중에 만나는 다른 파이어볼은 신경쓰지 않는다.
// 다만 이동이 끝난 이후 파이어볼이 2개 이상이면 처리해 주어야 함
// 먼저 파이어볼을 하나로 합친다.
//  - 질량 속력을 모두 합친다.
// 파이어볼을 4개로 나눈다.
//  - 질량은 질량의합/5
//  - 속력은 속력의합/합쳐진 갯수
//  - 방향은 합쳐진 파이어볼 방향합이 짝수이면 짝수4개, 홀수이면 홀수 4개임
//  - 나눠졌는데 질량이 0이면 파이어볼 소멸됨
enum Direction: Int, CaseIterable {
    case up
    case upRight
    case right
    case downRight
    case down
    case downLeft
    case left
    case upLeft
}

// MARK: - 데이터 구조
struct FireBall {
    let magnitude: Int
    let speed: Int
    let direction: Direction

    init(_ m: Int, _ s: Int, _ d: Direction) {
        magnitude = m
        speed = s
        direction = d
    }
}

struct Pos: Hashable {
    let y: Int
    let x: Int

    init(_ y: Int, _ x: Int) {
        self.y = y
        self.x = x
    }
}

struct Queue<T> {
    private var queue: [T] = []
    private var head = 0
    var isEmpty: Bool {
        return head >= queue.count
    }
    var count: Int {
        return queue.count - head
    }

    mutating func push(_ element: T) {
        queue.append(element)
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }

        if head > 500 {
            queue.removeFirst(head)
            head = 0
        }

        defer { head += 1 }
        return queue[head]
    }
}

// MARK: - 변수 및 상수 (입력까지)
let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let size = numbers[0]
let initialFireBallCount = numbers[1]
let commandCount = numbers[2]
let dy = [-1, -1, 0, 1, 1, 1, 0, -1]
let dx = [0, 1, 1, 1, 0, -1, -1, -1]
var fireBalls = Queue<(pos: Pos, fireBall: FireBall)>()

for _ in 0..<initialFireBallCount {
    let line = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }

    // 파이어볼의 입력은 y, x, 질량, 스피드, 방향 순
    let y = line[0] - 1
    let x = line[1] - 1
    let magnitude = line[2]
    let speed = line[3]
    let direction = Direction(rawValue: line[4])!
    let fireBall = FireBall(magnitude, speed, direction)
    fireBalls.push((Pos(y, x), fireBall))
}


func solution() {
    for _ in 0..<commandCount {
        moveFireBalls()
    }

    var res = 0
    while let (_, fireBall) = fireBalls.pop() {
        res += fireBall.magnitude
    }
    print(res)
}

// step1. 파이어볼들을 이동시킨다.
func moveFireBalls() {
    var newPositions: [Pos: [FireBall]] = [:]
    // 각 파이어볼의 새로운 위치를 구한다.
    while let (pos, fireBall) = fireBalls.pop() {
        let newPos = moveFireBall(pos, fireBall.speed, fireBall.direction)
        newPositions[newPos, default: []].append(fireBall)
    }

    for (pos, tempfireBalls) in newPositions {
        if tempfireBalls.count == 1 {
            fireBalls.push((pos, tempfireBalls[0]))
        } else {
            let (mergedFireBall, directionFlag) = mergeFireBall(tempfireBalls)
            let newFireBalls = splitFireBall(mergedFireBall, tempfireBalls.count, directionFlag)
            for newFireBall in newFireBalls {
                fireBalls.push((pos, newFireBall))
            }
        }
    }
}

func moveFireBall(_ pos: Pos, _ speed: Int, _ direction: Direction) -> Pos {
    let ny = (((pos.y + dy[direction.rawValue] * speed) % size) + size) % size
    let nx = (((pos.x + dx[direction.rawValue] * speed) % size) + size) % size
    return Pos(ny, nx)
}

// step2. 중복된 위치에 있는 파이어볼을 합친다.
func mergeFireBall(_ fireBalls: [FireBall]) -> (fireBall: FireBall, directionFlag: Bool) {
    let isEven = fireBalls[0].direction.rawValue % 2 == 0
    var magnitude = 0
    var speed = 0
    var directionFlag = true

    for fireBall in fireBalls {
        magnitude += fireBall.magnitude
        speed += fireBall.speed

        if isEven != (fireBall.direction.rawValue % 2 == 0) {
            directionFlag = false
        }
    }

    return (FireBall(magnitude, speed, .up), directionFlag)
}

// step3. 합쳐진 파이어볼을 나눈다.
func splitFireBall(_ fireBall: FireBall, _ mergedCount: Int, _ directionFlag: Bool) -> [FireBall] {
    let magnitude = fireBall.magnitude / 5
    let speed = fireBall.speed / mergedCount
    var result: [FireBall] = []

    guard magnitude > 0 else { return [] }

    let directions: [Direction] = directionFlag ?
        [.up, .right, .down, .left] :
        [.upRight, .downLeft, .downRight, .upLeft]

    for direction in directions {
        let newFireBall = FireBall(magnitude, speed, direction)
        result.append(newFireBall)
    }
    return result
}

solution()
