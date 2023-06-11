#include <iostream>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

string str1;
string str2;

int dp[1001][1001];

int main(void){
    FAST;
    cin >> str1 >> str2;
    REP(i, 1, str1.length()){
        REP(j, 1, str2.length()){
            if (str1[i - 1] == str2[j - 1]) dp[i][j] = dp[i - 1][j - 1] + 1;
            else dp[i][j] = max(dp[i - 1][j], dp[i][j- 1]);
        }
    }
    cout << dp[str1.length()][str2.length()];
}