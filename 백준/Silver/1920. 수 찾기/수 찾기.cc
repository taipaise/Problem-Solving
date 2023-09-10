#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include <set>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;
int n;
int m;
set<int> s;

int main(void){
    FAST;
    cin >> n;

    int temp;
    rep(i, 0, n){
        cin >> temp;
        s.insert(temp);
    }

    cin >> m;
    rep(i, 0, m){
        cin >> temp;
        auto it = s.find(temp);

        if(it == s.end()) cout << 0 << "\n";
        else cout << 1 << "\n";
    }
}
