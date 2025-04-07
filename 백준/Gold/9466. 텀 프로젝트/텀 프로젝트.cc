#include <iostream>
#include <vector>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
using namespace std;

int n;
int determined = 0;
vector<int> selection;
vector<bool> visited;
vector<int> team;

void dfs(int x) {
    if (visited[x] == true) { // 이미 방문한 곳을 방문 -> 사이클이 있을 수 있음
        int startIndex = distance(
            team.begin(),
            find(team.begin(), team.end(), x));
        int count = team.size() - startIndex;
        determined += count;
        return;
    }

    visited[x] = true;

    int next = selection[x];
    team.push_back(x);
    dfs(next);
    team.pop_back();
}

void solve() {
    selection.clear();
    visited.clear();
    determined = 0;
    
    cin >> n;
    selection.resize(n + 1);
    visited.resize(n + 1);

    REP(i, 1, n) {
        cin >> selection[i];
    }

    REP(i, 1, n) {
        if (visited[i]) { continue; }
        team.clear();
        dfs(i);
    }
    cout << n - determined << "\n";
}

int main() {
    FAST;
    int tc;
    cin >> tc;

    rep(i, 0, tc) {
        solve();
    }
}