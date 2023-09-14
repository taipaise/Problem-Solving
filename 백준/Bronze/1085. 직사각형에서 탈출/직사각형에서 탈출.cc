#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include <set>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;

int x, y, w, h;

int main(void){
    cin >> x >> y >> w >> h;

    int res = min(x, y);
    res = min(res, h - y);
    res = min(res, w - x);
    cout << res;
}