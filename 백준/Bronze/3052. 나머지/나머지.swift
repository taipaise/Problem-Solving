import Foundation

var mod : Set<Int> = []

for _ in 0..<10{
    var num = Int(readLine()!)!
    num %= 42
    mod.insert(num)
}

print(mod.count)