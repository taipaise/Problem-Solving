import Foundation

struct File: Comparable {
    let name: String
    let head: String
    let number: Int
    let index: Int
    
    static func < (lhs: File, rhs: File) -> Bool {
        if lhs.head != rhs.head {
            return lhs.head < rhs.head
        }
        
        if lhs.number != rhs.number {
            return lhs.number < rhs.number
        }
        
        return lhs.index < rhs.index
    }
}

func isDigit(_ c: String) -> Bool {
    return ("0" <= c && c <= "9")
}

func getComponents(_ str: String)  -> [String] {
    let arr = str.map { String($0) }
    var head = ""
    var number = ""
    var index = 0
    
    while index < arr.count {
        if !head.isEmpty && !number.isEmpty && !isDigit(arr[index]) { break }
        
        if isDigit(arr[index]) {
            number += arr[index]
        } else {
            head += arr[index]
        }
        
        index += 1
    }    
    return [head, number]
}

func solution(_ files:[String]) -> [String] {
    var fileList: [File] = files
                            .enumerated()
                            .map { (index, element) in
                                  let components = getComponents(element)
                                  return File(
                                      name: element,
                                      head: components[0].lowercased(),
                                      number: Int(components[1])!,
                                      index: index
                                  )
    }
    
    fileList.sort()
    let res = fileList.map { return $0.name }
    return res
}
