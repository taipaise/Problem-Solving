import Foundation
// 테두리 1줄만 갈색이다.
// 내부는 모두 노란색으로 채워져 있어야 한다.
// 가로 길이가 a, 세로 길이가 b일 때
//    2a + 2b - 4 = brown
//    b = brown/2 + 2 - a
// yellow = a*b - brown 이므로
//    b = (yellow + brown) / a
// 즉, brown/2 + 2 - a = (yellow + brown) / a 인 a를 완탐으로 찾는다

func solution(_ brown:Int, _ yellow:Int) -> [Int] {
    var width: Int = 1
    var height: Int = 1
    
    for i in 1..<brown {
        guard let res = check(i, brown, yellow) else { continue }
        return [res.1, res.0]
    }
    return []
}

func check(
    _ width: Int,
    _ brown: Int, 
    _ yellow: Int
) -> (Int, Int)? {
    let height = (brown + 4 - (2 * width)) / 2
    
    if (width - 2) * (height - 2) == yellow {
        return (width, height)
    } else {
        return nil
    }
}