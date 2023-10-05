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
int total;
int sum = 0;
int a, b;

int main(void){
    FAST;
    cin >> total;
    cin >> n;

    rep(i, 0, n){
        cin >> a >> b;
        sum += (a * b);
    }

    if(total == sum) cout << "Yes";
    else cout << "No";
}
