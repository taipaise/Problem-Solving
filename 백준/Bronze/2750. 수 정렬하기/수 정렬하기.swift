import Foundation


// 선택 정렬
func 선택정렬(_ arr: [Int]) -> [Int] {
    var res = arr

    for indexToSort in 0..<arr.count - 1 {
        var minIndex = indexToSort

        for indexToCompare in indexToSort + 1..<arr.count {
            guard res[indexToCompare] < res[minIndex] else { continue }
            minIndex = indexToCompare
        }

        guard minIndex != indexToSort else { continue }

        res.swapAt(indexToSort, minIndex)
    }

    return res
}

func solution() {
    let n = Int(readLine()!)!
    var arr: [Int] = []
    for _ in 0..<n {
        arr.append(Int(readLine()!)!)
    }

    let sorted = 선택정렬(arr)
    for element in sorted {
        print(element)
    }
}

solution()
