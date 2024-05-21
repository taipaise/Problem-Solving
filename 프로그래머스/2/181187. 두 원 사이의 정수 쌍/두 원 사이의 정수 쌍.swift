import Foundation

func solution(_ r1:Int, _ r2:Int) -> Int64 {
    let inner = Int64(r1)
    let outer = Int64(r2)
    var innerDist = inner * inner
    var outerDist = outer * outer
    var quarter: Int64 = 0
    let edges = outer - inner + 1
    
    for x in 0...outer {

        let startY: Int64 = x < inner ? Int64(ceil(sqrt(Double(innerDist - (x * x))))) : 0
        let endY = Int64(floor(sqrt(Double(outerDist - (x * x)))))

        quarter += (endY - startY + 1)    
    }
    
    return quarter * 4 - edges * 4
}