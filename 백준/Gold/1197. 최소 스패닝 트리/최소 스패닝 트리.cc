#include <iostream>
#include <algorithm>
#include <vector>

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
    int from;
    int to;
    int weight;

    bool operator< (const Edge &rhs){//RHS = right hand side value
        return weight < rhs.weight;
    } 
};

struct DisjointSet{
    int n;
    vector<int> parent;
    vector<int> rank;
    
    DisjointSet(int n): n(n), parent(n + 1), rank(n + 1) {
        REP(i, 1, n){
            parent[i] = i;
            rank[i] = 1;
        }
    }

    int find(int u){
        if(u == parent[u]) return u;
        return parent[u] = find(parent[u]);
    }

    void merge(int u, int v){
        u = find(u);
        v = find(v);

        if (u == v) return;

        if(rank[u] > rank[v]) swap(u, v);
        parent[u] = v;

        if(rank[u] == rank[v]) ++rank[v];
    }
};

int v, e;
vector<Edge> edges;
int from, to, weight;
int res = 0;

int main(void)
{
    FAST;
    cin >> v >> e;
    DisjointSet disjointset = DisjointSet(v);

    rep(i, 0, e){
        cin >> from >> to >> weight;
        edges.pb({from, to, weight});
    }

    sort(edges.begin(), edges.end());

    rep(i, 0, e){
        if(disjointset.find(edges[i].from) == disjointset.find(edges[i].to)) continue;
        disjointset.merge(edges[i].from, edges[i].to);
        res += edges[i].weight;
    }
    cout << res;
}