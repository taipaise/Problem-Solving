#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n;
vector<int> vec;
int total;

bool check(int mid){
    int res = 0;
    
    rep(i, 0, n){
        if(vec[i] <= mid) res += vec[i];
        else res += mid;
    }
    return res <= total;
}

void p_search(){
    int lo = 1;
    int hi = vec.back();
    int res;

    while(lo <= hi){
        int mid = (lo + hi) >> 1;

        if(check(mid)){
            res = mid;
            lo = mid + 1;
        }
        else hi = mid - 1;
    }
    cout << res;
}

int main(void){
    FAST;
    cin >> n;
    vec.resize(n);
    rep(i, 0, n) cin >> vec[i];
    cin >> total;

    sort(vec.begin(), vec.end());
    p_search();
}