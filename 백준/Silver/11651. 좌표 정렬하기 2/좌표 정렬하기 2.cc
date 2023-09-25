#include <iostream>
#include <vector>
#include <algorithm>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;
int n;
vector<pair<int, int>> vec;
bool compare(pair<int, int> a, pair<int, int> b){
    if(a.second != b.second) return a.second < b.second;
    return a.first < b.first;
}

int main(void){
    FAST;
    cin >> n;

    int x, y;
    rep(i, 0, n){
        cin >> x >> y;
        vec.push_back({x, y});
    }

    sort(vec.begin(), vec.end(), compare);

    for(auto &e: vec){ cout << e.first << " " << e.second << "\n"; }
}