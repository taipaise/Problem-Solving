#include <iostream>
#include <vector>
#include <cstring>
#include <algorithm>
#include <cmath>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
typedef long long ll;

struct DisjointSet{
    int n;
    vector<int> parent;
    vector<int> rank;

    DisjointSet(int n): n(n), parent(n), rank(n){
        rep(i, 0, n){
            parent[i] = i;
            rank[i] = 1;
        }
    }

    void merge(int u, int v){
        u = find(u);
        v = find(v);

        if(u == v) return;

        if(rank[u] > rank[v]) swap(u, v);
        parent[u] = v;
        if(rank[u] == rank[v]) ++rank[v];
    }

    int find(int u){
        if(parent[u] == u) return u;
        return parent[u] = find(parent[u]);
    }
};

struct Edge{
    ll srt;
    ll end;
    ll length;

    bool operator<(const Edge& rhs)const{
        return length < rhs.length;
    }
};

vector<Edge> dist;

ll xpos[1000];
ll ypos[1000];
int tc;
int n;
ll a, b;

ll get_dist(ll y1, ll x1, ll y2, ll x2){
    return ((y1 - y2) * (y1 - y2)) + ((x1 - x2) * (x1 - x2));
}

int main(void){
    FAST;
    cin >> tc;

    REP(t, 1, tc)
    { 
        memset(xpos, 0, sizeof(xpos));
        memset(ypos, 0, sizeof(ypos));
        cin >> n;
        DisjointSet disjoint = DisjointSet(n);
        ll res = 0;
        double rate = 0;

        dist.clear();
        dist.resize(n * n);

        rep(i, 0, n) cin >> xpos[i];
        rep(i, 0, n) cin >> ypos[i];

        cin >> rate;

        rep(i, 0, n - 1)
            rep(j, i + 1, n)
                dist.push_back({i, j, get_dist(ypos[i], xpos[i], ypos[j], xpos[j])});

        sort(dist.begin(), dist.end());

        rep(i, 0, dist.size()){
            if(disjoint.find(dist[i].srt) == disjoint.find(dist[i].end)) continue;

            res += dist[i].length;
            disjoint.merge(dist[i].srt, dist[i].end);
        }

        cout << fixed;
        cout.precision(0);
        cout << "#" << t << " ";
        cout << round(double(res * rate)) << "\n";
    }
}
