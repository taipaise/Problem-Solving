#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n;
int dp[5001]; // dp[i] := i킬로그램의 설탕을 배달할때 필요한 최소 설탕 봉지 수

int main(void){
    cin >> n;

    dp[3] = 1;
    dp[5] = 1;

    REP(i, 6, n){
        if(dp[i - 3] == 0 && dp[i - 5] == 0) continue;

        int minVal = min(dp[i - 3], dp[i - 5]);
        if(minVal == 0) minVal = max(dp[i - 3], dp[i - 5]);
        dp[i] = minVal + 1;
    }

    if(dp[n] == 0) cout << -1;
    else cout << dp[n];
}