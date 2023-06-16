#include <iostream>
#include <string>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
string buffer = "";
string str;
int main(void){
    cin >> str;

    rep(i, 0, str.length()){
        if(buffer.length() < 10) buffer += str[i];
        else{
            cout << buffer << "\n";
            buffer = "";
            buffer += str[i];
        }
    }

    if(buffer.length()) cout << buffer;
}