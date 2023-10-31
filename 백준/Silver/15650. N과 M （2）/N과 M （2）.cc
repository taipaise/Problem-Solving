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

// 1 ~ n의 범위에서 m개를 뽑아야함
// 오름차순 이어야하고
// 중복되는 수는 있으면 안됨

int n, m;
vector<int> res;

void print_res(){//수열을 출력하는 함수
    rep(i, 0, m) cout << res[i] << " ";
    cout << "\n";
}

void solve(){
    if(res.size() == m){
        print_res();
        return;
    }

    for(int i = 1; i <= n; ++i){
        if (!res.empty())
            if (res.back() >= i) continue;
        res.push_back(i);
        solve();
        res.pop_back();
    }
}

int main(void){
    cin >> n >> m;
    solve();
}


