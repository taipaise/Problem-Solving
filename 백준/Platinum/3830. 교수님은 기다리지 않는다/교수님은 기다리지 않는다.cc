#include <iostream>
#include <vector>
#include <string>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;

typedef long long ll;

struct DisjointSet {
    vector<int> parents;
    vector<int> ranks;
    vector<ll> diff;

    DisjointSet(int n) {
        parents.resize(n + 1);
        diff.resize(n + 1); // root로부터 무게 차이를 저장하는 벡터
        ranks.resize(n + 1, 1);

        REP(i, 0, n) {
            parents[i] = i;
        }
    }

    void merge(int u, int v, int weight) {
        int root_u = find(u);
        int root_v = find(v);

        if (root_u == root_v) { return; }

        if (ranks[root_u] > ranks[root_v]) {
            swap(root_u, root_v);
            swap(u, v);
            weight *= -1;
        }

        parents[root_u] = root_v;
        diff[root_u] = diff[v] - diff[u] - weight;
        

        if (ranks[root_v] == ranks[root_u]) {
            ++ranks[root_v];
        }
    }

    int find(int u) {
        if (parents[u] == u) {
            return u;
        }

        int root = find(parents[u]);
        diff[u] += diff[parents[u]];

        return parents[u] = root;
    }
};

int n, m;

void solve() {
    DisjointSet disjointSet = DisjointSet(n);

    rep(i, 0, m) {
        char type;
        int a, b;

        cin >> type >> a >> b;

        if (type == '!') {
            int weight;
            cin >> weight;
            disjointSet.merge(a, b, weight);
        } else {
            if (disjointSet.find(a) != disjointSet.find(b))
                cout << "UNKNOWN\n";
            else
                cout << disjointSet.diff[b] - disjointSet.diff[a] << "\n";
        }
    }
}

int main() {
    FAST;

    while (true) {
        cin >> n >> m;

        if (n == 0 && m == 0) break;
        solve();
    }
}