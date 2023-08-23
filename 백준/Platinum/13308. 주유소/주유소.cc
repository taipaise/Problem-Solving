#include <iostream>
#include <algorithm>
#include <queue>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
#define MAX 2147483647
using namespace std;

struct Edge{
    int to;
    int w;
};

struct Acc{
    int node;
    int cost;
    int oil;

    bool operator<(const Acc& rhs)const{
        return cost > rhs.cost;
    }
};

int dp[2501][2501]; // dp[i][j] := j기름값으로 i라는 도시에 도달하는데 필요한 최소 비용
int oil_cost[2501];
vector<Edge> vertex[2501];
int n, m;

void dikjstra(){
    priority_queue<Acc> pq;
    pq.push({1, 0, oil_cost[1]});
    dp[1][oil_cost[1]] = 0;

    while(!pq.empty()){
        auto[node, cost, oil] = pq.top();
        pq.pop();

        if(dp[node][oil] < cost) continue;

        rep(i, 0, vertex[node].size()){
            int next_node = vertex[node][i].to;
            int update_oil = min(oil, oil_cost[node]);
            int update_cost = cost + (vertex[node][i].w * update_oil);

            if(update_cost < dp[next_node][update_oil]){
                dp[next_node][update_oil] = update_cost;
                pq.push({next_node, update_cost, update_oil});
            }
        }
    }

}

int get_res(){
    int res = MAX;
    REP(i, 1, 2500){
        // if(res > dp[n][i]) cout << min(res, dp[n][i]) << "\n";
        res = min(res, dp[n][i]);
    } 
    return res;
}


int main(void){
    cin >> n >> m;
    
    REP(i, 1, n) cin >> oil_cost[i];

    REP(i, 1, n)
        REP(j, 1, 2500)
            dp[i][j] = MAX;
    

    int a, b, w;
    rep(i, 0, m){
        cin >> a >> b >> w;
        vertex[a].push_back({b, w});
        vertex[b].push_back({a, w});
    }

    dikjstra();

    cout << get_res();

}