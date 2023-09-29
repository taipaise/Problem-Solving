#include <iostream>
#include <vector>
#include <stack>
#include <cstdlib>
#include <algorithm>
#include <set>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;
stack<int> stk;

int n, op, number;

int main(void){
    FAST;
    cin >> n;
    rep(i, 0, n){
        cin >> op;
        switch(op){
            case 1:
                cin >> number;
                stk.push(number);
                break;
            case 2:
                if(stk.empty()) cout << -1 << "\n";
                else{
                    cout << stk.top() << "\n";
                    stk.pop();
                }
                break;
            case 3:
                cout << stk.size() << "\n";
                break;
            case 4:
                if(stk.empty()) cout << 1 << "\n";
                else cout << 0 << "\n";
                break;
            case 5:
                if(stk.empty()) cout << -1 << "\n";
                else cout << stk.top() << "\n";
                break;
        }
    }
}