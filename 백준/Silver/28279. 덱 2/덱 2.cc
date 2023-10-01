#include <iostream>
#include <vector>
#include <deque>
#include <cstdlib>
#include <algorithm>
#include <set>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;

int n;
int k;
int num;
deque<int> deq;

int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    cin >> n; 
    rep(i, 0, n){
        cin >> k;
        switch(k){
            case 1:
                cin >> num;
                deq.push_front(num);
                break;
            case 2:
                cin >> num;
                deq.push_back(num);
                break;
            case 3:
                if(deq.empty()) cout << -1 << "\n";
                else{
                    cout << deq.front() << "\n";
                    deq.pop_front();
                }
                break;
            case 4:
                if(deq.empty()) cout << -1 << "\n";
                else{
                    cout << deq.back() << "\n";
                    deq.pop_back();
                }
                break;
            case 5:
                cout << deq.size() << "\n";
                break;
            case 6:
                if(deq.empty()) cout << 1 << "\n";
                else cout << 0 << "\n";
                break;
            case 7:
                if(deq.empty()) cout << -1 << "\n";
                else cout << deq.front() << "\n";
                break;
            case 8:
                if(deq.empty()) cout << -1 << "\n";
                else cout << deq.back() << "\n";
                break;
        }
        
    }

}