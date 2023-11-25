#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <queue>
#include <cstring>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;
int n;
vector<string> vec;
string vaccine = "";
bool isUsed[10];
int res = 987654321;

bool isOverlap(string a, string b) {
    if(a.length() > b.length()) return false;
    return a == b.substr(0, a.length());
}

int count_overlap(string pre, string next) {
    int length = pre.length();
    if(length == 0) return 0;

    int pos = 0;
    int res = 0;
    
    while(pos < length) {
        if(pre[pos] == next[0]) {
            if(isOverlap(pre.substr(pos), next)) res = max(res, length - pos);
        }
        ++pos;
    }

    if(res == 0) return -1;
    return res;
} 

void solve(int cnt) {
    if(cnt == n) {
        int len = vaccine.length();
        res = min(len, res);
        return;
    }

    rep(i, 0, n) {

        if(isUsed[i]) continue;
        string  vaccine_origin = vaccine;
        int overlapCnt = count_overlap(vaccine, vec[i]);
        if(overlapCnt == -1) continue;

        isUsed[i] = true;
        vaccine += vec[i].substr(overlapCnt);

        solve(cnt + 1);

        isUsed[i] = false;
        vaccine = vaccine_origin;
    }
}

int main(void) {
    cin >> n;
    vec.resize(n);
    rep(i, 0, n) cin >> vec[i];
    solve(0);
    cout << res;
}