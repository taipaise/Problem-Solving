#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
struct POS{
    int y;
    int x;
};

int n;
int lo = 0;
int hi = 0;
int home_cnt = 0;
int res = 2147483647;
POS post; //우체국 위치(시작 위치)
char board[50][50];
int altitude[50][50];
bool visited[50][50];
vector<int> vec; //투 포인터 사용하기 위해 고도를 벡터에 저장
//상하좌우 대각선 이동
int dy[8] = {-1, -1, -1, 0, 1, 1, 1, 0};
int dx[8] = {-1, 0, 1, 1, 1, 0, -1, -1};

bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < n);
}

//lo ~ hi 사이 고도로 모든 집을 방문할 수 있나 bfs로 확인
bool bfs(){
    queue<POS> q;
    while(!q.empty()) q.pop();
    memset(visited, 0, sizeof(visited));
    if(vec[lo] <= altitude[post.y][post.x] && altitude[post.y][post.x] <= vec[hi]){
        visited[post.y][post.x] = true;
        q.push({post.y, post.x});
    }

    int cnt = 0; //집 방문 횟수
    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        q.pop();

        if(cnt == home_cnt) return true;

        rep(dir, 0, 8){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(visited[ny][nx]) continue;
            if(altitude[ny][nx] < vec[lo] || altitude[ny][nx] > vec[hi]) continue;

            if(board[ny][nx] == 'K') ++cnt;
            visited[ny][nx] = true;
            q.push({ny, nx});
        }
    }

    return false;
}


int main(void){
    FAST;
    cin >> n;

    rep(i, 0, n){
        rep(j, 0, n){
            cin >> board[i][j];
            if(board[i][j] == 'P') post = {i, j};
            if(board[i][j] == 'K') ++home_cnt;
        }
    }
    rep(i, 0, n){
        rep(j, 0, n){
            cin >> altitude[i][j];
            vec.push_back(altitude[i][j]);
        }
    }

    //고도 정렬 후 중복값 제거
    sort(vec.begin(), vec.end());
    vec.erase(unique(vec.begin(), vec.end()), vec.end());
    
    //투 포인터 활용하여 최소 피로도를 구함
    while(hi < vec.size() && lo < vec.size()){
        if(bfs()){
            res = min(res, vec[hi] - vec[lo]);
            
            if(lo <= hi) ++lo;
            else ++hi;
        }
        else ++hi;
    }

    cout << res;

}