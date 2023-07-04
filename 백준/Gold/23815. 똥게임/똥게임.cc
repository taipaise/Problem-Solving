#include <iostream>
#include <string>
#include <algorithm>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

int n;
int dp[100001][2];

int calc(string str, int cnt){
    if(str[0] == '+') return cnt + stoi(str.substr(1));
    else if(str[0] == '-') return cnt - stoi(str.substr(1));
    else if(str[0] == '*') return cnt * stoi(str.substr(1));
    else return cnt / stoi(str.substr(1));
}


int main(void){
    FAST;
    dp[0][0] = 1;
    dp[0][1] = 1;
    cin >> n;
    string opt1;
    string opt2;

    REP(i, 1, n){
        cin >> opt1 >> opt2;
        if(dp[i - 1][0] > 0){
            int res1 = calc(opt1, dp[i - 1][0]);
            int res2 = calc(opt2, dp[i - 1][0]);

            dp[i][0] = max(res1, res2);
        }
        else dp[i][0] = -1;

        int res1_skip, res2_skip, res_skip;
        if(dp[i - 1][1] > 0){
            res1_skip = calc(opt1, dp[i - 1][1]);
            res2_skip = calc(opt2, dp[i - 1][1]);
            res_skip = max(res1_skip, res2_skip);
        }
        else res_skip = -1;

        dp[i][1] = max(res_skip, dp[i - 1][0]);

        // cout << "i: " << i << dp[i][0] << " " << dp[i][1] << "\n";

    }

    if(dp[n][0] > 0 || dp[n][1] > 0) cout << max(dp[n][0], dp[n][1]);
    else cout << "ddong game";

}