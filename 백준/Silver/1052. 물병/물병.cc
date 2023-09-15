#include <iostream>
#include <vector>
#include <set>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int n, k;
int res = 0;

int getCnt(int x){
    int cnt = 0;

    while(x){
        if(x % 2) ++cnt;
        x /= 2;
    }

    return cnt;
}

int main(void){
    cin >> n >> k;
    while(getCnt(n + res) > k) ++res;

    cout <<  res;
}