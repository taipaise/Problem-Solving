#include <iostream>
#include <string>
#include <set>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

string str;
set<string> suffix;

int main(void){
    FAST;
    cin >> str;
    rep(i, 0, str.length()){
        suffix.insert(str.substr(i, str.length() - i));
    }

    for(auto& e: suffix){
        cout << e << "\n";
    }
}