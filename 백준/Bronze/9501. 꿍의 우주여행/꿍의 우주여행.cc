#include <iostream>
#include <vector>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;

struct Ship{
    int v;
    int f;
    int r;
};


int tc;
int n, dist;
vector<Ship> ship;

int solve(){
    int res = 0;
    rep(i, 0, n)
        if((ship[i].v * ship[i].f) / ship[i].r >= dist) ++res;

    return res;
}

int main() {  
    // freopen("input.txt", "r", stdin);
    cin >> tc;
    rep(t, 0, tc){
        cin >> n >> dist;
        ship.clear();
        ship.resize(n);
        rep(i, 0, n){
            int v, f, r;
            cin >> v >> f >> r;
            ship[i] = {v, f, r};
        }
        cout << solve() << "\n";
    }
}
