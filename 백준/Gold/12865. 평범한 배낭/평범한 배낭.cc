#include <iostream>
#include <vector>
#include <string>
#include <cstring>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

struct Stuff{
    int volume;
    int cost;
};

int tc;
int n, k;

vector<Stuff> stuff;
int dp[101][100001];

void init(){
    stuff.clear();
    memset(dp, 0, sizeof(dp));
}

void solve(){
    REP(i, 1, n){
        REP(j, 1, k){
            if(stuff[i].volume <= j)
                dp[i][j] = max(dp[i - 1][j], (dp[i - 1][j - stuff[i].volume] + stuff[i].cost));
            else
                dp[i][j] = dp[i - 1][j];
        }
    }
}

int main(void){
    FAST;

    cin >> n >> k;
    stuff.resize(n + 1);

    int v, c;
    REP(i, 1, n){
        cin >> v >> c;
        stuff[i] = {v, c};
    }
    solve();
    cout << dp[n][k] << "\n";\
}
