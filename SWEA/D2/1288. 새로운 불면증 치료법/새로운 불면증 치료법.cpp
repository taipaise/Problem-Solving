#include <iostream>
#include <algorithm>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

unsigned long long set = 0;
unsigned long long full = (1 << 10) - 1;

int test_case;

void record(long long num){
    string n = to_string(num);
    rep(i, 0, n.length()) set |= (1 << (n[i] - '0'));
}

long long solve(long long num){
    int cnt = 0;
    while(set != full) record(num * (++cnt));
    return (num * cnt);
}

int main(void){
    // freopen("input.txt", "r", stdin);
    cin >> test_case;
    
    REP(i, 1, test_case){
        long long num;

        set = 0;
        cin >> num;
        cout << "#" << i << " ";
        cout << solve(num) << "\n";
    }
}