#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n;
int res = 0;
priority_queue<int, vector<int>, greater<int>> cards;

int main(void){
    FAST;
    cin >> n;
    rep(i, 0, n){
        int temp;
        cin >> temp;
        cards.push(temp);
    }

    while(!(cards.size() == 1)){
        int first = cards.top();
        cards.pop();
        int second = cards.top();
        cards.pop();
        res += first + second;
        cards.push(first + second);
    }
    cout << res;
}