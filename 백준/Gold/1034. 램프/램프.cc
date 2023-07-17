#include <iostream>
#include <algorithm>
#include <string>
#include <unordered_map>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int r , c, k;
unordered_map<string, int> even;
unordered_map<string, int> odd;

bool check(string str){
    int cnt = 0;
    rep(i, 0, c)
        if(str[i] == '0') ++cnt;

    return cnt <= k;
}

int solve(){
    int res = 0;
    if(k % 2 == 0)   {
        for(auto e: even){
            if(!check(e.first)) continue;
            res = max(res, e.second);
        }
            
    }
    else{
        for(auto e: odd){
            if(!check(e.first)) continue;
            res = max(res, e.second);
        }
    }

    return res;
}


int main(void){
    cin >> r >> c;
    
    string temp;
    rep(i, 0, r){
        cin >> temp;

        int cnt = 0;
        rep(j, 0, c)
            if(temp[j] == '0') ++cnt;
        
        if(cnt % 2 == 0) ++even[temp];
        else ++odd[temp];
    }

    cin >> k;

    cout << solve();
}