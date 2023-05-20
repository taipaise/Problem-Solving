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

vector<int> g[101];
int visited[101];
int n, n2;
int p1, p2;
int res = 0;

void  dfs(int x, int cnt){
    visited[x] = 1;
    if(x == p2){
        res = cnt;
    }
    rep(i, 0, g[x].size()){
        if(visited[g[x][i]]) continue;
        dfs(g[x][i], cnt + 1);
    }
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n;
    cin >> p1 >> p2;
    cin >> n2;
    rep(i, 0, n2){
        int a, b;
        cin >> a >> b;
        g[a].pb(b);
        g[b].pb(a);
    }

    dfs(p1, 0);
    if(res) cout << res;
    else cout << -1;

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
