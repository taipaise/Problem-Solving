#include <iostream>
#include <string>
#include <map>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

string temp;

bool check_n_pair(string str, int interval){
    multimap<char, char> m;

    rep(i, 0, str.size() - (interval + 1)){
        //단어가 없으면
        if(m.find(str[i]) == m.end()) m.insert({str[i], str[i + interval + 1]});
        else{
            for(auto it = m.lower_bound(str[i]); it != m.upper_bound(str[i]); it++){
                if(it -> second == str[i + interval + 1]) return false;
            }
            m.insert({str[i], str[i + interval + 1]});
        }
    }

    return true;
}

bool check(string str){
    bool flag = true;
    rep(i, 0, str.size() - 2){
        if(!check_n_pair(str, i)) flag = false;
    }

    return flag;
}

int main(void){
    FAST;

    while(1){
        cin >> temp;
        if(temp == "*") break;
        if(temp.size() < 2 || check(temp)) cout << temp << " is surprising.\n";
        else cout << temp << " is NOT surprising.\n";
    }
}