#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <stack>
#include <cstring>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

void print_star(int x){
    rep(i, 0, 2 * x - 1) cout << "*";
}

int main(void){
    int n;
    cin >> n;

    REP(i, 1, n) {
        rep(j, 0, n - i) cout << " ";
        print_star(i);
        cout << "\n";
    }

    for(int i = n - 1; i >= 1; --i) {
        rep(j, 0, n - i) cout << " ";
        print_star(i);
        cout << "\n";
    }
}