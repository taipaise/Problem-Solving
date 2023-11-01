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

int solve(int a){
    if(a == 1 || a == 0) return 1;

    return solve(a - 1) * a;
}

int main(void){
    cin >> n;
    cout << solve(n);
}