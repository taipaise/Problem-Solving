#include <iostream>
#include <vector>
#include <cstring>
#include <algorithm>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;
int n;
int res = 0;
string board[50];

int getMaxCol() { //열에서 가장 긴 부분 구하기
    int res = 1; //최대로 연속하는 갯수
    int cur = 1; // 현재 연속하는 갯수

    rep(i, 0, n){
        char c = board[0][i];
        cur = 1;
        rep(j, 1, n){
            if(c == board[j][i]) { //이전 문자랑 같은 경우
                ++cur;
                res = max(res, cur);
            }
            else { // 이전 문자와 다른 경우
                cur = 1;
            }
            c = board[j][i];
        }
    }

    return res;
}

int getMaxRow() {// 행에서 가장 긴 부분 구하기
    int res = 1; //최대로 연속하는 갯수
    int cur = 1; // 현재 연속하는 갯수

    rep(i, 0, n){
        char c = board[i][0];
        cur = 1;
        rep(j, 1, n){
            if(c == board[i][j]) { //이전 문자랑 같은 경우
                ++cur;
                res = max(res, cur);
            }
            else { // 이전 문자와 다른 경우
                cur = 1;
            }
            c = board[i][j];
        }
    }

    return res;
}

void getMax(){
    res = max(res, getMaxCol());
    res = max(res, getMaxRow());
}

void swap(int y1, int x1, int y2, int x2) {
    char temp = board[y1][x1];
    board[y1][x1] = board[y2][x2];
    board[y2][x2] = temp;
}


int main(void){   
    cin >> n;

    rep(i, 0, n) cin >> board[i];

    //좌우로 바꾸는 경우의 수
    rep(i, 0, n){
        rep(j, 0, n - 1){
            swap(i, j, i, j + 1);
            getMax();
            swap(i, j, i, j + 1);
        }
    }

    //상하로 바꾸는 경우의 수
    rep(i, 0, n){
        rep(j, 0, n - 1){
            swap(j, i, j + 1, i);
            getMax();
            swap(j, i, j + 1, i);
        }
    }

    cout << res;
}
