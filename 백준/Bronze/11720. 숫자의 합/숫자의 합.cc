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
int n;
string str;
int main(void){
    FAST;
    cin >> n >> str;
    int res = 0;
    rep(i, 0, n){
        res += (str[i] - '0');
    }
    cout << res;
}