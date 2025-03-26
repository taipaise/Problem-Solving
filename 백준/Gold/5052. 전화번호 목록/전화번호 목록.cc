#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;

bool solution() {
    int n;
    vector<string> phoneNumbers;
    
    // 입력
    cin >> n;    
    phoneNumbers.resize(n);
    rep(i, 0, n) cin >> phoneNumbers[i];

    sort(phoneNumbers.begin(), phoneNumbers.end());

    rep(i, 0, n - 1) {
        if (phoneNumbers[i + 1].substr(0, phoneNumbers[i].size()) == phoneNumbers[i]) {
            return false;
        }
    }
    
    return true;
}

int main() {
    FAST;

    int tc;
    cin >> tc;
    rep(i, 0, tc) {
        if (solution()) {
            cout << "YES\n";
        } else {
            cout << "NO\n";
        }
    }
}