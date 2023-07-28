#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int tc;
int m;
vector<int> arr;
priority_queue<int, vector<int>, greater<int>> minHeap;
priority_queue<int> maxHeap;

void push(int x){
    if(maxHeap.empty()){
        maxHeap.push(x);
        return;
    }

    if(maxHeap.size() <= minHeap.size()) maxHeap.push(x);
    else minHeap.push(x);

    int maxTop = maxHeap.top();
    int minTop = minHeap.top();

    if(maxTop > minTop){
        maxHeap.pop();
        minHeap.pop();

        maxHeap.push(minTop);
        minHeap.push(maxTop);
    }
    // cout << "maxTop " << maxHeap.top() << " ,minTop " << minHeap.top() << "\n";
}

void init(){
    while(!maxHeap.empty()) maxHeap.pop();
    while(!minHeap.empty()) minHeap.pop();
}

int main(void){
    FAST;
   /// freopen("input.txt", "r", stdin);
    cin >> tc;
    REP(i, 1, tc){
        init();
        // cout << "input \n"; 
        cin >> m;
        if(m % 2) cout << (m + 1) / 2 << "\n";
        else cout << m / 2 << "\n";

        int cnt = 0;
        REP(j, 1, m){
            int temp;
            cin >> temp;
            push(temp);
            if(j % 2){
                if(cnt && cnt % 10 == 0) cout << "\n";
                ++cnt;
                cout << maxHeap.top() << " ";
            } 
        }
        cout << "\n";
    }
}