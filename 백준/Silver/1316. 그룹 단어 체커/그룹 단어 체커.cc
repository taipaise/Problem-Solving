#include <iostream>
#include <vector>
#include <deque>
#include <cstdlib>
#include <algorithm>
#include <set>
#include <unordered_map>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;

int n;
int res = 0;
unordered_map<char, int> m;

int main(void){
    FAST;
    cin >> n;
    string temp;

    rep(i, 0, n){
        bool flag = true;
        m.clear();
        cin >> temp;

        char pre = temp[0];
        ++m[pre];
        rep(j, 1, temp.length()){
            if(pre == temp[j]) continue;
            if(m[temp[j]]){
                flag = false;
                break;
            }
            ++m[pre];
            pre = temp[j];
        }
        if(flag) ++res;
    }

    cout << res;
}