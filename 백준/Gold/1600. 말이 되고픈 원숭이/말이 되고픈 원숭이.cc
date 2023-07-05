#include <iostream>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;
struct POS{
    int y;
    int x;
    int horse; //말의 움직임으로 몇번 움직였나 기록
    int move; //전체 움직임 횟수
};

bool visited[201][201][31];

int k, w, h;
bool can_reach = false;
int board[201][201];
//일반적인 움직임
int dy[4] = {-1, 1, 0, 0};
int dx[4] = {0, 0, -1, 1};
//말의 움직임
int hdy[8] = {-2, -1, 1, 2, 2, 1, -1, -2};
int hdx[8] = {1, 2, 2, 1, -1, -2, -2, -1};

bool in_range(int y, int x){
    return (0 < y && y <= h) && (0 < x && x <= w);
}

void bfs(){
    queue<POS> q;
    q.push({1, 1, 0, 0});
    visited[1][1][0] = true;

    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        int horse = q.front().horse;
        int move = q.front().move;
        q.pop();

        if(y == h && x == w){
            can_reach = true;
            cout << move;
            return;
        }

        if(horse < k){
            rep(dir, 0, 8){
                int ny = y + hdy[dir];
                int nx = x + hdx[dir];

                if(!in_range(ny, nx)) continue;
                if(board[ny][nx]) continue;
                if(visited[ny][nx][horse + 1]) continue;
                
                visited[ny][nx][horse + 1] = true;
                q.push({ny, nx, horse + 1, move + 1});
            }

        }

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(board[ny][nx]) continue;
            if(visited[ny][nx][horse]) continue;

            visited[ny][nx][horse] = true;
            q.push({ny, nx, horse, move + 1});
        }

    }

}

int main(void){
    FAST;
    cin >> k >> w >> h;
    REP(i, 1, h){
        REP(j, 1, w)
            cin >> board[i][j];
    }

    bfs();
    if(!can_reach) cout << -1;

}