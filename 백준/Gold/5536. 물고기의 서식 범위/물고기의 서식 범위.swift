import Foundation

// 가능한 x, y, z 좌표가 너무 큼! 다만 직육면체는 최대 50개가 주어지기 때문에, 각 좌표는 최대 100개
// 따라서 좌표 압축이 필요하다

struct Box {
    let sx: Int
    let ex: Int
    let sy: Int
    let ey: Int
    let sz: Int
    let ez: Int

    init(_ inputs: [Int]) {
        sx = inputs[0]
        sy = inputs[1]
        sz = inputs[2]
        ex = inputs[3]
        ey = inputs[4]
        ez = inputs[5]
    }
}

struct Square: Comparable {
    let sx: Int
    let ex: Int
    let sy: Int
    let ey: Int
    let z: Int
    let d: Int

    static func < (_ lhs: Square, _ rhs: Square) -> Bool {
        return lhs.z < rhs.z
    }
}

// MARK: - 입력
let numbers = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
let n = numbers[0]
let k = numbers[1]
var boxes: [Box] = []

var xcoord: Set<Int> = []
var ycoord: Set<Int> = []
var zcoord: Set<Int> = []

for _ in 0..<n {
    let input = readLine()!
        .split(separator: " ")
        .map { Int(String($0))! }
    let box = Box(input)
    boxes.append(box)

    xcoord.insert(box.sx)
    xcoord.insert(box.ex)

    ycoord.insert(box.sy)
    ycoord.insert(box.ey)

    zcoord.insert(box.sz)
    zcoord.insert(box.ez)
}

// 좌표를 압축
let sortedX = Array(xcoord).sorted()
let sortedY = Array(ycoord).sorted()
let sortedZ = Array(zcoord).sorted()

var xIndex: [Int: Int] = [:]
var yIndex: [Int: Int] = [:]
var zIndex: [Int: Int] = [:]

for (index, x) in sortedX.enumerated() {
    xIndex[x] = index
}

for (index, y) in sortedY.enumerated() {
    yIndex[y] = index
}

for (index, z) in sortedZ.enumerated() {
    zIndex[z] = index
}

// 바다는 평면. 따라서 맨 위에서부터 가장 아래까지 면으로 자름
var squares: [Square] = []
for box in boxes {
    // 실제 좌표를 압축한 인덱스로 바꿈
    let sx = xIndex[box.sx]!
    let sy = yIndex[box.sy]!
    let sz = zIndex[box.sz]!

    let ex = xIndex[box.ex]!
    let ey = yIndex[box.ey]!
    let ez = zIndex[box.ez]!

    let startSquare = Square(sx: sx, ex: ex, sy: sy, ey: ey, z: sz, d: 1)
    let endSquare = Square(sx: sx, ex: ex, sy: sy, ey: ey, z: ez, d: -1)
    squares.append(startSquare)
    squares.append(endSquare)
}

// z 축 중심으로 정렬하여 윗 면부터 아래로 확인할 것임.
squares.sort()

var prevZIndex = 0
var flat = Array(
    repeating: Array(repeating: 0, count: sortedX.count),
    count: sortedY.count)

var totalVolume: Int = 0

for square in squares {
    let curZIndex = square.z
    let dz = sortedZ[curZIndex] - sortedZ[prevZIndex] // 인덱스를 실제 좌표로 바꾸어 변화량 측정

    var area = 0
    // 이제 2차원 평면에서 누적합 업데이트를 통해 k마리 이상인 영역의 너비를 구한다.
    for i in 0..<sortedY.count - 1 {
        var xCount = 0
        for j in 0..<sortedX.count - 1 {
            if flat[i][j] >= k {
                let dx = sortedX[j + 1] - sortedX[j]
                xCount += dx
            }
        }

        if xCount > 0 {
            let dy = sortedY[i + 1] - sortedY[i]
            area += (xCount * dy)
        }
    }

    let volume = area * dz
    totalVolume += volume
    prevZIndex = curZIndex

    // 누적합 업데이트
    for i in square.sy..<square.ey {
        for j in square.sx..<square.ex {
            flat[i][j] += square.d
        }
    }
}

print(totalVolume)
