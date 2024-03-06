import Foundation

var selfNumber = [Bool](repeating: true, count: 10001)

func f(_ num: Int) -> Int {
    var res = num
    var nextNum = num
    
    while nextNum / 10 != 0 {
        res += nextNum % 10
        nextNum /= 10
    }
    
    return res + nextNum
}

for i in 1...9999 {
    let num = f(i)
    
    if num <= 10000 {
        selfNumber[num] = false
    }
}

for (index, isSelfNumber) in selfNumber.enumerated() {
    if
        index != 0,
        isSelfNumber
    {
        print(index)
    }
}
