#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;

struct DisjointSet {
    vector<int> parents;
    vector<int> ranks;

    DisjointSet(int n) {
        parents.resize(n + 1);
        ranks.resize(n + 1, 1);

        REP(i, 0, n) {
            parents[i] = i;
        }
    }

    void merge(int u, int v) {
        u = find(u);
        v = find(v);

        if (u == v) { return; }

        if (ranks[u] > ranks[v]) { swap(u, v); }

        parents[u] = v;
        
        if (ranks[v] == ranks[u]) {
            ++ranks[v];
        }
    }

    int find(int u) {
        if (parents[u] == u) {
            return u;
        }

        return parents[u] = find(parents[u]);
    }
};

struct Edge {
    int from;
    int to;
    int cost;

    bool operator<(const Edge& rhs) const {
        return cost > rhs.cost;
    }
};

int main() {
    FAST;

    int v, e;
    int totalCost = 0;
    DisjointSet disjointSet(0);
    priority_queue<Edge> edges;

    cin >> v >> e;
    disjointSet = DisjointSet(v);

    rep(i, 0, e) {
        int from, to, cost;
        cin >> from >> to >> cost;
        edges.push({from, to, cost});
    }

    while (!edges.empty()) {
        Edge edge = edges.top();
        int from = edge.from;
        int to = edge.to;
        edges.pop();

        if (disjointSet.find(from) == disjointSet.find(to)) { continue; }

        totalCost += edge.cost;
        disjointSet.merge(from, to);
    }

    cout << totalCost;
}