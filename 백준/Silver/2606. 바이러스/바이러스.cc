#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;
struct Vertex{
    int node;
    vector<int> adjacent;

    void add(int x){
        adjacent.push_back(x);
    }
};

int n, m;
int res = 0;
vector<Vertex> vec;
bool visited[101];

void dfs(int x){
    visited[x] = true;

    rep(i, 0, vec[x].adjacent.size()){
        if(visited[vec[x].adjacent[i]]) continue;
        ++res;
        dfs(vec[x].adjacent[i]);
    }
}

int main(void){
    cin >> n >> m;
    vec.resize(n + 1);
    rep(i, 0, m){
        int a, b;
        cin >> a >> b;
        vec[a].add(b);
        vec[b].add(a);
    }
    dfs(1);
    cout << res;
}