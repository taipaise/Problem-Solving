#include <vector>
#include <queue>
#include <iostream>
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
vector<int> graph[32001];
vector<int> in_degree(32001);

void topologySort(){
    queue<int> q;

    REP(i, 1, n){
        if(in_degree[i] == 0) q.push(i);
    }

    REP(i, 1, n){
        if(q.empty()) return; //사이클 발생

        int x = q.front();
        q.pop();
        cout << x << " ";
        rep(i, 0, graph[x].size()){
            int y = graph[x][i];
            if(--in_degree[y] == 0) q.push(y);
        }
    }
}

int main(void){
    cin >> n >> m;

    rep(i ,0, m){
        int a, b;
        cin >> a >> b;
        graph[a].pb(b);
        in_degree[b]++;
    }
    topologySort();
}