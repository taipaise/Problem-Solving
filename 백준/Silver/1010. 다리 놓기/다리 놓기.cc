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
int tc;
long long n, m;

long long factorial(long long a) {
    if(a == 0 || a == 1) return 1;

    return  a * factorial(a - 1);
}

long long solve(long long a, long long cnt){
    long long res = 1;
    
    rep(i, 0, cnt) res *= (a - i);
    return res / factorial(cnt);
}

int main(void){
    cin >> tc;
    rep(t, 0, tc) {
        cin >> n >> m;
        long long temp = min(n, m - n);
        cout << solve(m, temp) << "\n";
    }
}