import Foundation

let count = Int(readLine()!)!
let parentInfo = readLine()!
    .split(separator: " ")
    .map { Int(String($0))! }
var target = Int(readLine()!)!
var childs: [[Int]] = Array(repeating: [], count: count)
var root = 0
var res = 0

for (index, parent) in parentInfo.enumerated() {
    if parent == -1 {
        root = index
        continue
    }

    childs[parent].append(index)
}


func dfs(_ index: Int) {
    if index == target { return }
    if childs[index].isEmpty {
        res += 1
        return
    }
    if
        childs[index].count == 1,
        childs[index][0] == target
    {
        res += 1
        return
    }

    for node in childs[index] {
        dfs(node)
    }
}

dfs(root)
print(res)
