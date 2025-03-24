#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"
using namespace std;

// 데이터 구조
struct Building {
    int number;
    int time;
    int required = 0;
    int requiredTime = 0;
    vector<int> nexts;
};

int tc;

vector<Building> makeBuildings(int buildingCount, int ruleCount) {
    vector<Building> buildings(buildingCount + 1);

    REP(i, 1, buildingCount) {
        buildings[i].number = i;
        cin >> buildings[i].time;
    }

    rep(i, 0, ruleCount) {
        int pre, next;
        cin >> pre >> next;
        ++buildings[next].required ;
        buildings[pre].nexts.push_back(next);
    }

    return buildings;
}

int solve() {
    int buildingCount, ruleCount;
    int target;
    cin >> buildingCount >> ruleCount;
    vector<Building> buildings = makeBuildings(buildingCount, ruleCount);
    cin >> target;
    queue<Building> queue;

    // 시작 건물들을 큐에 넣어준다.
    REP(i, 1, buildingCount) {
        if (buildings[i].required == 0) {
            queue.push(buildings[i]);
        }
    }

    while (!queue.empty()) {
        Building building = queue.front();
        queue.pop();

        if (building.number == target) {
            return building.time + building.requiredTime;
        }

        // 다음 빌딩 짓기까지 필요한 시간 갱신
        rep(i, 0, building.nexts.size()) {
            int next = building.nexts[i];

            --buildings[next].required;
            buildings[next].requiredTime = max(
                buildings[next].requiredTime,
                building.time + building.requiredTime);

            if (buildings[next].required == 0) {
                queue.push(buildings[next]);
            }   
        }
    }

    return -1;
}

int main() {
    FAST;

    cin >> tc;
    
    rep(i, 0, tc) {
        cout << solve() << endl;
    }
}