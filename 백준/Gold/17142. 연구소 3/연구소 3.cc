#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i,a,b) for(auto i = a; i <= b; i++)
using namespace std;

struct POS{
    int y;
    int x;

    bool operator<(const POS& rhs)const{
        if(y != rhs.y) return y < rhs.y;
        else return x < rhs.x;
    }
};

int n, m;
int res = 2147483647;
int board[50][50];
bool deactive[50][50] = {false,};
int dy[4] = {-1, 1, 0, 0};
int dx[4] = {0, 0, -1, 1};
vector<POS> candidate;
vector<int> virus;

void print_board(){
    rep(i, 0, n){
        rep(j, 0, n){
            cout << board[i][j];
        }
        cout << "\n";
    }
}

bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < n);
}

int check(int visited[][50]){
    int time = 0;
    rep(i, 0, n){
        rep(j, 0, n){
            if (visited[i][j] == -1) continue;

            //빈칸이 있으면 2147483647 반환
            if(visited[i][j] == 0) return 2147483647;
            else{
                if(deactive[i][j]) continue;
                time = max(time, visited[i][j]);
            }
        }
    }

    return time;
}

void spread_virus(){
    queue<POS> q;
    int visited[50][50];
    copy(&board[0][0], &board[0][0] + (50 * 50), &visited[0][0]);
    rep(i, 0, virus.size()){
        q.push(candidate[virus[i]]);
        visited[candidate[virus[i]].y][candidate[virus[i]].x] = 1;

    }

    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        q.pop();

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(visited[ny][nx] == -1) continue;
            if(visited[ny][nx] > 0) continue;

            visited[ny][nx] = visited[y][x] + 1;
            q.push({ny, nx});
        }
    }
    int temp =res;
    res = min(res, check(visited));
    // cout << "<"<<res << ">\n";
}

void locate_virus(int cnt){
    if(cnt == m){
        //바이러스를 뿌림
        spread_virus();
        return;
    }

    //재귀적으로 바이러스를 배치
    rep(i, 0, candidate.size()){
        if(virus.size() && virus.back() >= i) continue;
        virus.push_back(i);
        locate_virus(cnt + 1);
        virus.pop_back();
    }
}


int main(void){
    FAST;
    cin >> n >> m;
    rep(i, 0, n){
        rep(j, 0, n){
            cin >> board[i][j];
            if(board[i][j] == 1) board[i][j] = -1; //벽은 -1로 저징
            if(board[i][j] == 2){
                board[i][j] = -2; //비활성 바이러스는 -2로 저장
                deactive[i][j] = true;
                candidate.push_back({i, j});
            }
        }
    }
    locate_virus(0);

    if(res == 2147483647) cout << -1;
    else{
        if(res) cout << res - 1;
        else cout << res;
    }
}