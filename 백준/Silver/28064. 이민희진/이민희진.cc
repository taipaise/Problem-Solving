#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <stack>
#include <set>
#include <cstring>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

int n;
int res = 0;
vector<string> vec;

bool isMatch(string a, string b) {
    int minLen = min(a.length(), b.length());

    REP(i, 1, minLen) {
        string subA = a.substr(a.length() - i);
        string subB = b.substr(0, i);
        
        if(subA == subB) return true;
    }

    REP(i, 1, minLen) {
        string subA = a.substr(0, i);
        string subB = b.substr(b.length() - i);
        
        if(subA == subB) return true;
    }

    return false;
}

void solve() {
    rep(i, 0, n) 
        rep(j, i + 1, n) 
            if(isMatch(vec[i], vec[j])) ++res;
}

int main(void) {
    cin >> n;
    vec.resize(n);
    
    rep(i, 0, n) cin >> vec[i];

    solve();
    cout << res;
}