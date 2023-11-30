#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <stack>
#include <set>
#include <cstring>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

vector<int> arr[1001];
bool visited[1001];
int n, m;
int res = 0;
void dfs(int x) {
    visited[x] = true;
    rep(i, 0, arr[x].size()) {
        int next = arr[x][i];
        if(visited[next]) continue;
        dfs(next);
    }
}

int main(void){
    cin >> n >> m;

    int srt, end;
    rep(i, 0, m) {
        cin >> srt >> end;
        arr[srt].push_back(end);
        arr[end].push_back(srt);
    }

    REP(i, 1, n) {
        if(visited[i]) continue;
        ++res;
        dfs(i);
    }

    cout << res;
}