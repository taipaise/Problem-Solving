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

    bool operator<(const Edge& rhs)const{
        return w < rhs.w;
    }
};

int n, busCnt;
int from, dest;
vector<Edge> city[1001];
int dist[1001];
int prev_city[1001];
vector<int> res;

void dikjstra(){
    REP(i, 0, 1000) dist[i] = MAX;
    priority_queue<Edge> pq;
    pq.push({from, 0});
    dist[from] = 0;

    while(!pq.empty()){
        int node = pq.top().to;
        int weight = pq.top().w;
        pq.pop();

        if(dist[node] < weight) continue;

        rep(i, 0, city[node].size()){
            int cost = weight + city[node][i].w;
            int next_node = city[node][i].to; 

            if(cost < dist[next_node]){
                prev_city[next_node] = node;
                dist[next_node] = cost;
                pq.push({next_node, cost});
            }
        }
    }
}

void makeRes(){
    res.push_back(dest);

    int cur_node = dest;
    while(cur_node != from){
        cur_node = prev_city[cur_node];
        res.push_back(cur_node);
    }
    reverse(res.begin(), res.end());
}

int main(void){
    cin >> n >> busCnt;

    rep(i, 0, busCnt){
        int from, to, weight;
        cin >> from >> to >> weight;
        city[from].push_back({to, weight});
    }
    cin >> from >> dest;

    dikjstra();
    makeRes();
    cout << dist[dest] << "\n" <<  res.size() << "\n";
    rep(i,0,res.size()) cout << res[i] << " ";

}