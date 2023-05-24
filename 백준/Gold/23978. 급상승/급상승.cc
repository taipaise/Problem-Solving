#include <iostream>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end() 
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

ll lo, hi;
ll n, k;
ll res;
vector<ll> day;

ll get_Price(ll mid, ll continuous){
    if(mid > continuous)
        return (mid * (mid + 1) / 2) - ((mid - continuous) * (mid - continuous + 1) / 2);
    else{
        return (mid * (mid + 1) / 2);
    }
}

bool check(ll mid){
    ll total_price = 0;

    rep(i, 0, day.size() - 1){
        ll continuous = day[i + 1] - day[i];
        total_price += get_Price(mid, continuous);
        if(total_price >= k) break;
    }

    if(total_price < k) total_price += get_Price(mid, mid);

    if(total_price >= k)
        return true;
    else 
        return false;
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    
    cin >> n >> k;
    day.resize(n);
    rep(i, 0, n){
        cin >> day[i];
    }

    lo = 0;
    hi = ll(1e16);
    
    while(lo + 1 < hi){
        int mid = (lo + hi) >> 1;

        if(check(mid)){
            res = mid;
            hi = mid;
        }
        else{
            lo = mid;
        }
    }
    cout << res;

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
