#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;
struct Range{
    int s;
    int e;

    bool operator<(const Range& rhs)const{
        if(s != rhs.s) return s < rhs.s;
        return e < rhs.e;
    }
};

int n, m, a, b;
int dp[100001];
vector<Range> vec;

bool is_valid(int cnt){
    rep(i, 0, vec.size()){
        int s = vec[i].s;
        int e = vec[i].e;

        if(s <= cnt && cnt <= e) return false;
    }
    return true;
}

int main(void){
    cin >> n >> m >> a >> b;
    rep(i, 0, m){
        int s, e;
        cin >> s >> e;
        vec.push_back({s, e});
    }
    sort(vec.begin(), vec.end());
    if(a > b) swap(a, b);
    if(is_valid(a)) dp[a] = 1;
    if(is_valid(b)) dp[b] = 1;
    
    if(dp[a] == 0 && dp[b] == 0){
        cout << -1;
        return 0;
    }

    rep(i, a + 1, b){
        if(!is_valid(i)) continue;
        if(dp[i - a]) dp[i] = dp[i - a] + 1;
    }


    REP(i, b + 1, n){
        if(!is_valid(i)) continue;
    
        int temp = 0;
        if(dp[i - a] && dp[i - b])
            temp = min(dp[i - a], dp[i - b]);
        else
            temp = max(dp[i - a], dp[i - b]);
        
        if(temp != 0) ++temp;
        dp[i] = temp;
    }

    // REP(i, 0, n){
    //     cout << "i: " << i <<" , " << dp[i] <<"\n";
    // }

    if(dp[n]) cout << dp[n];
    else cout << -1;
}