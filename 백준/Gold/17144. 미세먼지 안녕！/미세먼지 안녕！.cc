#include <iostream>
#include <algorithm>
#include <vector>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i,a,b) for(auto i = a; i <= b; i++)

using namespace std;

struct POS{
    int y;
    int x;
};

int home[50][50];
int r, c;
int t;
//위쪽 청정기 순환 방향
int udy[] = {0, -1, 0, 1};
int udx[] = {1, 0, -1, 0};
//아래쪽 청정기 순환 방향
int ddy[] = {0, 1, 0, -1};
int ddx[] = {1, 0, -1, 0};
vector<POS> cleaner;

void print_home(){
    rep(i, 0, r){
        rep(j, 0, c){
            cout << home[i][j] << " ";
        }
        cout << "\n";
    }
}

//미세먼지 수치 확인하는 함수
int mimun(){
    int res = 0;
    rep(i, 0, r){
        rep(j, 0, c){
            if(home[i][j] <= 0) continue;
            res += home[i][j];
        }
    }
    return res;
}

bool in_range(int y, int x){
    return (0 <= y && y < r) && (0 <= x && x < c);
}

void spread(){

//원본 배열을 기준으로 미세먼지 확산은 복사본에 하기
//확산 완료시 복사본 배열을 원본 배열에 붙여넣기
    int temp_home[50][50] = {0,};
    rep(i, 0, r){
        rep(j, 0, c){
            if(home[i][j] > 0){
                int cnt = 0;
                int spread_amount = home[i][j] / 5;
                //각 방향으로 미세먼지 확산
                rep(k, 0, 4){
                    int ny = i + udy[k];
                    int nx = j + udx[k];
                    //갈 수 없거나 공기 청정기 있으면 continue
                    if(home[ny][nx] == -1) continue;
                    if(!in_range(ny, nx)) continue;
                    temp_home[ny][nx] += spread_amount;
                    ++cnt;
                }
                //원래 자리에 남는 양 : 원래 양 -  ((원래 양/5) * 확산된 방향 갯수)
                temp_home[i][j] += (home[i][j] - (spread_amount * cnt));
            }
        }
    }
    //복사본을 원본으로 옮김
    rep(i, 0, r){
        rep(j, 0, c){
            home[i][j] = temp_home[i][j];
        }
    }
    rep(i, 0, 2){
        home[cleaner[i].y][cleaner[i].x] = -1;
    }
}

//공기 청정기 작동
void wind(){
    rep(i, 0, 2){
        int next = -1;
        int cur = -1;
        int y = cleaner[i].y;
        int x = cleaner[i].x;
        int ny = y;
        int nx = x;
        int dir = 0;
        
        while(true){
            //위쪽 공기 청정기
            if(i == 0){
                ny = y + udy[dir];
                nx = x + udx[dir];
            }
            //아래쪽 공기 청정기
            else{
                ny = y + ddy[dir];
                nx = x + ddx[dir];
            }
            
            //공간의 끝에 다다르면 방향 바꿔줌
            if(!in_range(ny, nx)){
                ++dir;
                dir %= 4;
                continue;
            }

            //순환 다 하면 종료
            if(ny == cleaner[i].y && nx == cleaner[i].x) break;

            cur = next;
            next = home[ny][nx];
            
            if(cur != -1)
                home[ny][nx] = cur;
            else{
                home[ny][nx] = 0;
            }
            y = ny;
            x = nx;
        }
    }
}

int solve(){
    rep(i, 0, t){
        //1. 미세먼지 확산
        spread();
        //2. 공기 청정기 작동
        wind();
    }
    return mimun();
}
int main(void){
    FAST;

    cin >> r >> c >> t;

    rep(i, 0, r){
        rep(j, 0, c){
            cin >> home[i][j];

            if(home[i][j] == -1){
                cleaner.push_back({i, j});
            }
        }
    }
    
    cout << solve();
    // print_home();
    return 0;
}