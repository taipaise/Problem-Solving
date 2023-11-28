#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <stack>
#include <cstring>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

int num = 1;
int temp;
int arr[10];

int main(void){
    rep(i, 0, 3) {
        cin >> temp;
        num *= temp;
    }

    while(num / 10) {
        int digit = num % 10;
        ++arr[digit];
        num /= 10;
    }
    ++arr[num];
    rep(i, 0, 10) {
        cout << arr[i] << "\n";
    }
}