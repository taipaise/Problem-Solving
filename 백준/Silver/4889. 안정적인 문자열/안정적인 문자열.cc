#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <stack>
#include <cstring>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;
int tc;
string str;
stack<char> stk;

void clear_stack() {
    while(!stk.empty()) stk.pop();
}

int solve() {
    int cnt = 0;
    rep(i, 0, str.length()) {
        if(str[i] == '}') {
            if(stk.empty()) ++cnt;
            else {
                stk.pop(); //stack의 top에는 항상 { 가 있음
                continue; //짝이 맞으므로 pop하고 건너뜀
            }
        }
        stk.push('{');
    }
    cnt += (stk.size() / 2); // 스택에는 0 또는 짝수 개의 '{' 만 있음
    return cnt;
}

int main(void) {
    // freopen("input.txt", "r", stdin);
    FAST;
    while(++tc) {
        cin >> str;
        if(str[0] == '-') break;
        clear_stack();
        cout << tc << ". "<< solve() << "\n";
    }
}