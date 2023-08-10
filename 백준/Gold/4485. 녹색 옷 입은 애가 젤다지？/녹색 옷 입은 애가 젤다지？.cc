#include <iostream>
#include <string>
#include <cstring>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;
struct POS{
    int y;
    int x;
    int w;

    bool operator<(const POS& rhs)const{
        return w > rhs.w;
    }
};

int tc = 0;
int board[125][125];
bool visited[125][125];
int dy[4] = {-1, 1, 0, 0};
int dx[4] = {0, 0, -1, 1};
int res;
int n;

void init(){
    memset(board, 0, sizeof(board));
    memset(visited, 0, sizeof(visited));
    res = 0;
}

bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < n);
}

void bfs(){
    priority_queue<POS> q;
    q.push({0, 0, board[0][0]});
    visited[0][0] = true;

    while(!q.empty()){
        int y = q.top().y;
        int x = q.top().x;
        int w = q.top().w;
        q.pop();

        if(y == n - 1 && x == n - 1){
            res = w;
            return;
        }

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(visited[ny][nx]) continue;
            visited[ny][nx] = true;
            q.push({ny, nx, w + board[ny][nx]});
        }
    }
}

int main(void){
    // freopen("input.txt", "r", stdin);
    FAST;
    while(1){
        ++tc;
        init();
        cin >> n;
        if(n == 0) break;
        rep(i, 0, n)
            rep(j, 0, n) cin >> board[i][j];
        bfs();
        cout << "Problem " << tc << ": " << res << "\n";
    }

}