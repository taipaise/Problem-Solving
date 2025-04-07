#include <iostream>
#include <vector>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
using namespace std;

int main() {
    FAST;

    int n;
    vector<int> arr;
    vector<vector<bool>> dp;
    int count;

    cin >> n;
    arr.resize(n + 1);
    dp.resize(n + 1, vector<bool>(n + 1));

    REP(i, 1, n) {
        cin >> arr[i];
        dp[i][i] = true;
    }

    REP(i, 1, n - 1) {
        if (arr[i] == arr[i + 1]) { dp[i][i + 1] = true; }
    }

    cin >> count;

    REP(length, 3, n) {
        REP(i, 1, n - length + 1) {
            int end = i + length - 1;

            if (end > n) { continue; }
            if (arr[i] != arr[end]) { continue; }

            if (length > 2 && dp[i + 1][end - 1] == true) {
                dp[i][end] = true;
            }
        }
    }

    rep(i, 0, count) {
        int start, end;
        cin >> start >> end;

        if (dp[start][end]) {
            cout << "1\n";
        } else {
            cout << "0\n";
        }
    }
}
