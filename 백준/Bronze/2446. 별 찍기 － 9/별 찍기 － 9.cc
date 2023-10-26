#include <iostream>
#include <vector>
#include <queue>
#include <stack>
#include <cstdlib>
#include <algorithm>
#include <set>
#include <unordered_map>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;
int n;

void printBlank(int cnt){
    rep(i, 0, n - cnt) cout << " ";
}

void printStar(int cnt){
    int star = 2 * cnt - 1;
    rep(i, 0, star) cout << "*";
    cout << "\n";
}

void print(int cnt){
    printBlank(cnt);
    printStar(cnt);
}

int main(void) {
    cin >> n;

    for(int i = n; i > 1; --i) print(i);
    print(1);
    for(int i = 2; i <= n; ++i) print(i);
}
