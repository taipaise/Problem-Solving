import Foundation

enum CommandType: String {
    case enter = "Enter"
    case leave = "Leave"
    case change = "Change"
}

func solution(_ record:[String]) -> [String] {
    var result: [(String, CommandType)] = []
    var names: [String: String] = [:]
    
    record.forEach {
        let commands = $0.split(separator: " ").map { String($0) }
        let commandType = CommandType(rawValue: commands[0])!
        let id = commands[1]
        
        switch commandType {
        case .enter:
            names[id] = commands[2]
            result.append((id, commandType))
        case .change:
            names[id] = commands[2]
        case .leave:
            result.append((id, commandType))
        }
    }
    
    return result.map {
        let name = names[$0.0, default: "error"]
        let type = $0.1
        if type == .enter {
            return "\(name)님이 들어왔습니다."
        } else {
            return "\(name)님이 나갔습니다."
        }
    }
}