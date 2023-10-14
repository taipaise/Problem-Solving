#include <iostream>
#include <vector>
#include <queue>
#include <cstdlib>
#include <algorithm>
#include <set>
#include <unordered_map>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;

priority_queue<int> pq;
int n;

int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    cin >> n;
    int temp;
    rep(i, 0, n){
        cin >> temp;
        if(temp){
            pq.push(temp * -1);
        }
        else{
            if(pq.empty()) cout << 0 << "\n";
            else{
                cout << pq.top() * -1 << "\n";
                pq.pop();
            }
        }
    }
}