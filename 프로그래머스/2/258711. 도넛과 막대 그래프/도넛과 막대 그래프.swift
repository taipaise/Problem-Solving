import Foundation

//진출 차수가 1보다 크고, 진입 차수 < 진출 차수면 추가된 정점이다.
//막대모양 그래프는 진입차수가 0, 진출 차수가 1인 정점의 갯수와 같다.
//8자 그래프는 진출 차수가 2, 진입 차수가 2인 정점의 갯수와 같다.
//도넛 모양 그래프는 추가된 정점에서 나가는 간선의 갯수에서 막대 모양 그래프의 갯수와, 8자 그래프의 갯수를 빼서 구할 수 있다.

var outDegree: [Int: Int] = [:]
var inDegree:  [Int: Int] = [:]

func setDegrees(_ edges:[[Int]]) {
    edges.forEach {
        guard
            let a = $0.first,
            let b = $0.last
        else { return }
        
        if outDegree[a] != nil {
            outDegree[a]! += 1
        } else {
            outDegree[a] = 1
        }
        
        if inDegree[b] != nil {
            inDegree[b]! += 1
        } else {
            inDegree[b] = 1
        }
    }
}

func getAllGraphCount(_ vertex: Int) -> Int {
    return outDegree[vertex] ?? 0
}

func getVertex() -> Int {
    for (vertex, _out) in outDegree {
        let _in = inDegree[vertex] ?? 0
        if _out > 1 && _in == 0 {
            return vertex
        }
    }
    
    return -1
}

func getStickGraphCount() -> Int {
    var result = 0
    inDegree.forEach {
        let vertex = $0.key
        let _in = $0.value
        let _out = outDegree[vertex] ?? 0
        
        if _out == 0 && _in > 0 {
            result += 1
        }
    }
    
    return result
}

func getEightGraphCount() -> Int {
    var result = 0
    outDegree.forEach {
        let vertex = $0.key
        let _out = $0.value
        let _in = inDegree[vertex] ?? 0
        
        if _out == 2 && _in > 0 {
            result += 1
        }
    }
    
    return result
}


func solution(_ edges:[[Int]]) -> [Int] {
    setDegrees(edges)
    let insertedVertex = getVertex()
    let allCount = getAllGraphCount(insertedVertex)
    let eight = getEightGraphCount()
    let stick = getStickGraphCount()
    let donut = allCount - eight - stick
    return [
        insertedVertex,
        donut,
        stick,
        eight
    ]
}
