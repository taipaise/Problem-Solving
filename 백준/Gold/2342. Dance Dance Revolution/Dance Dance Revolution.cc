#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <climits>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std; 

vector<vector<int>> power = {
    {0, 2, 2, 2, 2},
    {0, 1, 3, 4, 3},
    {0, 3, 1, 3, 4},
    {0, 4, 3, 1, 3},
    {0, 3, 4, 3, 1}};

int main() {
    FAST;
    vector<int> commands;
    vector<vector<vector<int>>> memo;

    int input;
    while (cin >> input && input > 0) commands.push_back(input);

    memo.resize(
        commands.size() + 1,
        vector<vector<int>>(
            5, vector<int>(5, INT_MAX))
        );
    
    memo[0][0][0] = 0;

    REP(i, 1, commands.size()) {
        rep(leftDir, 0, 5) {
            rep(rightDir, 0, 5) {
                int command = commands[i - 1];
                // 왼발로 밟은 경우
                if (memo[i - 1][leftDir][rightDir] == INT_MAX) { continue; }
                memo[i][command][rightDir] = min(
                    memo[i][command][rightDir],
                    memo[i - 1][leftDir][rightDir] + power[leftDir][command]);
                // 오른발로 밟는 경우
                memo[i][leftDir][command] = min(
                    memo[i][leftDir][command],
                    memo[i - 1][leftDir][rightDir] + power[rightDir][command]);
            }
        }
    }

    int res = INT_MAX;
    rep(i, 0, 5) {
        rep(j, 0, 5) {
            res = min(res, memo[commands.size()][i][j]);
        }
    }

    cout << res;
    
}