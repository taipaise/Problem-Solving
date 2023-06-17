#include <iostream>
#include <set>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n, m;
int res = 0;
set<string> s;

int main(void){
    cin >> n >> m;

    string temp;
    rep(i, 0, n){
        cin >> temp;
        s.insert(temp);
    }
    rep(i, 0, m){
        cin >> temp;
        if(s.find(temp) != s.end()) ++res;
    }

    cout << res;
}