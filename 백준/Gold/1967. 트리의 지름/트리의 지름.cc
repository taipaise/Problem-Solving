#include <iostream>
#include <algorithm>
#include <vector>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
struct Edge{
    int to;
    int w;
};

int endPoint;
int res;
vector<Edge>graph[10001];
bool visited[10001];
int n;
int a, b, w;

void dfs(int x, int w){
    if(visited[x]) return;
    visited[x] = true;

    if(res < w){
        endPoint = x;
        res = w;
    }
    rep(i, 0, graph[x].size())
        dfs(graph[x][i].to, w + graph[x][i].w);

}

int main(void){
    cin >> n;
    rep(i, 0, n - 1){
        cin >> a >> b >> w;
        graph[a].push_back({b, w});
        graph[b].push_back({a, w});
    }

    dfs(1, 0);
    memset(visited, 0, sizeof(visited));
    res = 0;
    dfs(endPoint, 0);
    
    cout << res;
}