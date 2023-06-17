#include <iostream>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n, h, t;
priority_queue<int> giants;
int g;

int main(void){
    cin >> n >> h >> t;
    int t_origin = t;
    int temp;
    rep(i, 0, n){
        cin >> temp;
        if(h <= temp) giants.push(temp);
    }

    while(!giants.empty()){
        g = giants.top();
        if(g == 1){
            break;
        }
        if(t){
            giants.pop();
            g /= 2;
            if(h <= g) giants.push(g);
            --t;
        }
        else{
            break;
        }
    }
    if(!giants.empty()) cout << "NO\n" << giants.top();
    else cout << "YES\n" << t_origin - t;
}