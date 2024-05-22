import Foundation
struct Unit {
    var diamond = 0
    var iron = 0
    var stone = 0
    var diaCost: Int {
        return diamond + iron + stone
    }
    var ironCost: Int {
        return (diamond * 5) + iron + stone
    }
    var stoneCost: Int {
        return (diamond * 25) + (iron * 5) + stone
    }
}


func solution(_ picks:[Int], _ minerals:[String]) -> Int {
    var units: [Unit] = []
    var mineralCount = minerals.count
    var pickCount = picks.reduce(0) { $0 + $1 }
    var m: [String] = []
    var diaCount = picks[0]
    var ironCount = picks[1]
    var stoneCount = picks[2]
    var res = 0
    
    if pickCount * 5 < mineralCount {
        m = Array(minerals.prefix(pickCount * 5))
        mineralCount = pickCount * 5
    } else {
        m = minerals
    }
    
    for i in stride(from: 0, to: mineralCount, by: 5) {
        var unit = Unit()
        let endIndex = min(i + 5, mineralCount)
        for j in i..<endIndex {
            let mineral = m[j]
            if mineral == "diamond" {
                unit.diamond += 1
            } else if mineral == "iron" {
                unit.iron += 1
            } else {
                unit.stone += 1
            }
        }
        units.append(unit)
    }
    
    units.sort(by: { $0.ironCost < $1.ironCost })
    while diaCount > 0, !units.isEmpty {
        guard let unit = units.popLast() else { break }
        diaCount -= 1
        res += unit.diaCost
    }
    
    units.sort(by: { $0.stoneCost < $1.stoneCost })
    while ironCount > 0, !units.isEmpty {
        guard let unit = units.popLast() else { break }
        ironCount -= 1
        res += unit.ironCost
    }
    
    while stoneCount > 0, !units.isEmpty {
        guard let unit = units.popLast() else { break }
        stoneCount -= 1
        res += unit.stoneCost
    }

    return res
}