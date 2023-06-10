#include <iostream>
#include <cstdlib>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

struct POS{
    int y;
    int x;
};

struct Home{
    POS pos;
    int dist;

    void update_dist(int y, int x, bool is_force){
        if(is_force)
            dist = abs(pos.y - y) + abs(pos.x - x);
        else
            dist = min(dist, abs(pos.y - y) + abs(pos.x - x));
    }
};

vector<POS> chickens;
vector<POS> remain_chickens;
vector<Home> home;
int city[51][51];
int n, m;
int min_dist = 2147483647;

bool in_range(int y, int x){
    return (0 < y && y <= n) && (0 < x && x <= n);
}

int get_total_dist(){
    int res = 0;
    for(auto &e: home){
        res += e.dist;
    }
    return res;
}

void update_chicken_dist(){
    rep(i, 0, remain_chickens.size()){
        for(auto &h : home){
            if(i == 0)
                h.update_dist(remain_chickens[i].y, remain_chickens[i].x, true);
            else
                h.update_dist(remain_chickens[i].y, remain_chickens[i].x, false);
        }
    }
}

void solve(int index){
    if(remain_chickens.size() == m){
        update_chicken_dist();
        min_dist = min(min_dist, get_total_dist());
        return;
    }

    rep(i, index, chickens.size()){
        remain_chickens.push_back(chickens[i]);
        solve(i + 1);
        remain_chickens.pop_back();
    }
}


int main(void){
    cin >> n >> m;
    REP(i, 1, n){
        REP(j, 1, n){
            cin >> city[i][j];
            if(city[i][j] == 1) home.push_back({{i, j}, 400});
            if(city[i][j] == 2) chickens.push_back({i, j});
        }
    }
    solve(0);
    cout << min_dist;
}