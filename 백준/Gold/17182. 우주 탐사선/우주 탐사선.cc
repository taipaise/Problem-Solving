#include <iostream>
#include <algorithm>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i,a,b) for(auto i = a; i <= b; i++)
using namespace std;

int n, pos;
int dist[10][10];
int min_val = 2147483647;
bool visited[10];


void solve(int cnt, int sum, int pre){
    if(cnt == n){
        min_val = min(min_val, sum);
        return;
    }

    rep(i, 0, n){
        if(visited[i]) continue;

        visited[i] = true;
        solve(cnt + 1, sum + dist[pre][i], i);
        visited[i] = false;
    }
}

int main(void){
    FAST;
    cin >> n >> pos;
    rep(i, 0, n){
        rep(j, 0, n)
            cin >> dist[i][j];
    }

    //플로이드 워셜로 거리 갱신
    rep(k, 0, n){
        rep(i, 0, n){
            rep(j, 0, n){
                if(dist[i][k] + dist[k][j] < dist[i][j])
                    dist[i][j] = dist[i][k] + dist[k][j];
            }
        }
    }
    visited[pos] = true;
    solve(1, 0, pos);
    
    cout << min_val;
}