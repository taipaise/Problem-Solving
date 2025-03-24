#include <iostream>
#include <vector>
#include <algorithm>
#include <utility>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
using namespace std;

typedef unsigned long long ull;

pair<bool, int> check(
    int candyCount,
    int maxAnger,
    vector<int> required
) {
    
    rep(i, 0, required.size()) {
        if (required[i] <= maxAnger) { break; }
        
        candyCount -= (required[i] - maxAnger);

        if (candyCount < 0) { return {false, 0}; }
    }

    return {true, candyCount};
}

int main() {
    FAST;
    int candyCount, friendCount;
    vector<int> required;

    cin >> candyCount >> friendCount;
    required.resize(friendCount); 

    rep(i, 0, friendCount) cin >> required[i];
    sort(required.begin(), required.end(), greater<int>());

    int lo = -1;
    int hi = *max_element(required.begin(), required.end());
    int leftCandy = 0;

    while (lo + 1 < hi) {
        int mid = (lo + hi) >> 1;
        
        pair<bool, int> result = check(candyCount, mid, required);

        if (result.first) {
            leftCandy = result.second;
            hi = mid;
        } else {
            lo = mid;
        }
    }
    
    ull res = 0;
    rep(i, 0, friendCount) {
        int anger = min(required[i], hi);

        if (leftCandy > 0 && anger > 0) {
            --leftCandy;
            --anger;
        }

        res += (ull)anger * (ull)anger;
    }

    cout << res;
    return 0;
}