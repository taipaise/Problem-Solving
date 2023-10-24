#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

//dp[i] := i원을 만드는데 필요한 최소 동전 갯수
int n, k;
vector<int> vec;
int dp[10001];

int main(void) {
    FAST;
    cin >> n >> k;
    vec.resize(n);

    rep(i, 0, n){
        cin >> vec[i];
        if(vec[i] > 10000) continue;
        dp[vec[i]] = 1;
    } 

    REP(curVal, 1, k){
        rep(i, 0, vec.size()){
            int coin = vec[i];
            if (curVal - coin < 1) continue; // 1원보다 작은 돈은 없음
            if (dp[curVal - coin] == 0) continue; //curVal - coin원을 만들 수 있는 경우가 없는 경우

            if(dp[curVal] == 0){
                dp[curVal] = dp[curVal - coin] + 1;
            }
            else {
                dp[curVal] = min(dp[curVal], dp[curVal - coin] + 1);
            }
        }
    }

    if (dp[k] != 0) cout << dp[k];
    else cout << -1;
}