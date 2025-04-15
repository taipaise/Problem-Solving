import Foundation

// LIS를 묻는 문제
// 뒤에 주어진 숫자가 곧 '순서' 이다. 여기서 증가하는 가장 긴 부분 수열을 고르면 된다.
// A 전봇대 정보는 출력하기 위해서만 필요함

struct Line: Comparable {
    let start: Int
    let value: Int

    init(_ start: Int, _ value: Int) {
        self.start = start
        self.value = value
    }

    static func <(_ lhs: Line, _ rhs: Line) -> Bool {
        return lhs.value < rhs.value
    }
}

let count = Int(readLine()!)!
var lines: [Line] = []
var lis: [Line] = []
var lisIndices = Array(repeating: 0, count: count)

func input() {
    for _ in 0..<count {
        let line = readLine()!.split(separator: " ").map { Int(String($0))! }
        lines.append(Line(line[0], line[1]))
    }

    lines.sort(by: {$0.start < $1.start })
}

func findIndex(_ line: Line) -> Int {
    var lo = -1
    var hi = lis.count

    while lo + 1 < hi {
        let mid = (lo + hi) >> 1

        if lis[mid].value < line.value {
            lo = mid
        } else {
            hi = mid
        }
    }

    return hi
}

func makeLIS() {
    for (lineIndex, line) in lines.enumerated() {
        let lisIndex = findIndex(line)

        if lisIndex == lis.count {
            lis.append(line)
        } else {
            lis[lisIndex] = line
        }

        lisIndices[lineIndex] = lisIndex
    }
}

func trace() {
    var curLisIndex = lis.count - 1
    var result = Set(lines.map { $0.start })

    for i in stride(from: count - 1, through: 0, by: -1) {
        guard curLisIndex >= 0 else { break }

        if curLisIndex == lisIndices[i] {
            result.remove(lines[i].start)
            curLisIndex -= 1
        }
    }
    print(count - lis.count)
    print(result
        .sorted()
        .map { String($0) }
        .joined(separator: "\n"))
}

input()
makeLIS()
trace()