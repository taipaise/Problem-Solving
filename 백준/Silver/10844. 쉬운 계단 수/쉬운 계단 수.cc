#include <iostream>
#include <vector>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;

vector<vector<int>> memo;  // memo[i][j] 길이가 i이고, 시작 수가 j인 계단 수 갯수

int main() {
    int n, res;
    int MOD = 1e9;

    cin >> n;
    memo.resize(n + 1, vector<int>(10, 0));

    REP(i, 1, 9) {
        memo[1][i] = 1;
    }

    REP(length, 2, n) {
        REP(start, 0, 9) {
            if (start > 0){
                memo[length][start] += memo[length - 1][start - 1];
                memo[length][start] %= MOD;
            }
            if (start < 9) {
                memo[length][start] += memo[length - 1][start + 1];
                memo[length][start] %= MOD;
            }
        }
    }

    res = 0;
    REP(start, 0, 9) {
        res += memo[n][start];
        res %= MOD;
    }

    cout << res;
}