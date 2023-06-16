#include <iostream>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

struct Robot{
    int y;
    int x;
    int dir;

    void turn(){
        --dir;
        if(dir < 0) dir = 3;
    }
};


//0123 순서대로 북동남서, 단 방향전환은 반 시계 방향임을 유의
int dy[4] = {-1, 0, 1, 0};
int dx[4] = {0, 1, 0, -1};
int board[50][50];
int n, m;
int r, c, d;
int res = 0;
Robot robot;

bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < m);
}

bool have_to_clean(int y, int x){
    bool flag = false;
    rep(i, 0, 4){
        int ny = y + dy[i];
        int nx = x + dx[i];

        if(!in_range(ny, nx)) continue;
        //board[ny][nx] 가 1이면 벽, 2면 청소된 상태
        if(board[ny][nx]) continue;

        flag = true;
        break;
    }
    return flag;
}

void solve(){
    while(true){
        int y = robot.y;
        int x = robot.x;

        if(board[y][x] == 0){
            ++res;
            board[y][x] = 2;
        }

        if(have_to_clean(y, x)){
            while(true){
                robot.turn();
                int ny = y + dy[robot.dir];
                int nx = x + dx[robot.dir];

                if(!in_range(ny, nx)) continue;
                if(board[ny][nx]) continue;
                robot.y = ny;
                robot.x = nx;
                break;
            }
        }
        else{
            int ny = y + dy[(robot.dir + 2) % 4];
            int nx = x + dx[(robot.dir + 2) % 4];

            if(!in_range(ny, nx)) return;
            if(board[ny][nx] == 1) return;

            robot.y = ny;
            robot.x = nx;
        }
    }
}

int main(void){
    cin >> n >> m;
    cin >> r >> c >> d;

    robot = {r, c, d};
    rep(i, 0, n){
        rep(j, 0, m) cin >> board[i][j];
    }

    solve();
    cout << res;

}