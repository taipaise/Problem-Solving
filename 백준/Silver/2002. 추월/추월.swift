import Foundation

let number = Int(readLine()!)!
var inIndex: [String: Int] = [:]
var outCars: [String] = []
var res = 0

for i in 0..<number {
    let car = readLine()!
    inIndex[car] = i
}


for _ in 0..<number {
    let car = readLine()!
    outCars.append(car)
}

for (i, car) in outCars.enumerated() {
    if check(car: car, outIndex: i) { res += 1 }
}

func check(car: String, outIndex: Int) -> Bool {
    let curCarInIndex = inIndex[car]!

    for target in outCars.suffix(number - (outIndex + 1)) {
        let targetInIndex = inIndex[target]!
        // 뒤에 있는 차들 원래 나보다 앞에 있던 차가 있으면 안됨
        if targetInIndex < curCarInIndex { return true }
    }
    return false
}

print(res)
