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

int main(void){
    long long a, b;
    cin >> a >> b;
    cout << abs(a - b);
}