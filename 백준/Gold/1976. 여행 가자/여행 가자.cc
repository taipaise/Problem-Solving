#include <iostream>
#include <vector>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;

struct DisjointSet {
private: 
    vector<int> parents;
    vector<int> ranks;
public:
    DisjointSet(int n) {
        parents.resize(n + 1);
        REP(i, 0, n) parents[i] = i;
        ranks = vector<int>(n + 1, 1);
    }
    
    void merge(int u, int v) {
        u = find(u);
        v = find(v);
        if (u == v) return;

        if (ranks[u] > ranks[v]) swap(u, v);

        parents[u] = v;

        if (ranks[u] == ranks[v]) ++ranks[v];
    }

    int find(int u) {
        if (parents[u] == u) { return u; }
        return parents[u] = find(parents[u]);
    }

};

int main() {
    FAST;

    int n, targetCount;
    cin >> n >> targetCount;
    vector<vector<int>> boards(n, vector<int>(n));
    vector<int> targets;
    DisjointSet disjointSet(n);


    REP(i, 1, n) {
        REP(j, 1, n) {
            int flag;
            cin >> flag;

            if (flag) disjointSet.merge(i, j);
        }
    }

    targets.resize(targetCount);
    rep(i, 0, targetCount) cin >> targets[i];

    int parent = disjointSet.find(targets[0]);

    rep(i, 1, targets.size()) {
        if (disjointSet.find(targets[i]) != parent) {
            cout << "NO";
            return 0;
        }
    }
    
    cout << "YES";
}