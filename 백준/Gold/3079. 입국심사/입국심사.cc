#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;
typedef unsigned long long ull;

ull n, m;
vector<ull> vec;

bool check(ull mid){
    ull res = 0; 
    for(auto &time: vec) res += (mid / time);

    return res >= m;
}

ull solve(){
    ull lo = vec.front() - 1;
    ull hi = vec.back() * m + 1;

    while(lo + 1 < hi){
        ull mid = (lo + hi) >> 1;

        if(check(mid)) hi = mid;
        else lo = mid;
    }
    
    return hi;
}

int main(void){
    FAST;
    cin >> n >> m;
    vec.resize(n);
    rep(i, 0, n) cin >> vec[i];
    sort(vec.begin(), vec.end());

    cout << solve();
}