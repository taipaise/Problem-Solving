import Foundation

struct Food: Comparable {
    let a: Int
    let b: Int

    init(_ a: Int, _ b: Int) {
        self.a = a
        self.b = b
    }

    static func <(lhs: Food, rhs: Food) -> Bool {
        return lhs.b < rhs.b
    }
}

// 키워드: 정렬, 누적합
// 음식을 1개 시키는 가격은 간단하게 Ai가 최소인 것의 Ai 값이다.
// 음식을 2개 시키는 것 Ai가 최소인것과, 해당 음식을 빼고 Bi가 최소인 것의 합 + Bi가 최소 인 것과, 해당 음식을 빼고 Ai가 최소인 것의 합을 구한다. 둘 중에 최소인게 답임.
// 음식을 3개 시키는 시점부터 문제가 쉬워진다. 2개 시키는 가격 + 남은 음식 중 Bi가 최소인걸 순서대로 하나씩 붙이면 되기 때문임


let n = Int(readLine()!)!
var foods: [Food] = []


for _ in 0..<n {
    let inputs = readLine()!.split(separator: " ").map { Int($0)! }
    foods.append(Food(inputs[0], inputs[1]))
}

foods.sort()

// diff[i] := i개를 뽑았을때, a - b의 최솟값
// minA[i] := i ~ n 종류의 음식 중, ai의 최솟값
// sumB[i] := i까지의 b의 누적합
var diff = Array(repeating: Int.max, count: foods.count)
var minA = Array(repeating: Int.max, count: foods.count)
var sumB = Array(repeating: 0, count: foods.count)

diff[0] = foods[0].a - foods[0].b
minA[minA.count - 1] = foods.last!.a
sumB[0] = foods[0].b

for i in 1..<diff.count {
    diff[i] = min(diff[i - 1], foods[i].a - foods[i].b)

    let minAIndex = minA.count - 1 - i
    minA[minAIndex] = min(minA[minAIndex + 1], foods[minAIndex].a)

    sumB[i] = sumB[i - 1] + foods[i].b
}

// 음식을 하나 시킬 때
print(minA[0])

for i in 1..<n {
    // 1. i개를 순서대로 모두 뽑고 하나를 전환시키기
    var answer = sumB[i] + diff[i]

    // 2. i - 1개를 뽑고, 뒤에서 a가 최소인 것 하나 고르기
    answer = min(answer, sumB[i - 1] + minA[i])

    print(answer)
}
