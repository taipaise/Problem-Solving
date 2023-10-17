#include <iostream>
#include <vector>
#include <queue>
#include <stack>
#include <cstdlib>
#include <algorithm>
#include <set>
#include <unordered_map>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;
int n;
int res = 0;
stack<char> stk;

void init(){
    while(!stk.empty()) stk.pop();
}

int main(void) {
    FAST;
    cin >> n;
    string temp;

    rep(i, 0, n){
        init();
        cin >> temp;

        rep(j, 0, temp.length()){
            if(!stk.empty() && stk.top() == temp[j])
                stk.pop();
            else
                stk.push(temp[j]);
        }

        if(stk.empty()) ++res;
    }

    cout << res;
}