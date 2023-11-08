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
int cnt;
string str;
int main(void){
    FAST;
    cin >> n;

    rep(i, 0, n) {
        cin >> cnt >> str;

        rep(j, 0, str.length()){
            rep(k, 0, cnt) {
                cout << str[j];
            }
        }
        cout << "\n";
    }
}