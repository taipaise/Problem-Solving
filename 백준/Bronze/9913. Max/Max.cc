#include <iostream>
#include <unordered_map>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)

using namespace std;
int n;
unordered_map<int, int> m;
int max_f = 0;

int main() {    
    cin >> n;

    rep(i, 0, n){
        int temp;
        cin >> temp;
        ++m[temp];
    }

    for(auto &e : m){
        max_f = max(max_f, e.second);
    }

    cout << max_f;
    return 0;
}