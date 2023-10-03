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

int n;
priority_queue<int> pq;

int main(void){
    FAST;
    cin >> n;

    int temp;
    rep(i, 0, n){
        rep(j, 0, n){
            cin >> temp;
            temp *= -1;
            pq.push(temp);
            if(pq.size() > n) pq.pop();
        }
    }

    cout << pq.top() * -1;
}