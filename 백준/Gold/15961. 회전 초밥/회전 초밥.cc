#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n, d, k, c;
int max_cnt = 0;
int cur_cnt = 1;
int check[3001] = {0, };
vector<int> sushi;


int main(void){
    FAST;
    cin >> n >> d >> k >> c;

    ++check[c];
    sushi.resize(n + 1);
    REP(i, 1, n){
        cin >> sushi[i];
        if(i <= k){
            if(!check[sushi[i]]) ++cur_cnt;
            ++(check[sushi[i]]);
        }
    }
    max_cnt = cur_cnt;

    REP(i, 2, n){
        if(!(--(check[sushi[i - 1]]))) --cur_cnt;
        int index = i + k - 1;
        if(index > n) index %= n;
        if(!check[sushi[index]]) ++cur_cnt;
        ++(check[sushi[index]]);

        max_cnt = max(max_cnt, cur_cnt);
    }
    cout << max_cnt;

}