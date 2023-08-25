#include <iostream>
#include <cstring>
#include <string>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
#define MAX 50
using namespace std;

typedef unsigned long long ull;

struct POS{
    int y;
    int x;
    int move_cnt;
    ull key;
};

int n, m;
char board[50][50];
bool visited[50][50][1 << 6];
int dy[4] = {-1, 1, 0, 0};
int dx[4] = {0, 0, -1, 1};
POS srt, dest;

bool is_bit_on(ull a, int b){
    return (a & (1 << b)) > 0;
}

bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < m);
}

bool is_key(int y, int x){
    return ('a' <= board[y][x]) && (board[y][x] <= 'f');
}

bool is_door(int y, int x){
    return ('A' <= board[y][x]) && (board[y][x] <= 'F');
}

int bfs(){
    queue<POS> q;
    q.push(srt);
    visited[srt.y][srt.x][0] = true;

    while(!q.empty()){
        auto[y, x, move_cnt, key] = q.front();
        q.pop();
        if(board[y][x] == '1') return move_cnt;

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];
            ull nkey = key;

            if(!in_range(ny, nx)) continue; //범위 밖으로 나가는 경우
            if(visited[ny][nx][nkey]) continue; //이미 방문한 경우
            if(board[ny][nx] == '#') continue; //벽인 경우

            if(is_door(ny, nx)){
                if(!is_bit_on(nkey, board[ny][nx] - 'A')) continue;//문인데 열쇠 없으면 건너뜀
            }
            if(is_key(ny, nx)) nkey |= (1 << (board[ny][nx] - 'a')); //열쇠인 경우
            visited[ny][nx][nkey] = true;
            q.push({ny, nx, move_cnt + 1, nkey});
        }
    }

    return -1;
}

int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    cin >> n >> m;

    string temp;
    rep(i, 0, n){
        cin >> temp;
        rep(j, 0, m){
            board[i][j] = temp[j];
            if(temp[j] == '0') srt = {i, j, 0, 0};
        }
    }

    cout << bfs();
}

