#include <iostream>
#include <queue>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
struct POS{
    int y; 
    int x;
};

int tc, n;
int res = 0;
int dy[8] = {-1, 1, 0, 0, -1, 1, 1, -1};
int dx[8] = {0, 0, -1, 1, 1, 1, -1, -1};

string board[300];
int bomb[300][300];
bool visited[300][300];

bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < n);
}

void bfs(int i, int j){
    queue<POS> q;
    visited[i][j] = true;
    q.push({i, j});

    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        q.pop();

        if(bomb[y][x] != 0) continue;
        
        rep(dir, 0, 8){
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        if(!in_range(ny, nx)) continue;
        if(visited[ny][nx]) continue;
        if(board[ny][nx] == '*') continue;

        visited[ny][nx] = true;
        q.push({ny, nx});

        }
    }
}

int get_bomb(int y, int x){
    if(board[y][x] == '*') return -1;
    
    int cnt = 0;
    rep(dir, 0, 8){
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        if(!in_range(ny, nx)) continue;
        if(board[ny][nx] == '*') ++cnt;
    }
    return cnt;
}

int main(void){
    cin >> tc;

    REP(t, 1, tc){
        //방문배열, 폭탄 갯수 배열 초기화
        memset(visited, 0, sizeof(visited));
        memset(bomb, 0, sizeof(bomb));
        res = 0;
        cin >> n;

        //map 입력
        rep(i, 0, n) cin >> board[i];

        //폭탄 갯수 채워줌
        rep(i, 0, n)
            rep(j, 0, n)
                bomb[i][j] = get_bomb(i, j);

        rep(i, 0, n){
            rep(j, 0, n){
                if(visited[i][j]) continue;
                if(bomb[i][j] != 0) continue;
                ++res;
                bfs(i, j);
            }
        }

        rep(i, 0, n){
            rep(j, 0, n){
                if(visited[i][j]) continue;
                if(board[i][j] == '*') continue;
                ++res;
                visited[i][j] = true;
            }
        }

        cout << "#" << t << " ";
        cout << res << "\n";
    }
}

