#include <iostream>
#include <cstring>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end() 
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

int dy[4] = {-1, 1, 0, 0};
int dX[4] = {0, 0, -1, 1};
int map[1001][1001] = {0, };
int visited[1001] = {0, };
int n, m, v;

bool in_range(int y, int x){
    return (y > 1 && y <= n) && (x > 1 && x <= n);
}

void dfs(int x){
    cout << x << " ";
    visited[x] = 1;
    REP(i, 1, n){
        if(visited[i] == 1) continue;
        if(map[x][i] == 0) continue;
        dfs(i);
    }
}

void bfs(int x){
    queue<int> q;
    q.push(x);
    visited[x] = 1;
    while(!q.empty()){
        x = q.front();
        q.pop();
        cout << x << " ";
        REP(i, 1, n){
            if(visited[i] == 1) continue;
            if(map[x][i] == 0) continue;
            q.push(i);
            visited[i] = 1;
        }
    }
}

int main(void){
    cin >> n >> m >> v;
    int a, b;
    rep(i, 0, m){
        cin >> a >> b;
        map[a][b] = 1;
        map[b][a] = 1;
    }
    dfs(v);
    cout << endl;
    memset(visited, 0, sizeof(visited));
    bfs(v);
}