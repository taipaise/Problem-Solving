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

//dp[j] := j라는 cost가 주어졌을때 얻을 수 있는 최대 memory의 양

vector<int> memory;
vector<int> cost;
vector<int> dp;
int max_cost = 0;

int main(void){
    int n, m;
    cin >> n >> m;
    memory.resize(n + 1);
    cost.resize(n + 1);

    REP(i, 1, n){
        cin >> memory[i];
    }
    REP(i, 1, n){
        cin >> cost[i];
        max_cost += cost[i];
    }
    dp.resize(max_cost + 1);

    REP(i, 1, n){
        for(int j = max_cost; j >= 0; j--){
            if(cost[i] > j) continue;
            dp[j] = max(dp[j], dp[j - cost[i]] + memory[i]);
        }
    }

    REP(i, 0 , max_cost){
        if(dp[i] >= m){
            cout << i;
            break;
        }
    }
    return 0;
}