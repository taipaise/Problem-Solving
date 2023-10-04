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
queue<int> q;

int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    cin >> n;

    string str;
    int temp;

    rep(i, 0, n){
    cin >> str;
        if(str == "push"){
            cin >> temp;
            q.push(temp);
            continue;
        }
        else if(str == "pop"){
            if(!q.empty()){
                cout << q.front();
                q.pop();
            }
            else cout << -1;
        }
        else if(str == "size"){
            cout << q.size();
        }
        else if(str == "empty"){
            if(q.empty()) cout << 1;
            else cout << 0;
        }
        else if(str == "front"){
            if(!q.empty()) cout << q.front();
            else cout << -1;
        }
        else{
            if(!q.empty()) cout << q.back();
            else cout << -1;
        }
        cout << "\n";
    }
    
}