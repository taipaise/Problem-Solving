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

struct Rule{
    int start;
    int end;
    int interval;
};

int n, k, d;
int lo, hi;
vector<Rule> rules;

ll get_count(int interval, int box_cnt){
    return ll((box_cnt / interval) + 1);
}

bool check(int mid){
    ll res = 0;

    rep(i, 0, k){
        int box_cnt;

        if(mid < rules[i].start) continue;

        box_cnt = min(mid, rules[i].end) - rules[i].start;
        res += get_count(rules[i].interval, box_cnt);
    }

    return res >= ll(d);
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif

    cin >> n >> k >> d;

    rep(i, 0, k){
        int start, end, interval;
        cin >> start >> end >> interval;
        rules.pb({start, end, interval});
    }

    lo = 1;
    hi = int(1e6);
    
    int r;
    while(lo <= hi){
        int mid = (lo + hi) >> 1;
        
        if(check(mid)){
            r = mid;
            hi = mid - 1;
        }
        else
            lo = mid + 1;
    }

    cout << r;

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
