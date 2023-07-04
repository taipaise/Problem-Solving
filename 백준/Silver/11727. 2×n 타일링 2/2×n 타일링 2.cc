#include <iostream>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

int dp[1001];

int n;
int main(void){
    cin >> n;

    dp[0] = 0;
    dp[1] = 1;
    dp[2] = 3;
    // dp[n] =(dp[n - 2] * 2)  + dp[n - 1];
    REP(i, 3, n){
        dp[i] = (dp[i - 2] * 2) % 10007 + (dp[i - 1] % 10007);
        
    }

    cout << dp[n] % 10007;
}