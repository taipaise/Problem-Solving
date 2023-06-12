#include <iostream>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;


string s;
string t;

int main(void){
    cin >> s;
    cin >> t;

    while(t.length() > s.length()){
        if (t.back() == 'A') 
            t.pop_back();
        else{
            t.pop_back();
            reverse(t.begin(), t.end());
        }
    }

    if(s == t) cout << 1;
    else cout << 0;
}