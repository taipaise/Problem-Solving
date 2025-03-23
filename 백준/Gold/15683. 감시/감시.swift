import Foundation

// 최대 8개가 각각 4방향을 가질 수 있음 -> 2^16 == 65536
// 65536개의 가짓수에 대해 8*8의 보드를 모두 탐색. 대략 4백만번 연산 -> 브루트 포스

// MARK: 데이터 구조
enum Direction: Int, CaseIterable {
    case up
    case right
    case down
    case left

    func rotate(by: Int) -> Self {
        return Direction(rawValue: (self.rawValue + by) % 4)!
    }
}

enum CameraType: Int {
    case one = 1
    case two
    case three
    case four
    case five

    var directionOffsets: [Int] {
        switch self {
        case .one:
            return [0]
        case .two:
            return [0, 2]
        case .three:
            return [0, 1]
        case .four:
            return [0, 1, 2]
        case .five:
            return [0, 1, 2, 3]
        }
    }
}

struct Camera {
    private let type: CameraType
    private let startDirection: Direction
    var directions: [Direction] {
        self.type.directionOffsets.map {
            startDirection.rotate(by: $0)
        }
    }

    init(_ cameraType: Int) {
        type = CameraType(rawValue: cameraType)!
        startDirection = .up
    }

    init(type: CameraType, startDirection: Direction) {
        self.type = type
        self.startDirection = startDirection
    }

    func changeStartDirection(direction: Direction) -> Camera {
        return Camera(type: self.type, startDirection: direction)
    }
}

enum Space {
    case blank
    case wall
    case camera(Camera)
}

struct Pos {
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

    mutating func push(_ element: T) {
        queue.append(element)
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        defer { head += 1 }
        return queue[head]
    }
}

// MARK: 변수 및 상수
let dy = [-1, 0, 1, 0]
let dx = [0, 1, 0, -1]
let numbers = readLine()!.split(separator: " ").map { Int(String($0))! }
let height = numbers[0]
let width = numbers[1]
var boards: [[Space]] = Array(
    repeating: Array(repeating: .blank, count: width),
    count: height)
var cameraPositions: [Pos] = []
var res = Int.max

// 입력
func input() {
    for y in 0..<height {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! }

        for x in 0..<width {
            switch line[x] {
            case 0:
                boards[y][x] = .blank
            case 6:
                boards[y][x] = .wall
            default:
                let camera = Camera(line[x])
                boards[y][x] = .camera(camera)
                cameraPositions.append(Pos(y, x))
            }
        }
    }
}

func inRange(_ y: Int, _ x: Int) -> Bool {
    return 0 <= y && y < height && 0 <= x && x < width
}

// 사각 지대 갯수 찾기
func checkBlind() -> Int {
    var visited: [[Bool]] = Array(
        repeating: Array(repeating: false, count: width),
        count: height)
    var queue = Queue<(pos: Pos, dir: Direction)>()
    var res = 0

    for pos in cameraPositions {
        guard case let .camera(camera) = boards[pos.y][pos.x] else { continue }

        visited[pos.y][pos.x] = true

        for direction in camera.directions {
            queue.push((pos, direction))
        }
    }

    while let (pos, dir) = queue.pop() {
        let ny = pos.y + dy[dir.rawValue]
        let nx = pos.x + dx[dir.rawValue]

        guard inRange(ny, nx) else { continue }
        if case .wall = boards[ny][nx] { continue }

        visited[ny][nx] = true
        queue.push((Pos(ny, nx), dir))
    }

    for y in 0..<height {
        for x in 0..<width {
            guard
                case .blank = boards[y][x],
                !visited[y][x]
            else { continue }
            
            res += 1
        }
    }

    return res
}

// 감시 카메라들 방향 설정하기 (백트래킹)
func selectRotate(cameraIndex: Int) {
    if cameraIndex == cameraPositions.count {
        res = min(res, checkBlind())
        return
    }

    for direction in Direction.allCases {
        let cameraPos = cameraPositions[cameraIndex]

        guard case let .camera(camera) = boards[cameraPos.y][cameraPos.x] else { continue }
        let newCamera = camera.changeStartDirection(direction: direction)

        boards[cameraPos.y][cameraPos.x] = .camera(newCamera)
        selectRotate(cameraIndex: cameraIndex + 1)
        boards[cameraPos.y][cameraPos.x] = .camera(camera)
    }
}

input()
selectRotate(cameraIndex: 0)
print(res)
