import Foundation

// 가능한 자리 배치인지 확인
func isValid(_ cur: Int, _ prev: Int, _ fullSeat: Int) -> Bool {
    guard
        (cur & (cur >> 1)) == 0,
        (cur & (prev << 1) & fullSeat) == 0,
        (cur & (prev >> 1)) == 0
    else { return false }

    return true
}

let tc = Int(readLine()!)!

for _ in 0..<tc {
    solution()
}

func solution() {
    let MAX = Int(1e5)
    let inputs = readLine()!.split(separator: " ").map { Int($0)! }
    let (height, width) = (inputs[0], inputs[1])
    let FULL_SEAT = (1 << width) - 1
    var brokens: [[Int]] = Array(repeating: [], count: height + 1)
    // dp[i][j] := i번째 행의 자리 배치가 j일때, 배치시킬 수 있는 최대 학생 수
    var dp: [[Int]] = Array(
        repeating: Array(
            repeating: MAX,
            count: FULL_SEAT + 1),
        count: height + 1)

    for i in 1...height {
        let brokenIndice: [Int] = readLine()!
            .map { String($0) }
            .enumerated()
            .filter { $1 == "x" }
            .map { (index, element) in return index }

        brokens[i] = brokenIndice
    }

    dp[0] = Array(repeating: 0, count: FULL_SEAT + 1)

    for i in 1...height {
        for seating in 0...FULL_SEAT {
            // 부서진 의자에 사람을 앉힐 수 없음
            var flag = true
            for broken in brokens[i] {
                if seating & (1 << broken) > 0 {
                    flag = false
                    break
                }
            }
            guard flag else { continue }

            // 이전 행의 모든 조합에 대해 현재 행이 가능한지 확인
            for prevSeating in 0...FULL_SEAT {
                guard
                    dp[i - 1][prevSeating] < MAX, // 이전 행에 해당 조합의 좌석은 없음
                    isValid(seating, prevSeating, FULL_SEAT) // 현재 행이 가능한 조합인지 확인
                else { continue }

                // 현재 행에 있는 1의 갯수 확인
                let count = seating.nonzeroBitCount

                // i행의 seating 조합으로 앉힐 수 있는 최대 누적 학생 수 갱신
                if dp[i][seating] == MAX {
                    dp[i][seating] = dp[i - 1][prevSeating] + count
                } else {
                    dp[i][seating] = max(dp[i][seating], dp[i - 1][prevSeating] + count)
                }
            }
        }
    }

    var res = 0
    for seat in 0...FULL_SEAT {
        guard dp[height][seat] < MAX else { continue }
        res = max(res, dp[height][seat])
    }
    print(res)
}