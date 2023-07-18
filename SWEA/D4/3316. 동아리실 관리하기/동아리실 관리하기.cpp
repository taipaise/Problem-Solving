#include <iostream>
#include <algorithm>
#include <string>
#include <cstring>


#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int tc;
int set;
string str;
int cnt[10000][16];

int get_num(char c){
    return c - 'A';
}

int solve(string str){
    memset(cnt, 0, sizeof(cnt));
    int total_day = str.length();
    int admin;
    int res = 0;
    
    admin = get_num(str[0]);
    rep(i, 1, 16)
        if((i & 1) && (i & (1 << admin))) cnt[0][i] = 1;
    
    rep(day, 1, str.length()){
        admin = get_num(str[day]);

        rep(i, 1, 16){
            rep(j, 1, 16){
                if(!cnt[day - 1][j]) continue;
                if(((i & j) && (i & (1 << admin))))
                    cnt[day][i] = (cnt[day][i] + cnt[day - 1][j]) %  1000000007;
            }
        }
    }

    rep(i, 1, 16)
        res = (res + cnt[total_day - 1][i]) % 1000000007;
    
    return res;
}

int main(void){
    cin >> tc;

    REP(t, 1, tc){
        cin >> str;
        cout << "#" << t << " ";
        cout << solve(str) << "\n";
    }
}