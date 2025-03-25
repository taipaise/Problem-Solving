#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;
typedef long long ll;

struct Node {
    int inDegree = 0;
    ll sheepCount = 0;
    ll wolfCount = 0;
    int to = -1;
};

queue<int> findLeaf(vector<Node> graph) {
    queue<int> res;

    REP(i, 2, graph.size() - 1) {
        if (graph[i].inDegree != 0) { continue; }
        res.push(i);
    }
    return res;
}

int main() {
    int n;
    vector<Node> islands;
    cin >> n;
    islands.resize(n + 1);

    // 섬 정보 입력받기
    REP(i, 2, n) {
        string type;
        int count, to;
        cin >> type >> count >> to;

        islands[i].to = to;
        if (type == "S") {
            islands[i].sheepCount = count;
        } else {
            islands[i].wolfCount = count;
        }
        // 도착 섬의 진입 차수를 하나 증가
        ++islands[to].inDegree;
    }

    queue<int> queue = findLeaf(islands);

    while (!queue.empty()) {
        int curNum = queue.front();
        queue.pop();
        
        if (curNum == 1) { break; }

        // 남아 있는 양들을 다음 섬으로 넘긴다.
        int nextNum = islands[curNum].to;

        islands[nextNum].sheepCount += islands[curNum].sheepCount;
    
        // 다음 섬에 늑대가 남아 있다면, 양을 잡아먹음
        if (islands[nextNum].wolfCount > 0) {
            int temp = min(islands[nextNum].wolfCount, islands[nextNum].sheepCount);
            islands[nextNum].sheepCount -= temp;
            islands[nextNum].wolfCount -= temp;
        }

        // 이전 섬을 처리 했으므로 다음 섬의 진입 차수 낮춰줌. 0이면 큐에 넣는다.
        if(--islands[nextNum].inDegree == 0) {
            queue.push(nextNum);
        }
    }

    cout << islands[1].sheepCount;
}