#include <iostream>
#include <vector>
#include <cstring>
#include <cmath>
#include <algorithm>
#include <vector>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;

constexpr int MAX = 17;
int n, m;
//parent[i][j] := i번째 노드의 2^j번째 부모
int parent[100001][MAX];
int depth[100001];
vector<int> adj[100001];

void init_tree(int cur){
    for(int next : adj[cur]){
        if(depth[next] == -1){
            parent[next][0] = cur;
            depth[next] = depth[cur] + 1;
            init_tree(next);
        }
    }
}

void init_case(){
    memset(parent, -1, sizeof(parent));
    memset(depth, -1, sizeof(depth));
}

int main(void){
    FAST;
    init_case();
    int u, v;
    cin >> n;

    //간선 갯수 만큼 입력 받음 (n - 1)개
    rep(i, 0, n - 1) {
        cin >> u >> v;
        adj[u].push_back(v);
        adj[v].push_back(u);
    }

    //루트 노드는 1번 노드이다.
    depth[1] = 0;
    //1번 노드부터 재귀적으로 노드 x의 첫번째 부모 (parent[x][0])와 depth를 채워준다.
    init_tree(1);

    rep(i, 0, MAX - 1){
        REP(j, 2, n) { //1번 노드는 루트 이므로 2번 노드부터 진행
            if (parent[j][i] != -1) {
                parent[j][i + 1] = parent[parent[j][i]][i];
            }
        }
    }

    cin >> m;
    rep(i, 0, m) {
        cin >> u >> v;
        if (depth[u] < depth[v]) swap(u, v);
        
        int diff = depth[u] - depth[v];

        for(int j = 0; diff; ++j){
            if (diff & 1) u = parent[u][j];
            diff >>= 1;
        }

        if (u != v) {
            for (int j = MAX - 1; j >= 0; --j) {
                if (parent[u][j] != -1 && parent[u][j] != parent[v][j]) {
                    u = parent[u][j];
                    v = parent[v][j];
                }
            }
            u = parent[u][0];
        }
        cout << u << endl;
    }

    return 0;
}