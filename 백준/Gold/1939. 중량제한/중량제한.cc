#include <iostream>
#include <vector>
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
    int src;
    int dest;
    int weight;

    bool operator<(const Edge& rhs)const{
        return weight > rhs.weight;
    }
};

struct DisjointSet{
    int n;
    vector<int> parent;
    vector<int> rank;
    // vector<int> min_w;

    DisjointSet(int n): n(n), parent(n + 1), rank(n + 1){
        REP(i, 0, n){
            parent[i] = i;
            rank[i] = 1;
            // min_w[i] = INF;
        }
    }
        int find(int u){
            if(u == parent[u]) 
                return u;
            else 
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

int n, m;
int island1, island2;
int res = INF;
vector<Edge> edges;

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n >> m;
    DisjointSet disjointSet = DisjointSet(n);
    rep(i, 0, m){
        int a, b, c;
        cin >> a >> b >> c;
        edges.pb({a, b, c});
    }
    cin >> island1 >> island2;

    sort(all(edges));

    rep(i, 0, edges.size()){
        if(disjointSet.find(island1) == disjointSet.find(island2)) break;
        int temp_src = edges[i].src;
        int temp_dest = edges[i].dest;
        
        res = min(res, edges[i].weight);
        disjointSet.merge(temp_src, temp_dest);
    }

    cout << res;
    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
