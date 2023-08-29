#include <iostream>
#include <algorithm>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
typedef long long ll;

struct Edge{
    int node1;
    int node2;
    ll w;

    bool operator<(const Edge& rhs)const{
        return w < rhs.w;
    }
};

struct DisjointSet{
    int n;
    ll res;
    vector<int> parent;
    vector<int> rank;

    DisjointSet(int n): n(n), res(0), parent(n), rank(n){
        rep(i, 0, n){
            parent[i] = i;
            rank[i] = 1;
        }
    }

    int find(int u){
        if(parent[u] == u) return u;
        return parent[u] = find(parent[u]);
    }

    void merge(int u, int v){
        u = find(u);
        v = find(v);

        if(u == v) return;

        if(rank[u] > rank[v]) swap(u, v);
        parent[u] = v;
        
        if(rank[u] == rank[v]) ++rank[v];
    }
};

vector<Edge> edges;
int n;

int main(void){
    cin >> n;
    DisjointSet ds = DisjointSet(n);

    rep(i, 0, n){
        rep(j, 0, n){
            ll temp;
            cin >> temp;
            edges.push_back({i, j, temp});
        }
    }
            
    sort(edges.begin(), edges.end());

    rep(i, 0, edges.size()){
        int node1 = edges[i].node1;
        int node2 = edges[i].node2;
        ll w = edges[i].w;

        if(ds.find(node1) == ds.find(node2)) continue;

        ds.res += w;
        ds.merge(node1, node2);
    }
    
    cout << ds.res;
}