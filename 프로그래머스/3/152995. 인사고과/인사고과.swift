import Foundation

struct Score: Comparable {
    let id: Int
    let work: Int
    let peer: Int
    let sum: Int
    var rank: Int = -1
    
    static func < (lhs: Score, rhs: Score) -> Bool {
        if lhs.sum != rhs.sum {
            return lhs.sum > rhs.sum
        }
        return lhs.work > rhs.work
    }
}

func canReceive(scores: [Score], s: Score, index: Int) -> Bool {
    var flag = false
    
    for i in 0...index {
        if scores[i].sum == s.sum {
            flag = true
            break
        }
        
        if 
            scores[i].work > s.work,
            scores[i].peer > s.peer
        { break }
    }
    
    return flag
}

func solution(_ scores:[[Int]]) -> Int {
    var scoreList: [Score] = []
    var wanhoWork = scores[0][0]
    var wanhoPeer = scores[0][1]
    
    scoreList = scores
                    .enumerated()
                    .map {
                        let score = $0.element
                        return Score(
                            id: $0.offset,
                            work: score[0],
                            peer: score[1],
                            sum: score[0] + score[1]
                        )
                    }
                    
    scoreList.sort()
    var prevSum = -1
    var unranked = 0
    
    for i in 0..<scores.count {
        let isRanked = canReceive(scores: scoreList, s: scoreList[i], index: i)
    
        guard isRanked else {
            unranked += 1
            continue
        }
        
        if prevSum != scoreList[i].sum {
            scoreList[i].rank = i + 1 - unranked
            prevSum = scoreList[i].sum
        } else {
            scoreList[i].rank = scoreList[i - 1].rank
        }  
        
        if
            scoreList[i].work > wanhoWork,
            scoreList[i].peer > wanhoPeer 
        {
            return -1    
        }
        
        if scoreList[i].id == 0 {
            return scoreList[i].rank
        }

    }
    
    return -1
}