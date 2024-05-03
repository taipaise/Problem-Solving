import Foundation

func solution(_ coin:Int, _ cards:[Int]) -> Int {
    let cardCount = cards.count
    var round = 0
    var myCoin = coin
    let maxRound = (cardCount - cardCount / 3) / 2
    var myCards: [Int: Bool] = [:]
    var deck: [Int: Bool] = [:]
    
    for i in 0..<cards.count / 3 {
        let card = cards[i]
        myCards[card] = true
    }
    
    
    while true {
        var isPossible = false
        let drawIndex = cardCount / 3 + round * 2
        guard round < maxRound else { break }
        
        deck[cards[drawIndex]] = true
        deck[cards[drawIndex + 1]] = true
        
        for card in myCards {
            if !card.value { continue }
            let cardNumber = card.key
            let targetNumber = cardCount + 1 - cardNumber
            
            if
                let targetCard = myCards[targetNumber],
                targetCard == true
            {
                isPossible = true
                myCards[cardNumber] = false
                myCards[targetNumber] = false
                break
            }
            
            if
                myCoin >= 1,
                let targetCard = deck[targetNumber],
                targetCard == true
            {
                isPossible = true
                myCards[cardNumber] = false
                deck[targetNumber] = false
                myCoin -= 1
                break
            }
        }
        
        
        if !isPossible,myCoin >= 2 {
            for card in deck {
                if !card.value { continue }
                let cardNumber = card.key
                let targetNumber = cardCount + 1 - cardNumber
                
                if
                    let targetCard = deck[targetNumber],
                    targetCard == true
                {
                    isPossible = true
                    deck[cardNumber] = false
                    deck[targetNumber] = false
                    myCoin -= 2
                    break
                }
            }
        }
        
        guard isPossible else { break }
        round += 1
    }
    
    return round + 1
}
