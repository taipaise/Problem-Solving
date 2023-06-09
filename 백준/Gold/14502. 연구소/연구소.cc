#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

struct POS{
    int y;
    int x;
};

int n, m;
int factory[8][8];
int factory_copy[8][8];
int dy[] = {-1, 1, 0, 0};
int dx[] = {0, 0, -1, 1};
int max_safe_area = 0;
vector<POS> virus;

bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < m);
}

void print_map(){
    rep(i, 0, n){
        rep(j, 0 ,m){
            cout << factory_copy[i][j] << " ";
        }
        cout << "\n";
    }
    cout << "\n";
}
void spread_virus(){
    queue<POS> q;

    for(auto &e: virus) q.push(e);

    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        q.pop();

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(factory_copy[ny][nx]) continue;
            factory_copy[ny][nx] = 2;
            q.push({ny, nx});
        }
    }
}

int get_safe_area(){
    int res = 0;

    rep(i, 0, n){
        rep(j, 0, m){
            if(factory_copy[i][j] == 0) ++res;
        }
    }
    return res;
}

void solve(int wall_cnt, int y){
    if(wall_cnt == 3){
        rep(i, 0, n){
            rep(j, 0, m){
                factory_copy[i][j] = factory[i][j];
            }
        }
        spread_virus();
        max_safe_area = max(max_safe_area, get_safe_area());
        return;
    }

    rep(i, y, n){
        rep(j, 0, m){
            if(factory[i][j]) continue;
            factory[i][j] = 1;
            solve(wall_cnt + 1, i);
            factory[i][j] = 0;
        }
    }
}

int main(void){
    FAST;
    cin >> n >> m;

    rep(i, 0, n){
        rep(j, 0, m){
            cin >> factory[i][j];
            if(factory[i][j] == 2) virus.push_back({i, j});
        }
    }
    solve(0, 0);
    cout << max_safe_area;
}