#include <iostream>
#include <vector>
#include <climits>
#include <queue>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
using namespace std;

struct Edge {
    int to;
    int dist;

    bool operator<(const Edge& rhs) const {
        return dist > rhs.dist;
    }
};

//가장 먼 노드, 해당 노드까지의 거리 return
pair<int, int> dijkstra(int size, int start, vector<vector<Edge>>& graph) {
    vector<int> dp(size + 1, 1e7);
    priority_queue<Edge> edges;
    dp[start] = 0;
    edges.push({start, 0});


    while (!edges.empty()) {
        Edge edge = edges.top();
        edges.pop();

        int node = edge.to;
        int dist = edge.dist;

        if (dp[node] < dist) { continue; }

        for(Edge nextEdge: graph[node]) {
            int nextNode = nextEdge.to;
            int newDist = dp[node] + nextEdge.dist;

            if (dp[nextNode] <= newDist) { continue; }

            dp[nextNode] = newDist;
            edges.push({nextNode, newDist});
        }
    }

    auto maxIt = max_element(dp.begin() + 1, dp.end());
    int maxIndex = distance(dp.begin(), maxIt);
    
    return {maxIndex, *maxIt};
}

int main() {
    FAST;
    int n;
    vector<vector<Edge>> graph;

    cin >> n;

    graph.resize(n + 1);

    rep(i, 0, n) {
        int node;
        int next, dist;

        cin >> node;
        cin >> next;

        while(next != -1) {
            cin >> dist;
            graph[node].push_back({next, dist});
            cin >> next;
        }
    }

    pair<int, int>rootOrLeaf = dijkstra(n, 1, graph);
    pair<int, int>res = dijkstra(n, rootOrLeaf.first, graph);
    cout << res.second;
}