#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
typedef long long ll;
using namespace std;

int main(void){
    int a, b;
    
    cin >> a >> b;
    if(a > b) swap(a, b);
    
    if(a == b) cout << 0;
    else cout << b - a - 1 << "\n";

    rep(i, a + 1, b - 1){
        cout << i << " ";
    }

    if(b - (a + 1) > 0) cout << b - 1;
}