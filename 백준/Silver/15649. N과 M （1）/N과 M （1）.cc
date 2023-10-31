#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <queue>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

int n, m;
vector<int> res;
bool isInclude[9];

void printRes(){
    rep(i, 0, m) cout << res[i] << " ";
    cout << "\n";
}

void solve(){
    if(res.size() == m){
        printRes();
        return;
    }

    REP(i, 1, n){
        if(isInclude[i]) continue;
        
        isInclude[i] = true;
        res.push_back(i);
        solve();
        isInclude[i] = false;
        res.pop_back();
    }
}

int main(void){
    cin >> n >> m;
    solve();
}