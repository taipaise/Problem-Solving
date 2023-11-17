#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <deque>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;
deque<int> deq;
int n;
int main(void) {
    cin >> n;
    
    REP(i, 1, n) deq.push_back(i);

    while(deq.size() > 1) {
        deq.pop_front();
        int card = deq.front();
        deq.pop_front();
        deq.push_back(card);
    }

    cout << deq.front();
}