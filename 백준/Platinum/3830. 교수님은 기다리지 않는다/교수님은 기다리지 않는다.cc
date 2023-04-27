#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for (auto i = a; i < b; ++i)
#define REP(i, a, b) for (auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end()
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

struct DisjointSet
{
    int n;
    vector<int> parent;
    vector<int> rank;
    vector<ll> dist;

    DisjointSet(int n) : n(n), parent(n + 1), rank(n + 1), dist(n + 1)
    {
        REP(i, 1, n)
        {
            parent[i] = i;
            rank[i] = 1;
            dist[i] = 0;
        }
    }

    int find_parent(int u)
    {
        if (parent[u] == u) return u;
        int root = find_parent(parent[u]);
        dist[u] += dist[parent[u]];
        return parent[u] = root;
    }

    void merge_parent(int u, int v, int weight)
    {
        int root_u, root_v;
        root_u = find_parent(u);
        root_v = find_parent(v);

        if (root_u == root_v) return;

        if (rank[root_u] > rank[root_v])
        {
            dist[root_v] = dist[u] - dist[v] + weight;
            parent[root_v] = root_u;
        }
        else
        {
            dist[root_u] = dist[v] - dist[u] - weight;
            parent[root_u] = root_v;
        }

        if (rank[root_u] == rank[root_v])
            rank[root_v]++;
    }
};

char c;
int n, m, a, b, weight;

int main(void)
{
    FAST;
    //freopen("text.txt", "r", stdin);
    while (1)
    {
        cin >> n >> m;
        if (n == 0 && m == 0)
            break;

        DisjointSet disjointSet = DisjointSet(n);

        rep(i, 0, m)
        {
            cin >> c >> a >> b;
            if (c == '!')
            {
                cin >> weight;
                disjointSet.merge_parent(a, b, weight);
            }
            else
            {
                if (disjointSet.find_parent(a) != disjointSet.find_parent(b))
                    cout << "UNKNOWN\n";
                else
                    cout << disjointSet.dist[b] - disjointSet.dist[a] << "\n";
            }
        }
    }
    return 0;
}