import Foundation

// MARK: - data struture

// command enum
enum Command: String {
    case prev
    case next
    
    var weight: Int {
        switch self {
            case .prev:
                return -10
            case .next:
                return 10
        }
    }
}


// MARK: - solution

// 문자열을 초로 변환하는 함수
func convertToSec(_ input: String) -> Int {
    let minSec = input
        .split(separator: ":")
        .map { Int($0)! }
    
    let min = minSec.first!
    let sec = minSec.last!
    
    return (min * 60) + sec
}

// 초을 분:초 형식의 문자열로 변환하는 함수
func convertToStr(_ input: Int) -> String {
    let min = input / 60
    let sec = input % 60
    let minStr: String = min < 10 ? "0\(min)"  : "\(min)"
    let secStr: String = sec < 10 ? "0\(sec)" : "\(sec)"
    
    return "\(minStr):\(secStr)"
}

// 오프닝 시간인지 확인하는 함수
func inOpening(
    _ start: Int,
    _ end: Int,
    _ current: Int
) -> Bool {
    return start <= current && current <= end
}

func move(
    _ current: Int,
    _ len: Int,
    _ command: Command
) -> Int {
    var newPos = current

    newPos += command.weight
    
    if newPos < 0 {
        newPos = 0
    } else if newPos > len {
        newPos = len
    }
    
    return newPos
}

func solution(
    _ video_len:String,
    _ pos:String,
    _ op_start:String,
    _ op_end:String,
    _ commands:[String]
) -> String {
    let videoLen = convertToSec(video_len)
    var currentPos = convertToSec(pos)
    let start = convertToSec(op_start)
    let end = convertToSec(op_end)
    let commands: [Command] = commands.compactMap {
        Command(rawValue: $0)
    }
    
    for command in commands {
        if inOpening(start, end, currentPos) {
            currentPos = end
        }

        currentPos = move(currentPos, videoLen, command)

        if inOpening(start, end, currentPos) {
            currentPos = end
        }
    }
    
    return convertToStr(currentPos)
}