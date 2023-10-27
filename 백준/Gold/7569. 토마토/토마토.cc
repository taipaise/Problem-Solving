#include <iostream>
#include <vector>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
struct POS{
    int h;
    int y;
    int x;
};

queue<POS> q;
int board[100][100][100]; // [h][row][col]
int col, row, h;
int res = 0;
int dh[6] = {-1, 1, 0, 0, 0, 0};
int dy[6] = {0, 0, -1, 1, 0, 0};
int dx[6] = {0, 0, 0, 0, -1, 1};


bool in_range(int z, int y, int x){
    return (
        (0 <= y && y < row) &&
        (0 <= x && x < col) &&
        (0 <= z && z < h)
    );
}

bool is_ripened(){
    rep(i, 0, h){
        rep(j, 0, row){
            rep(k, 0, col){
                if(board[i][j][k] != 0) continue;
                return false;
            }
        }
    }
    return true;
}

void bfs(){
    while(!q.empty()){
        int h = q.front().h;
        int y = q.front().y;
        int x = q.front().x;
        q.pop();

        rep(dir, 0, 6){
            int nh = h + dh[dir];
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(nh, ny, nx)) continue; // 범위 밖
            if(board[nh][ny][nx] != 0) continue; //이미 익은 토마토거나 토마토가 없는 칸
            board[nh][ny][nx] = board[h][y][x] + 1;
            res = max(res, board[nh][ny][nx]);
            q.push({nh, ny, nx});
        }
    }
}

int main(void){
    FAST;
    cin >> col >> row >> h;

    rep(i, 0, h){
        rep(j, 0, row){
            rep(k, 0, col){
                cin >> board[i][j][k];
                if(board[i][j][k] == 1) q.push({i, j, k});
            }
        }
    }

    if(is_ripened()){
        cout << 0;
        return 0;
    }

    bfs();

    if(is_ripened())
        cout << res - 1;
    else 
        cout << -1;
    
}