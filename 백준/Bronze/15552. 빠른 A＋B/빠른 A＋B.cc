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
int tc;
int a, b;
int main(void){
    FAST;
    cin >> tc;
    rep(i, 0, tc){
        cin >> a >> b;
        cout << a + b << "\n";
    }
}