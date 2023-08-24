#include <iostream>
#include <algorithm>
#include <vector>
#include <queue>
#include <limits>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
#define MAX 100000000000 
using namespace std;
typedef long long ll;

struct Edge{
    int to;
    int w;
};

struct Edge2{
    int to;
    int w;
    int moveCnt;

    bool operator<(const Edge2& rhs)const{
        return w > rhs.w;
    }
};

int n, m, k;
int srt, dest;
vector<Edge> vertex[1001];
ll dp[1001][1001]; // dp[i][j] := i번째 도시에 j개의 도로를 이용하여 도착했을때 최소비용

void dikjstra(){
    priority_queue<Edge2> pq;
    dp[srt][0] = 0;
    pq.push({srt, 0, 0});

    while(!pq.empty()){
        auto[node, cost, moveCnt] = pq.top();
        pq.pop();

        if(moveCnt >= n) continue;
        if(dp[node][moveCnt] < cost) continue;

        rep(i, 0, vertex[node].size()){
            int nextNode = vertex[node][i].to;
            int updateCost = cost + vertex[node][i].w;

            if(updateCost < dp[nextNode][moveCnt + 1]){
                dp[nextNode][moveCnt + 1] = updateCost;
                pq.push({nextNode, updateCost, moveCnt + 1});
            }
        }
    }
}

ll getRes(int inc){
    ll res = MAX;

    rep(i, 1, n){
        if(dp[dest][i] == MAX) continue;
        res = min(res, dp[dest][i] + (inc * i));
    }
    return res;
}

int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    cin >> n >> m >> k;
    cin >> srt >> dest;

    REP(i, 0, n)
        REP(j, 0, n)
            dp[i][j] = MAX;

    int nodeA, nodeB, cost;
    rep(i, 0, m){
        cin >> nodeA >> nodeB >> cost;
        vertex[nodeA].push_back({nodeB, cost});
        vertex[nodeB].push_back({nodeA, cost});
    }

    dikjstra();

    int taxInc = 0;
    cout << getRes(taxInc) << "\n";
    rep(i, 0, k){
        int curInc;
        cin >> curInc;
        taxInc += curInc;

        cout << getRes(taxInc) << "\n";
    }
}