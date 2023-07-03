#include <iostream>
#include <queue>
#include <vector>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
struct POS{
    int x;
    int time;
};

int dx[2] = {-1, 1};
int n, k;
int visited[100001];
vector<int> vec;

bool in_range(int x){
    return (0 <= x) && (x <= 100000);
}

void bfs(){
    queue<POS> q;
    q.push({n, 0});
    visited[n] = n;
    
    while(!q.empty()){
    
        int x = q.front().x;
        int time = q.front().time;
        q.pop();

        if(x == k){
            cout << time << "\n";
            return;
        }

        rep(dir, 0, 3){
            int nx;

            if(dir == 2)
                nx = (x << 1);
            else
                nx = x + dx[dir];

            if(!in_range(nx)) continue;
            if(visited[nx] != -1) continue;

            visited[nx] = x;
            q.push({nx, time + 1});
        }
    }
}

int main(void){
    cin >> n >> k;
    memset(visited, -1, sizeof(visited));
    bfs();

    int temp = k;
    vec.push_back(temp);

    while(1){
        if(temp == n) break;
        temp = visited[temp];
        vec.push_back(temp);
        
    }

    for(auto i = vec.rbegin(); i != vec.rend(); i++) cout << *i << " ";
}