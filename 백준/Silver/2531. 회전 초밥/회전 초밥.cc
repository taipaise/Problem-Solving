#include <iostream>
#include <vector>
#include <set>
#include <algorithm>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n, d, k, c;
int maximum = 0;
int check[30001];
vector<int> sushi;

void get_cnt(int index){
    memset(check, 0, sizeof(check));
    int duplicate = 0;
    int coupon = 1;
    
    rep(i, 0, k){
        int cur = sushi[(index + i) % n];
        
        if (check[cur]) ++duplicate;
        else check[cur] = 1;
    }
    if(check[c]) coupon = 0;
    
    maximum = max(maximum, k + coupon - duplicate);
}

int main(void){
    FAST;
    cin >> n >> d >> k >> c;
    sushi.resize(n);
    rep(i, 0, n){
        cin >> sushi[i];
    }

    rep(i, 0, n){
        get_cnt(i);
    }
    cout << maximum;
}