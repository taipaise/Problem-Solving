#include <iostream>
#include <algorithm>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int tc;
int on = 0;

int main(void){
//    freopen("input.txt", "r", stdin);
    cin >> tc;

    REP(i, 1, tc){
        int n, m;
        cin >> n >> m;
        on = (1 << n) - 1;

        m &= on;
        cout << "#" << i << " ";
        if(m == on) cout << "ON\n";
        else cout << "OFF\n";
    }
}