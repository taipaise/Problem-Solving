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
int n;
int fib(int x) {
    if (x == 0) return 0;
    if (x == 1) return 1;
    if (x == 2) return 1;

    return fib(x - 1) + fib(x - 2);
}

int main(void) {
    cin >> n;
    cout << fib(n);
}