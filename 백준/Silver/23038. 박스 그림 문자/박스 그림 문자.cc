#include <iostream>
#include <vector>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

char board[900][900];
int n, m;

bool in_range(int y, int x){
    return (0 <= y && y < (3 * n)) && (0 <= x && x < (3 * m));
}

void recovery(int y, int x){
    y *= 3;
    x *= 3;
    bool flag = false;

    if(in_range(y - 1, x + 1)){
        if(board[y - 1][x + 1] == '#'){
            board[y][x + 1] = '#';
            flag = true;
        }
    }
    if(in_range(y + 1, x - 1)){
        if(board[y + 1][x - 1] == '#'){
            board[y + 1][x] = '#';
            flag = true;
        }
    }
    if(in_range(y + 1, x + 3)){
        if(board[y + 1][x + 3] == '#'){
            board[y + 1][x + 2] = '#';
            flag = true;
        }
    }
    if(in_range(y + 3, x + 1)){
        if(board[y + 3][x + 1] == '#'){
            board[y + 2][x + 1] = '#';
            flag = true;
        }
    }

    if(flag) board[y + 1][x + 1] = '#';
}


void print_board(){
    rep(i, 0, (3 * n)){
        rep(j, 0 ,(3 * m)) cout << board[i][j];
        cout << "\n";
    }
}

int main(void){
    FAST;
    cin >> n >> m;

    rep(i, 0, (3 * n))
        rep(j, 0, (3 * m))
            cin >> board[i][j];

    rep(i, 0, n){
        rep(j, 0, m){
            if((i + j + 2) %2 != 1) continue;
            recovery(i, j);
        }
    }

    print_board();
}