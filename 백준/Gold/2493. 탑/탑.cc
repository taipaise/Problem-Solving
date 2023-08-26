#include <iostream>
#include <algorithm>
#include <vector>
#include <stack>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int n;
vector<int> vec;

int main(void){
    FAST;
    cin >> n;
    vec.resize(n);
    stack<pair<int, int>> stk;

    int height;
    REP(i, 1, n){
        cin >> height;

        while(!stk.empty()){
            if(stk.top().first > height) break;
            stk.pop();
        }

        if(stk.empty()) cout << 0 << " ";
        else cout << stk.top().second << " ";

        stk.push({height, i});
    }
}