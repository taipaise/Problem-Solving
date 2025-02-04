import Foundation

var inputs: [Int] = []
var result: [Int] = []


func read() {
    for _ in 0..<9 {
        let cur = Int(readLine()!)!
        inputs.append(cur)
    }
}

func printResult() {
    result.sort()
    for res in result {
        print(res)
    }
}

func find(_ index: Int) {
    if result.count == 7 {
        if result.reduce(0, +) == 100 {
            printResult()
            exit(0)
        }
        return
    }

    for i in index..<9 {
        result.append(inputs[i])
        find(index + 1)
        result.removeLast()
    }
}


read()
find(0)
