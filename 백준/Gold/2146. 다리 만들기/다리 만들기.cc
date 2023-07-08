#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
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
int temp_board[100][100];
int board[100][100];
int n;
int minimum = 99999;

bool in_range(int y, int x){
    return(0 <= y && y < n) && (0 <= x && x < n);
}

bool is_edge(int y, int x){
    rep(dir, 0, 4){
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        if(!in_range(ny, nx)) continue;
        if(board[ny][nx]) continue;
        return true;
    }
    return false;
}

//섬에 dfs를 통해 섬에 번호 부여
void dfs(int y, int x, int island_no){
    board[y][x] = island_no;

    rep(dir, 0, 4){
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        if(!in_range(ny, nx)) continue;
        if(temp_board[ny][nx] == 0) continue;
        if(board[ny][nx]) continue;
        dfs(ny, nx, island_no);
    }
}

void bfs(int y, int x){
    bool visited[100][100] = {false, };
    queue<POS> q;
    visited[y][x] = true;
    q.push({y, x, 0});

    while(!q.empty()){
        int cur_y = q.front().y;
        int cur_x = q.front().x;
        int time = q.front().time;
        q.pop();

        if(board[cur_y][cur_x] && board[cur_y][cur_x] != board[y][x]){
            // cout<<"srt_y, x: " << y <<", "<< x  << "\n";
            // cout<<"dest_y, x: " << cur_y <<", "<< cur_x  << "\n";
            // cout << "time: " << time << "\n\n";
            minimum = min(minimum, time - 1);
            return;
        }

        rep(dir, 0, 4){
            int ny = cur_y + dy[dir];
            int nx = cur_x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(board[ny][nx] == board[y][x]) continue;
            if(visited[ny][nx]) continue;
            visited[ny][nx] = true;
            q.push({ny, nx, time + 1});
        }
    }
}

int main(void){
    cin >> n;
    rep(i, 0, n){
        rep(j, 0, n){
            cin >> temp_board[i][j];
        }
    }

    //각 섬에 번호 부여
    int island_no = 0;
    rep(i, 0, n){
        rep(j, 0, n){
            if(temp_board[i][j] && !board[i][j]) dfs(i, j, ++island_no);
        }
    }

    rep(i, 0, n){
        rep(j, 0, n){
            if(!board[i][j]) continue;
            if(!is_edge(i, j)) continue;
            bfs(i, j);
        }
    }

    cout << minimum; 

}