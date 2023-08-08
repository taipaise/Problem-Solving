#include <iostream>
#include <vector>
#include <set>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

set<string> s;
string str;

int main(void){
    cin >> str;
    int len = str.length();
    REP(i, 1, len)
        REP(j, 0, len - i)
            s.insert(str.substr(j, i));

    cout << s.size();
}