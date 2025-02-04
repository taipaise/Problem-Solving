import Foundation

let input = readLine()!.map { String($0) }
var result: [String: Int] = [:]
let alphas = "abcdefghijklmnopqrstuvwxyz".map { String ($0) }

for alpha in alphas {
    result[alpha] = 0
}

for char in input {
    result[char, default: 0] += 1
}



for alpha in alphas.dropLast() {
    print(result[alpha, default: 0], terminator: " ")
}

print(result["z", default: 0], terminator: "")
