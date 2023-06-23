#include <iostream>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

int n;
int dy[8] = {-1, 1, 0, 0, -1, 1, -1, 1};
int dx[8] = {0, 0, -1, 1, -1, 1, 1, -1};
char bomb[10][10];
char board[10][10];

bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < n);
}

void print_board(){
    rep(i, 0, n){
        rep(j, 0, n){
            cout << board[i][j];
        }
        cout << "\n";
    }
}

void check_bomb(){
    rep(i, 0, n){
        rep(j, 0, n){
            if(bomb[i][j] == '*'){
                board[i][j] = '*';
            }
        }
    }
}

void solve(){
    bool is_finish = false;

    rep(i, 0, n){
        rep(j, 0, n){
            int cnt = 0;
            if(board[i][j] == '.') continue;

            if(bomb[i][j] == '*'){
                is_finish = true;
                continue;
            }
            rep(dir, 0, 8){
                int ny = i + dy[dir];
                int nx = j + dx[dir];

                if(!in_range(ny, nx)) continue;
                if(bomb[ny][nx] == '*') ++cnt;
            }
            board[i][j] = cnt + '0';
        }
    }
    if(is_finish) check_bomb();
}

int main(void){
    FAST;

    cin >> n;
    rep(i, 0, n){
        rep(j, 0, n){
            cin >> bomb[i][j];
        }
    }

    rep(i, 0, n){
        rep(j, 0, n){
            cin >> board[i][j];
        }
    }

    solve();
    print_board();
}