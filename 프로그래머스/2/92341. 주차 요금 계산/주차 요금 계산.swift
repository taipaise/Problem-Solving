import Foundation

struct Info {
    let time: Int
    
    init(_ infoString: [String]) {
        time = getTime(infoString[0])
    }
}

func getTime(_ timeString: String) -> Int {
    let minHour = timeString
                        .split(separator: ":")
                        .map { return Int($0)! }
    let time = minHour[0] * 60 + minHour[1]
    return time
}

func getFee(
    _ basicTime: Int,
    _ basicFee: Int,
    _ unitTime: Int,
    _ unitFee: Int,
    _ parkingTime: Int
) -> Int {
    var fee = basicFee
    let time = parkingTime - basicTime
    
    if time > 0 {
        fee += (time / unitTime) * unitFee
        if time % unitTime != 0 {
            fee += unitFee
        }
    }
    return fee
}

func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    let basicTime = fees[0]
    let basicFee = fees[1]
    let unitTime = fees[2]
    let unitFee = fees[3]
    var parkingLot: [String: Info] = [:]
    var parkingTimes: [String: Int] = [:]
    var parkingFees: [String: Int] = [:]
    
    let infos = records.map {
        return $0.split(separator: " ").map { return String($0) }
    }
    
    infos.forEach {
        let timeString = $0[0]
        let carNumber = $0[1]
        let parkingType = $0[2]
    
        if parkingType == "OUT" {
            let parkingInfo = parkingLot[carNumber]!
            let outTime = getTime(timeString)
            let inTime = parkingInfo.time
            let timeDiff = outTime - inTime
        
            if parkingTimes[carNumber] != nil {
                parkingTimes[carNumber]! += timeDiff
            } else {
                parkingTimes[carNumber] = timeDiff
            }
            
            parkingLot[carNumber] = nil
        } else {
            let info = Info($0)
            parkingLot[carNumber] = info
        }
    }
    
    parkingLot.forEach {
        let carNumber = $0.key
        let inTime = $0.value.time
        let outTime = 23 * 60 + 59
        let timeDiff = outTime - inTime
        
        if parkingTimes[carNumber] != nil {
            parkingTimes[carNumber]! += timeDiff
        } else {
            parkingTimes[carNumber] = timeDiff
        }
    }
    
    let sortedNumber = parkingTimes.keys.sorted().map { return String($0) }
    let res: [Int] = sortedNumber.map {        
        let parkingTime = parkingTimes[$0]!
        let fee = getFee(
                    basicTime,
                    basicFee,
                    unitTime,
                    unitFee,
                    parkingTime
                )
        return fee
    }
    
    return res
}