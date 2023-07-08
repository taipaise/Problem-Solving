#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;
typedef long long ll;

int n, m;
vector<ll> vec;

bool check(ll mid){
    ll cnt = 0;

    rep(i, 0, n) cnt += (vec[i] / mid);

    return cnt >= m;
}

void b_search(){
    ll lo = 1;
    ll hi = vec.back();
	bool flag = false; 

    while(lo <= hi){
        ll mid = (lo + hi) >> 1;
        // cout << lo << " " << mid << " " << hi << endl;

        if(check(mid)){
			lo = mid + 1;
			flag = true;
		} 
        else hi = mid - 1;
    }

	if(flag) cout << hi;
	else cout << 0;
    
}

int main(void){
    FAST;
    cin >> m >> n;

    rep(i, 0, n){
        ll c;
        cin >> c;
        vec.push_back(c);
    }
	sort(vec.begin(), vec.end());
    b_search();
    return 0;
}