#include <iostream>
#include <algorithm>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
int n, m;
vector<int> cards;

bool search(int num){
    int lo = -1;
    int hi = cards.size();
    
    while(lo + 1 < hi){
        int mid = (lo + hi) >> 1;
        if(cards[mid] < num) lo = mid;
        else if(cards[mid] > num) hi  = mid;
        else return true;
    }

    return false;
}

int main(void){
    FAST;
    cin >> n;
    cards.resize(n);
    rep(i, 0, n) cin >> cards[i];
    sort(cards.begin(), cards.end());

    cin >> m;
    rep(i, 0, m){
        int num;
        cin >> num;
        if(search(num)) cout << "1 ";
        else cout << "0 ";
    }
}