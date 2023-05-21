#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end() 
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

int n;
int cnt = 0;
int dp[1000001];
int record[1000001];
queue<int> res;

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n;

    dp[1] = 0;
    dp[2] = 1;
    dp[3] = 1;
    record[1] = 0;
    record[2] = 1;
    record[3] = 1;
    REP(i, 4, n) dp[i] = i;

    REP(i, 2, n){
        if((i % 3 == 0) && dp[i] > dp[i / 3] + 1){
            dp[i] = dp[i / 3] + 1;
            record[i] = i / 3;
            }
        if(i % 2 == 0 && dp[i] > dp[i / 2] + 1){
            dp[i] = dp[i / 2] + 1;
            record[i] = i / 2;
        }
        if(dp[i] > dp[i - 1] + 1){
            dp[i] = dp[i - 1] + 1;
            record[i] = i - 1;
        }
    }
    cout << dp[n] << endl;

    int index = n;
    res.push(n);
    while(1){
        // cout <<"a";
        res.push(record[index]);
        if(record[index] == 1 || index == 1) break;
        index = record[index];
    }

    while(!res.empty()){
        if(res.front() != 0) cout << res.front() << " ";
        res.pop();
    }
    

    
    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
