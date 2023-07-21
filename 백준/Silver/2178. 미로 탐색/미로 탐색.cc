#include <iostream>
#include <algorithm>
#include <string>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;
struct POS{
    int y;
    int x;
    int cnt;
};

int n, m;
string board[100];
bool visited[100][100];
int dy[4] = {-1, 1, 0, 0};
int dx[4] = {0, 0, -1, 1};

bool in_range(int y, int x){
    return(0 <= y && y < n) && (0 <= x && x < m);
}

int bfs(){
    queue<POS> q;
    visited[0][0] = true;
    q.push({0, 0}); 

    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        int cnt = q.front().cnt;
        q.pop();

        if(y == n - 1 && x == m - 1) return cnt;
        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(board[ny][nx] == '0') continue;
            if(visited[ny][nx]) continue;

            visited[ny][nx] = true;
            q.push({ny, nx, cnt + 1});
        }
    }   
    return -1;
}

int main(void){
    cin >> n >> m;

    rep(i, 0, n) cin >> board[i];
    cout << bfs() + 1;
}