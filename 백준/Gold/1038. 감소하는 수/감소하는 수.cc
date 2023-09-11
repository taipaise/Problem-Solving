#include <iostream>
#include <algorithm>
#include <string>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
typedef long long ll;
int n;
vector<ll> numbers;

void make_number(ll digit, int cnt){
    if(cnt == 1){
        numbers.push_back(digit);
        return;
    }

    int il = digit % 10;

    rep(i, 0, il){
        ll temp = digit * 10;
        temp += i;
        make_number(temp, cnt - 1);
    }
}


int main(void){
    cin >> n;

    numbers.push_back(0);

    REP(cnt, 1, 10){
        REP(digit, 1, 9){
            make_number(digit, cnt);
        }
    }

    sort(numbers.begin(), numbers.end());

    if(n >= numbers.size()) cout << -1;
    else cout << numbers[n];
}