#include <iostream>
#include <set>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int lenA, lenB;
set<int> a;
set<int> b;

set<int> amb;
set<int> bma;

set<int> aub;

int main(void){
    FAST;
    cin >> lenA >> lenB;

    int temp;
    rep(i, 0, lenA){
        cin >> temp;
        a.insert(temp);
    }
    rep(i, 0, lenB){
        cin >> temp;
        b.insert(temp);
    }

    set_difference(a.begin(), a.end(), b.begin(), b.end(), inserter(amb, amb.begin()));
    set_difference(b.begin(), b.end(), a.begin(), a.end(), inserter(bma, bma.begin()));

    set_union(amb.begin(), amb.end(), bma.begin(), bma.end(), inserter(aub, aub.begin()));

    cout << aub.size();
}