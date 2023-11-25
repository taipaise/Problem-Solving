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

int count_overlap(string pre, string next) {
    if(pre.length() == 0) return 0;

    int pre_pos = 0;
    int next_pos = 0;

    while(pre_pos < pre.length()) {
        if (pre[pre_pos] == next[next_pos]) ++next_pos;
        else next_pos = 0;
        ++pre_pos;
    }

    if(next_pos == 0) {
        if(pre.back() != next.front()) return -1;
    }

    return next_pos;
} 

void solve(int cnt) {
    if(cnt == n) {
        int len = vaccine.length();
        res = min(len, res);
        return;
    }

    rep(i, 0, n) {

        if(isUsed[i]) continue;
        int vaccine_length = vaccine.length();
        int overlapCnt = count_overlap(vaccine, vec[i]);
        if(overlapCnt == -1) continue;

        isUsed[i] = true;
        vaccine += vec[i].substr(overlapCnt);

        solve(cnt + 1);

        isUsed[i] = false;
        vaccine = vaccine.substr(0, vaccine_length);
    }
}

int main(void) {
    cin >> n;
    vec.resize(n);
    rep(i, 0, n) cin >> vec[i];
    solve(0);
    cout << res;
}