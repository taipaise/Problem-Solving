#include <iostream>
#include <vector>
#include <algorithm>

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

int n, m;

struct DisjointSet{
    int n;
    vector<int> parent;
    vector<int> rank;

    DisjointSet(int n) : n(n), parent(n + 1), rank(n + 1){
        REP(i, 1, n){
            parent[i] = i;
            rank[i] = i;
        }
    }

    int find_parent(int u){
        if(parent[u] == u)
            return u;
        else{
            parent[u] = find_parent(parent[u]);
            return parent[u];
        }
    }

    void merge_parent(int u, int v){
        u = find_parent(u);
        v = find_parent(v);

        //부모가 같다면, 이미 연결되어 있다는 뜻
        if(u == v) 
            return;
        
        if (rank[u] > rank[v])
            swap(u, v);
        parent[u] = v;
        if (rank[u] == rank[v]) rank[v]++;
    }
};


int main(void){
    FAST;

    cin >> n;
    cin >> m;

    int temp;
    int prev;
    DisjointSet disjointSet = DisjointSet(n);

    REP(i, 1, n){
        REP(j, 1, n){
            cin >> temp;
            if(temp)
                disjointSet.merge_parent(i, j);
        }
    }

    cin >> temp;
    prev = disjointSet.find_parent(temp);
    rep(i, 0, m - 1){
        cin >> temp;
        if(prev != disjointSet.find_parent(temp)){
            cout << "NO";
            return 0;
        }
    }

    cout << "YES";
    return 0;
}