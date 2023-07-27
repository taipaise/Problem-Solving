#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <string>
#include <unordered_map>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

unordered_map <string, int> map1;
int tc, n, m;

int main(void){
    cin >> tc;
    REP(t, 1, tc){
        cin >> n >> m;
        map1.clear();
        string temp;
        rep(i, 0, n){
            cin >> temp;
            ++map1[temp];
        }
        rep(i, 0, m){
            cin >> temp;
            ++map1[temp];
        }
        int res = 0;
        for(auto &e : map1){
            if(e.second == 2) ++res;
        }

        cout <<"#" << t << " " << res << "\n";
    }
}   