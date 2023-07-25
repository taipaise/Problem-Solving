
#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

priority_queue<int, vector<int>, greater<int>> minHeap;
priority_queue<int> maxHeap;
int tc, n;
int a, b;
int res;

void init(){
    while(!minHeap.empty()) minHeap.pop();
    while(!maxHeap.empty()) maxHeap.pop();
    res = 0;
}

void pushHeap(int x, bool flag){
    if(flag) maxHeap.push(x);
    else minHeap.push(x);

    if(minHeap.empty()) return;

    int max_top = maxHeap.top();
    int min_top = minHeap.top();

    if(min_top < max_top){
        maxHeap.pop();
        minHeap.pop();

        maxHeap.push(min_top);
        minHeap.push(max_top);
    }
    
    if(flag) {
        res += maxHeap.top();
        res %= 20171109;
    }
}

int main(void){
    FAST;
    cin >> tc;

    REP(t, 1, tc){
        init();
        cin >> n >> a;
        pushHeap(a, true);

        rep(i, 0, n){
            cin >> a >> b;
            pushHeap(a, false);
            pushHeap(b, true);
        }
        cout << "#" << t << " ";
        cout << res % 20171109 << "\n";
    }
}
