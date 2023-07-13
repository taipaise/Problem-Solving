#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int n, m;
vector<unsigned long long> vec;
unsigned long long alpha = (1 << 26) -1;

int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    cin >> n >> m;
    vec.resize(n);

    rep(i, 0, n){
        string temp;
        cin >> temp;
        
        rep(j, 0, temp.length()){
            vec[i] |= (1 << (temp[j] - 'a'));
        }
    }

    rep(i, 0, m){
        int query;
        char c;
        int res = 0;
        cin >> query >> c;
        
        //읽을 수 있는 단어 토글
        alpha ^= (1 << (c - 'a'));

        //읽을 수 있는 단어 수 세기
        rep(j, 0, n) if((vec[j] & alpha) == vec[j]) ++res;

        cout << res<<"\n";
    }
} 