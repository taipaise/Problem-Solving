//X가 O보다 많을 수는 없다. 항상 X가 O보다 하나 적거나 같아야 한다.
//O가 이미 승리했을 경우, X는 O보다 한개 적어야 한다.
//선공, 후공이 모두 승리하는 경우는 없다
import Foundation

func getCount(_ board: [[String]]) -> [Int] {
    var oCount = 0
    var xCount = 0
    
    for i in 0..<3 {
        for j in 0..<3 {
            guard board[i][j] != "." else { continue }
            
            if board[i][j] == "O" {
                oCount += 1
            } else {
                xCount += 1
            }
        }
    }
    
    return [oCount, xCount]
}

func isWin(_ mark: String, _ board: [[String]]) -> Bool {    
    
    for i in 0..<3 {
        var isContinuous = true    
        
        for j in 0..<3 {
            if board[i][j] != mark { 
                isContinuous = false
                break
            }
        }
        
        if isContinuous { return true }
    }
    
    for j in 0..<3 {
        var isContinuous = true
        
        for i in 0..<3 {
            if board[i][j] != mark { 
                isContinuous = false
                break
            }
        }
        
        if isContinuous { return true }
    }
    
    if
        board[0][0] == mark,
        board[1][1] == mark,
        board[2][2] == mark
    { return true }
    
    if
        board[0][2] == mark,
        board[1][1] == mark,
        board[2][0] == mark
    { return true }
    
    return false
}

func solution(_ board:[String]) -> Int {
    let boardArr = board.map {
        return $0.map { String($0) }
    }
    
    var counts = getCount(boardArr)
    var oCount = counts[0]
    var xCount = counts[1]
    
    var countDiff = oCount - xCount
    var isOWin = isWin("O", boardArr)
    var isXWin = isWin("X", boardArr)
    
    guard countDiff == 1 || countDiff == 0 else { return 0 }
    guard !(isOWin && isXWin) else { return 0 }

    if 
        isOWin,
        countDiff != 1
    { return 0 }
    
    if 
        isXWin,
        countDiff != 0
    { return 0 }
    
    return 1
}