#include <iostream>
#include <deque>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;

int n, a, b;
bool is_reverse =false;
deque<int> res;

int main(void){
    FAST;
    cin >> n >> a >> b;
    //건물은 최소  a + b - 1 개만큼 필요함.
    if(n < a + b - 1){
        cout << -1;
        return 0;
    }


    if(a > b){
        REP(i, 1, a) res.push_back(i);
        for(int i = b - 1; i > 0; i--) res.push_back(i);

        while(res.size() < n) res.push_front(1);
    }
    else{
        rep(i, 1, a) res.push_back(i);
        for(int i = b; i > 0; i--) res.push_back(i);
        if(res[0] != 1)
            res.insert(res.begin() + 1, n - (a + b - 1), 1);
        else
            while(res.size() < n) res.push_front(1);
    }

    for(auto& e:res) cout << e << " ";
}