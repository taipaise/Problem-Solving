#include <iostream>
#include <algorithm>
#include <vector>
#include <queue>
#include <limits>

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

int n, m;
int from, to, weight;
vector<int> dist;
vector<pair<int, int>> vertex[1001];

void dijkstra(int start){
    dist.resize(n + 1);
    REP(i, 1, n) dist[i] = INF;
    priority_queue<pair<int ,int>> pq; // <가중치, 노드>
    dist[start] = 0;
    pq.push({0, start});

    while(!pq.empty()){
        int cost = pq.top().first; // 가중치
        int cur_node = pq.top().second; // 노드
        pq.pop();

        if(dist[cur_node] < cost) continue;

        rep(i, 0, vertex[cur_node].size()){
            int update_cost = cost + vertex[cur_node][i].first;
            if(update_cost < dist[vertex[cur_node][i].second]){
                dist[vertex[cur_node][i].second] = update_cost;
                pq.push({update_cost, vertex[cur_node][i].second});
            }
        }
    }
}

int main(void){
    FAST;
    cin >> n >> m;
    rep(i, 0, m){
        cin >> from >> to >> weight;
        vertex[from].pb({weight, to});
    }
    cin >> from >> to;
    dijkstra(from);

    cout << dist[to];
}