#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
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

struct Edge{
    int weight;
    int to;

    bool operator<(const Edge &rhs)const{
        return weight > rhs.weight;
    }
};

vector<int> dist;
vector<Edge> vertex[20001];
priority_queue<Edge> q;

int v, e, s;
int from, to, weight;


int main(void){
    FAST;
    cin >> v >> e >> s;
    dist.resize(v + 1);

    rep(i, 0, e){
        cin >> from >> to >> weight;
        vertex[from].pb({weight, to});
    }
    REP(i, 1, v) dist[i] = INF;

    q.push({0, s});
    dist[s] = 0;

    while(!q.empty()){
        int cur_node = q.top().to;
        int d = q.top().weight;
        q.pop();

        if(dist[cur_node] < d) continue;

        rep(i, 0, vertex[cur_node].size()){
            int cost = d + vertex[cur_node][i].weight;

            if(cost < dist[vertex[cur_node][i].to]){
                dist[vertex[cur_node][i].to] = cost;
                q.push({cost, vertex[cur_node][i].to});
            }
        }
    }
    REP(i, 1, v){
        if(dist[i] == INF) cout << "INF\n";
        else cout << dist[i] << "\n";
    }
}