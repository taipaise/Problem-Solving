#include <iostream>
#include <vector>
#include <algorithm>

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


ll n , m;
ll lo = 0;
ll hi = 0;
vector<ll> tree;

ll cut_tree(ll mid){
    ll cnt = 0;

    rep(i, 0, n){
        if(tree[i] > mid) cnt += (tree[i] - mid);
    }
    return cnt;
}


ll solve(){
    ll res;

    while(lo <= hi){
        // cout << lo << " " << hi<<endl;
        ll mid = (lo + hi) >> 1;
        // cout << cut_tree(mid) << endl;
        if(cut_tree(mid) >= m) {
            res = mid;
            lo = mid + 1;
        }
        else hi = mid - 1;
    }
    return res;
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n >> m;
    rep(i, 0, n){
        int temp;
        cin >> temp;
        tree.pb(temp);
    }
    sort(all(tree));
    hi = tree[n - 1];

    cout << solve();

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
