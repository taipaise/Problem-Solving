#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <climits>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;

// 데이터 구조 
struct Edge {
    int next;
    int cost;

    bool operator<(const Edge& rhs) const {
        return cost > rhs.cost;
    }
};

// 변수 및 상수
int nodeCount, edgeCount;
vector<int> routes;
vector<int> dist;
vector<vector<Edge>> edges;

void dijkstra() {
    priority_queue<Edge> pq;
    pq.push({2, 0});
    dist[2] = 0;

    while (!pq.empty()) {
        Edge edge = pq.top();
        pq.pop();

        int node = edge.next;
        int cost = edge.cost;

        if (dist[node] < cost) { continue; }

        rep(i, 0, edges[node].size()) {
            Edge edge = edges[node][i];
            int next = edge.next;
            int newCost = edge.cost + dist[node];
            
            if (dist[next] <= newCost) { continue; }

            dist[next] = newCost;
            pq.push({next, newCost});
        }
    }
}

int findRoute(int node) {
    if (node == 2) { return 1; }
    if (routes[node] != -1) { return routes[node]; }

    routes[node] = 0;

    rep(i, 0, edges[node].size()) {
        // 합리적인 이동경로인지 확인
        Edge edge = edges[node][i];
        int next = edge.next;

        if (dist[next] >= dist[node]) { continue; }
        routes[node] += findRoute(next);
    }

    return routes[node];
}

int main() {
    FAST;
    cin >> nodeCount >> edgeCount;
    routes.resize(nodeCount + 1, -1);
    dist.resize(nodeCount + 1, INT_MAX);
    edges.resize(nodeCount + 1);

    rep(i, 0, edgeCount) {
        int nodeA, nodeB, cost;
        cin >> nodeA >> nodeB >> cost;

        edges[nodeA].push_back({nodeB, cost});
        edges[nodeB].push_back({nodeA, cost});
    }

    dijkstra(); 
    cout << findRoute(1);
}