import Foundation

//홀수인 알파벳은 한 개까지 가능. 중간에 들어가야 함
var name = readLine()!
var count: [String: Int] = [:]
var oddElement: String? = nil
var res: [String] = []

for element in name {
    count[String(element), default: 0] += 1
}

for (key, value) in count.sorted(by: { $0.key < $1.key }) {
    if value % 2 == 1 {
        guard oddElement == nil else {
            print("I'm Sorry Hansoo")
            exit(0)
        }
        oddElement = key
    }

    let cur = Array(repeating: key, count: value / 2)
    res += cur
}

res = res + [oddElement ?? ""] + res.reversed()

print(res.joined(separator: ""))
