#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n;
int curPrice = 2000000000;
int res = 0;
vector<int> city;
vector<int> road;

int main(void){
    cin >> n;
    road.resize(n - 1);
    city.resize(n);
    rep(i, 0, n - 1) cin >> road[i];
    rep(i, 0, n) cin >> city[i];

    rep(i, 0, n - 1){
        curPrice = min(curPrice, city[i]);
        res += curPrice * road[i];
    }

    cout << res;
}