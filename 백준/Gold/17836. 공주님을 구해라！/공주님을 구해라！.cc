#include <iostream>
#include <queue>
#include <algorithm>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

struct POS{
    int y;
    int x;
    int time;
};

int board[101][101];
bool visited[101][101];
int dy[4] = {-1, 1, 0, 0};
int dx[4] = {0, 0, -1, 1};
int n, m, t;
POS gram;
int dist_1, dist_2;

bool in_range(int y, int x){
    return (0 < y && y <= n) && (0 < x && x <= m);
}

void bfs(int dest_y, int dest_x){
    queue<POS> q;
    q.push({1, 1, 0});
    memset(visited, false, sizeof(visited)); 
    visited[1][1] = true;
    
    while(!q.empty()){
        // cout << dest_x;
        int y = q.front().y;
        int x = q.front().x;
        int time = q.front().time;
        q.pop();
        // cout << y <<" "<< x<<"\n";

        if(y == dest_y && x == dest_x){
            if(dest_y == n && dest_x == m) dist_1 = time;
            else gram.time = time;
            return; 
        }

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];
            
            if(!in_range(ny, nx)) continue;
            if(board[ny][nx] == 1) continue;
            if(visited[ny][nx]) continue;

            visited[ny][nx] = true;
            q.push({ny, nx, time + 1});
        }
    }
}

void bfs_Gram(){
    if(!gram.time) return; 

    queue<POS> q;
    q.push({gram.y, gram.x, gram.time});
    memset(visited, false, sizeof(visited));
    visited[gram.y][gram.x] = true;

    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        int time = q.front().time;
        // cout << y <<" "<< x<<"\n";
        q.pop();
        if(y == n && x == m) dist_2 = time;
        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];
            
            if(!in_range(ny, nx)) continue;
            if(visited[ny][nx]) continue;

            visited[ny][nx] = true;
            q.push({ny, nx, time + 1});
        }
    }
}

int main(void){
    FAST;
    cin >> n >> m >> t;

    REP(i, 1, n){
        REP(j, 1, m){
            cin >> board[i][j];
            if(board[i][j] == 2) gram = {i, j, 0};
        }
    }

    bfs(n, m);
    bfs(gram.y, gram.x);
    bfs_Gram();
    // cout << dist_1 << " " << dist_2 << " gram: "<<gram.time ;
    
    int min_dist = 0;
    if(dist_1 == 0 || dist_2 == 0) min_dist = dist_1 + dist_2;
    else min_dist = min(dist_1, dist_2);

    if(min_dist > t || min_dist == 0) cout << "Fail";
    else cout << min_dist;

}