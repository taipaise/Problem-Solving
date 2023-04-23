#include <vector>
#include <iostream>
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

int square[1001][1001];
int dp[1001][1001];

int main(void){
    int n, m, res;
    cin >> n >> m;
    rep(i, 1, n + 1){
        string temp;
        cin >> temp;
        rep(j, 0, m + 1){
            square[i][j + 1] = temp[j] - '0';
        }
    }

    res = 0;

    rep(i, 1, n + 1){
        rep(j, 1, m + 1){
            //0이 나오면 만들 수 있는 최대 정사각형 길이는 0
            if(square[i][j] == 0) continue;

            dp[i][j] = min(dp[i - 1][j], min(dp[i][j - 1], dp[i - 1][j - 1])) + 1;
            res = max(dp[i][j], res);
        }
    }
    cout << res*res;
    return 0;
}

