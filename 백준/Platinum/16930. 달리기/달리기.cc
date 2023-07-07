#include <iostream>
#include <algorithm>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

struct POS{
    int y;
    int x;
};

int dy[4] = {-1, 1, 0, 0};
int dx[4] = {0, 0, -1, 1};
int row, col;
int k;
POS srt, dest;
char board[1001][1001];
int visited[1001][1001];

bool in_range(int y, int x){
    return (0 < y && y <= row) && (0 < x && x <= col);
}

void bfs(){
    queue<POS> q;
    q.push(srt);
    visited[srt.y][srt.x] = 0;

    while (!q.empty()) {
        int y = q.front().y;
        int x = q.front().x;
        q.pop();

        rep(dir, 0, 4) {
            REP(i, 1, k) {
                int ny = y + (dy[dir] * i);
                int nx = x + (dx[dir] * i);

                if(!in_range(ny, nx)) break;
                if(board[ny][nx] == '#') break;
                if(visited[ny][nx] <= visited[y][x]) break;
                if(visited[ny][nx] != 2147483647) continue;

                visited[ny][nx] = visited[y][x] + 1;
                if(ny == dest.y && nx == dest.x) return;
                q.push({ny, nx});
            }
        }
    }
}

int main(void){
    cin >> row >> col >> k;
    fill(&visited[0][0], &visited[0][0] + (1001 * 1001), 2147483647);
    REP(i, 1, row){
        REP(j, 1, col){
            cin >> board[i][j];
        }
    }

    int temp_y, temp_x;
    cin >> temp_y >> temp_x;
    srt = {temp_y, temp_x};
    cin >> temp_y >> temp_x;
    dest = {temp_y, temp_x};

    bfs();
    if(visited[dest.y][dest.x] != 2147483647) cout << visited[dest.y][dest.x];
    else cout << -1;

    return 0;
}
