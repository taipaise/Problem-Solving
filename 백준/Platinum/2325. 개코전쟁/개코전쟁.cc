#include <iostream>
#include <queue>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
#define MAX 2147483647
using namespace std;

struct Edge{
    int to;
    int w;

    bool operator<(const Edge& rhs)const{
        return w > rhs.w;
    }
};

int n, m;
int res;
vector<Edge> vertex[1001];
vector<int> path;
int dist[1001];
int prev_node[1001];


void dikjstra1(){
    REP(i, 0, n) dist[i] = MAX;
    priority_queue<Edge> pq;
    pq.push({1, 0});
    dist[1] = 0;

    while(!pq.empty()){
        auto[node, cost] = pq.top();
        pq.pop();

        if(dist[node] < cost) continue;

        rep(i, 0, vertex[node].size()){
            int next_node = vertex[node][i].to;
            int update_cost = cost + vertex[node][i].w;

            if(update_cost < dist[next_node]){
                prev_node[next_node] = node;
                dist[next_node] = update_cost;
                pq.push({next_node, update_cost});
            }
        }
    }
}

void dikjstra2(int a, int b){
    REP(i, 0, n) dist[i] = MAX;
    priority_queue<Edge> pq;
    pq.push({1, 0});
    dist[1] = 0;

    while(!pq.empty()){
        auto[node, cost] = pq.top();
        pq.pop();

        if(dist[node] < cost) continue;

        rep(i, 0, vertex[node].size()){
            int next_node = vertex[node][i].to;
            if((a == node && b == next_node) || (b == node && a == next_node)) continue;

            int update_cost = cost + vertex[node][i].w;

            if(update_cost < dist[next_node]){
                prev_node[next_node] = node;
                dist[next_node] = update_cost;
                pq.push({next_node, update_cost});
            }
        }
    }


    res = max(res, dist[n]);
}

void makePath(){
    int cur = n;

    while(cur != 1){
        path.push_back(cur);
        cur = prev_node[cur];
    }
    path.push_back(1);
}

int main(void){
    cin >> n >> m;

    int a, b, w;
    rep(i, 0, m){
        cin >> a >> b >> w;
        vertex[a].push_back({b, w});
        vertex[b].push_back({a, w});
    }

    dikjstra1();
    makePath();

    rep(i, 0, path.size() - 1){
        int a = path[i];
        int b = path[i + 1];

        dikjstra2(a, b);
    }

    cout << res;
}
