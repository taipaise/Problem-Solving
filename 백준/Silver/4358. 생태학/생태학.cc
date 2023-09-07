#include <iostream>
#include <string>
#include <map>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

map<string, double> tree;


int main(void){
    FAST;
    string tree_name;
    int cnt = 0;
    while(getline(cin, tree_name)){
        ++tree[tree_name];
        ++cnt;
    }

    cout.precision(4);
    for(auto &e: tree){
        cout << fixed;
        cout << e.first << " ";
        cout << (e.second / cnt) * 100 << "\n";
    }
}