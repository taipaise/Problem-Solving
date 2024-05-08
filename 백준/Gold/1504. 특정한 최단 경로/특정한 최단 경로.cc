#include <iostream>
#include <queue>
#include <vector>
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


vector<int> dist1;
vector<int> distA;
vector<int> distB;
vector<pair<int, int>> vertex[801];
priority_queue<pair<int, int>> q;

int n, e;
int a, b, c;
int u, v; 

void dijkstra(int a, int b){
    dist1.resize(n + 1);
    distA.resize(n + 1);
    distB.resize(n + 1);

    REP(i, 1, n){
        dist1[i] = INF;
        distA[i] = INF;
        distB[i] = INF;
    }
    dist1[1] = 0;
    distA[a] = 0;
    distB[b] = 0;

    //1번 노드부터 다른 노드들까지 최단거리 : dist1
    q.push({0, 1});
    while(!q.empty()){
        int cost = q.top().first;
        int node = q.top().second;
        q.pop();
        
        if(dist1[node] < cost) continue;

        rep(i, 0, vertex[node].size()){
            int update_cost = cost + vertex[node][i].first;
            if(update_cost < dist1[vertex[node][i].second]){
                dist1[vertex[node][i].second] = update_cost;
                q.push({update_cost, vertex[node][i].second});
            }
        }
    }

    //a번 노드부터 다른 노드들까지 최단거리 : distA
    q.push({0, a});
    while(!q.empty()){
        int cost = q.top().first;
        int node = q.top().second;
        q.pop();
        
        if(distA[node] < cost) continue;

        rep(i, 0, vertex[node].size()){
            int update_cost = cost + vertex[node][i].first;
            if(update_cost < distA[vertex[node][i].second]){
                distA[vertex[node][i].second] = update_cost;
                q.push({update_cost, vertex[node][i].second});
            }
        }
    }

    //b번 노드부터 다른 노드들까지 최단거리 : distB
    q.push({0, b});
    while(!q.empty()){
        int cost = q.top().first;
        int node = q.top().second;
        q.pop();
        
        if(distB[node] < cost) continue;

        rep(i, 0, vertex[node].size()){
            int update_cost = cost + vertex[node][i].first;
            if(update_cost < distB[vertex[node][i].second]){
                distB[vertex[node][i].second] = update_cost;
                q.push({update_cost, vertex[node][i].second});
            }
        }
    }
}

int main(){
    FAST;
    cin >> n >> e;
    rep(i, 0, e){
        cin >> a >> b >> c;
        vertex[a].pb({c, b});
        vertex[b].pb({c, a});
    }
    cin >> u >> v;
    dijkstra(u, v);

    //case1:  1 >> a >> b >> n
    //case2: 1 >> b >> a >> n
    
    int res1 = 0;
    int res2 = 0;
    
    if(dist1[u] == INF || distA[v] == INF || distB[n] == INF) res1 = INF;
    else res1 = dist1[u] + distA[v] + distB[n];
    
    if(dist1[v] == INF || distB[u] == INF || distA[n] == INF) res2 = INF;
    else res2 = dist1[v] + distB[u] + distA[n];

    int res = min(res1, res2);
    if(res == INF) res = -1;
    cout << res;

    return 0;
}