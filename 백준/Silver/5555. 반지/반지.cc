#include <iostream>
#include <cmath>
#include <string>
#include <vector>
#include <algorithm>
#include <limits>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

string str;
int str_len;
int n;

bool is_valid(string s){
     REP(i, 0, s.length() - str_len)
        if(str == s.substr(i, str_len)) return true;
    return false;
}

int main(void){
    cin >> str;
    cin >> n;

    str_len = str.length();
    int res = 0;
    rep(i, 0, n){
        string temp;
        cin >> temp;
        temp += temp;
        if(is_valid(temp)) ++res;
    }
    cout << res;
}