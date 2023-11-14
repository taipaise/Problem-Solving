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
bool number[31];
int main(void) {
    rep(i, 0, 28) {
        int temp;
        cin >> temp;
        number[temp] = true;
    }

    REP(i, 1, 30) {
        if(!number[i]) cout << i << "\n";
    }
}