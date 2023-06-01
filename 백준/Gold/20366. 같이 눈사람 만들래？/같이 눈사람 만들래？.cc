#include <iostream>
#include <vector>
#include <algorithm>
#include <cstdlib>
#include <limits>

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

int n;
int res = INF;
int diff;
vector<int> snow;



void get_body(int lo, int hi){
    while(lo <= hi){
        int mid = (lo + hi) >> 1;
        // cout << "!!: " << snow[mid]<<endl;
        if(diff - snow[mid] < 0)
            res = min(res, (diff - snow[mid]) * -1);
        else
            res = min(res, (diff - snow[mid]));
        // cout <<"res: " <<res << endl;
        if(snow[mid] == diff){
            cout << 0;
            exit(0);
        }
        else if(snow[mid] < diff)
            lo = mid + 1;
        else
            hi = mid -1;
    }
    // cout << endl;
}

//엘사 몸통, 안나 몸통, 엘사 머리통, 안나 머리통
//엘사 몸통, 안나 몸통,  안나 머리통, 엘사 머리통

void solve(){
    //엘사 눈사람의 머리
    rep(i, 0, n - 1){
        //엘사 눈사람의 몸통
        rep(j, i + 1, n){
            //안나 눈사람의 머리
            rep(k, i + 1, j){
                
                if(i == k) continue;

                diff = snow[i] + snow[j] - snow[k];
                
                get_body(k + 1, j - 1);
            }
        }
    }
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif

    cin >> n;
    snow.resize(n);
    rep(i, 0, n){
        cin >> snow[i];
    }

    sort(snow.begin(), snow.end());

    solve();
    cout << res;

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
