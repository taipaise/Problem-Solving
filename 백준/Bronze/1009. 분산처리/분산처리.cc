#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include <set>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;
int tc;
int a, b;

int main(void){
    cin >> tc;

    rep(t, 0, tc){
        cin >> a >> b;

        int data = a;

        rep(i, 1, b) data = data * a % 10;

        if(data % 10 == 0) cout << 10 << "\n";
        else cout << data % 10 << "\n";
    }
}