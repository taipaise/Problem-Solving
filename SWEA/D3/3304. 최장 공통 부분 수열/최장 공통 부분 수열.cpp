#include <iostream>
#include <vector>
#include <string>
#include <cstring>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int tc;
string str1, str2;
int res;
int dp[1001][1001];

void solve(){
    REP(i, 1, str1.length()){
        REP(j, 1, str2.length()){
            if(str1[i - 1] == str2[j - 1]) 
                dp[i][j] = dp[i - 1][j - 1] + 1;
            else
                dp[i][j] = max(dp[i][j - 1], dp[i - 1][j]);
        }
    }
}

int main(void){
    cin >> tc;
    REP(t, 1, tc){
        memset(dp, 0, sizeof(dp));
        cin >> str1 >> str2;
        solve();
    
        cout << "#" << t << " ";
        cout << dp[str1.length()][str2.length()] << "\n";
    }
}