#include <iostream>
// #include <stack>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

// stack<char> s;
string s;
// stack<char> store;
string store;
string str;
string bomb;


int main(void){
    FAST;
    cin >> str;
    cin >> bomb;

    rep(i, 0, str.length()){
        s += str[i];

        if(s.length() < bomb.length()) continue;
        if(s.back() != bomb.back()) continue;

        for(auto it = bomb.rbegin(); it != bomb.rend(); it++){
            if(*it == s.back()){
                store = s.back() + store;
                s.pop_back();
            }
        }

        if(store.length() != bomb.length()) s += store;
        while(!store.empty()) store.pop_back();
    }

    if(s.length()) cout << s;
    else cout << "FRULA";
}