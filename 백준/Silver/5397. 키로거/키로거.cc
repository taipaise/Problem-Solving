#include <iostream>
#include <string>
#include <list>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;


list<char> pw;
int tc;

int main(void){
    // freopen("input.txt", "r", stdin);
    cin >> tc;

    string temp;
    rep(t, 0, tc){
        pw.clear();
        cin >> temp;

        auto it = pw.begin();
        rep(i, 0, temp.length()){
            if(temp[i] == '<'){
                if(it == pw.begin()) continue;
                --it;
            }
            else if(temp[i] == '>'){
                if(it == pw.end()) continue;
                ++it;
            }
            else if(temp[i] == '-'){
                if(it == pw.begin()) continue;
                it = pw.erase(--it);
            }
            else{
                it = pw.insert(it, temp[i]);
                ++it;
            }
        }

        for(auto &e: pw) cout << e;
        cout << "\n";
    }
}