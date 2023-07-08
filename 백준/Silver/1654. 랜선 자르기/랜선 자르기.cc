#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

int n, k;
vector<long long> vec;

bool check(long long mid){
    long long cnt = 0;
    rep(i, 0, k) cnt += vec[i] / mid;
    return cnt >= n;
}

void parametric(){
    long long lo = 1;
    long long hi = vec.back();
    long long res;

    while(lo <= hi){
        
        long long mid = (lo + hi) >> 1;
        // cout << lo << " " << hi<<" " << mid<<"\n";
        if(check(mid)){
            lo = mid + 1;
            res = mid;
        } 
        else hi = mid - 1;
    }
    cout << res;
}


int main(void){
    cin >> k >> n;

    vec.resize(k);
    rep(i, 0, k) cin >> vec[i];
    sort(vec.begin(), vec.end());

    parametric();
}