#include <iostream>
#include <vector>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

struct POS{
    int y;
    int x;
    int time;
};

int dy[4] = {-1, 1, 0, 0};
int dx[4] = {0, 0, -1, 1};
char board[51][51];
int cnt[51][51];
int r, c;
bool flag = false;
queue<POS> water;
POS start;

bool in_range(int y, int x){
    return (0 < y && y <= r) && (0 < x && x <= c);
}

void flooding(){
    while(!water.empty()){
        int y = water.front().y;
        int x = water.front().x;
        int time = water.front().time;
        water.pop();

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(board[ny][nx] == 'X' || board[ny][nx] == 'D') continue;
            if(cnt[ny][nx] || board[ny][nx] == '*') continue;
        
            cnt[ny][nx] = time + 1;
            water.push({ny, nx, time + 1});
        }
    }
}

void bfs(){
    bool visited[51][51] = {false, };
    queue<POS> q;
    q.push(start);
    visited[start.y][start.x] = true;

    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        int time = q.front().time;
        q.pop();

        if(board[y][x] == 'D'){
            cout << time;
            flag = true;
            return;
        }

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];
            
            if(!in_range(ny, nx)) continue;
            if(board[ny][nx] == 'X') continue;
            if(visited[ny][nx]) continue;
            if(board[ny][nx] == '*') continue;
            if(cnt[ny][nx] != 0 && cnt[ny][nx] <= time + 1) continue;

            visited[ny][nx] = true;
            q.push({ny, nx, time + 1});

        }

    }
}

int main(void){
    FAST;

    cin >> r >> c;
    REP(i, 1, r){
        REP(j, 1, c){
            cin >> board[i][j];
            if(board[i][j] == 'S') start = {i, j, 0};
            if(board[i][j] == '*') water.push({i, j, 0});
        }
    }
    
    flooding();
    bfs();
    if(!flag) cout << "KAKTUS";
}