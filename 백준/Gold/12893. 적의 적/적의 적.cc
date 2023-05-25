#include <iostream>
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

struct DisjointSet{
    int n;
    vector<int> parent;
    vector<int> enemy;
    vector<int> rank;

    DisjointSet(int n): n(n), parent(n + 1), enemy(n + 1), rank(n + 1){
        REP(i, 0, n){
            parent[i] = i;
            rank[i] = 1;
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

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n >> m;
    DisjointSet disjointSet = DisjointSet(n);
    
    rep(i, 0, m){
        
        int a, b;
        cin >> a >> b;

        if(disjointSet.find(a) == disjointSet.find(b)){
            cout << 0;
            return 0;
        }

        if(disjointSet.enemy[a] != 0)
            disjointSet.merge(disjointSet.enemy[a], b);
        else
            disjointSet.enemy[a] = b;

        if(disjointSet.enemy[b] != 0)
            disjointSet.merge(disjointSet.enemy[b], a);
        else
            disjointSet.enemy[b] = a;
    }   
    cout << 1;

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
    return 0; 
}

