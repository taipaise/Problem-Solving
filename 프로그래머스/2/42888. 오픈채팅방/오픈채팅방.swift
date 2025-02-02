import Foundation

enum Command: String {
    case enter = "Enter"
    case leave = "Leave"
    case change = "Change"
    
    var description: String {
        switch self {
        case .enter:
            return "님이 들어왔습니다."
        case .leave:
            return "님이 나갔습니다."
        default:
            return ""
        }
    }
}

struct Input {
    let command: Command
    let uid: String
    let nickname: String?
}

func solution(_ record:[String]) -> [String] {
    let uidIndex = 1
    var users: [String: String] = [:] //uid: nickname
    var result: [String] = []
    let inputs: [Input] = record
        .map { $0.components(separatedBy: " ") }
        .map {
            let command = Command(rawValue: $0.first!)!
            let uid = $0[uidIndex]
            var nickname: String? = nil

            if $0.count == 3 {
                nickname = $0.last
            }
            return Input(command: command, uid: uid, nickname: nickname)
        }

    
    for input in inputs {
        switch input.command {
        case .enter:
            users[input.uid] = input.nickname!
        case .change:
            users[input.uid] = input.nickname!
        default:
            break
        }
    }
    
    for input in inputs {
        switch input.command {
        case .change:
            break
        default:
            let nickname = users[input.uid]!
            result.append("\(nickname)\(input.command.description)")
        }
    }
    
    return result
}