#include <iostream>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int board[7][7];
int dp[7][7][3];
int n, m;

void make_dp(){
    REP(i, 2, n){
        REP(j, 1, m){
            dp[i][j][0] = min(dp[i - 1][j + 1][1], dp[i - 1][j + 1][2]) + board[i][j];
            dp[i][j][1] = min(dp[i - 1][j][0], dp[i - 1][j][2]) + board[i][j];
            dp[i][j][2] = min(dp[i - 1][j - 1][0], dp[i - 1][j - 1][1]) + board[i][j];

            rep(k, 0, 3){
                if(dp[i][j][k] < 0) dp[i][j][k] = 2147483647;
            }
        }
        
    }
}

int main(void){
    FAST;
    fill(&dp[0][0][0], &dp[6][6][3], 2147483647);
    cin >> n >> m;
    REP(i, 1, n){
        REP(j, 1, m){
            cin >> board[i][j];
        }
    }

    REP(i, 1, m){
        rep(j, 0, 3){
            dp[1][i][j] = board[1][i];
        }
    }



    make_dp();
    
    int min_val = 2147483647;
    REP(i, 1, m){
        rep(j, 0, 3){
            min_val = min(min_val, dp[n][i][j]);
        }
    }

    cout << min_val;
    return 0;
}
