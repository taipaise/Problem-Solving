#include <iostream>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;


int n, k;
deque<int> q;

int main(void){
    cin >> n >> k;
    REP(i, 1, n) q.push_back(i);

    while(q.size() > 1 && q.size() > k){
        rep(i, 0, k - 1) q.erase(q.begin() + 1);
        
        int temp = q.front();
        q.pop_front();
        q.push_back(temp);
    }
    
    cout << q.front();
}
