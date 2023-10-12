#include <iostream>
#include <algorithm>
#include <vector>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
typedef long long ll;

priority_queue<int> pq;
priority_queue<int> pq2;
int n;
ll sum = 0;

int main(void){
    FAST;
    cin >> n;
    int temp;
    rep(i, 0, n) {
        cin >> temp;
        pq.push(temp);
    }
    
    int pre = pq.top();
    pq.pop();
    while(!pq.empty()){
        int next = pq.top();

        if(pre == next){
            pq2.push(pre);
            pq.pop();
        }
        else if(pre - 1 == next){
            pq2.push(pre - 1);
            pq.pop();
        }

        if(!pq.empty()){
            pre = pq.top();
            pq.pop();
        }
        else break;
    }

    while(pq2.size() >= 2){
        ll a = ll(pq2.top());
        pq2.pop();
        ll b = ll(pq2.top());
        pq2.pop();
        sum += (a * b);
    }

    cout << sum;
}  