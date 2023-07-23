#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#include <queue>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
typedef long long ll;
using namespace std;

int main(void){
    vector<int> vec(3);

    rep(i, 0, 3) cin >> vec[i];
    sort(vec.begin(), vec.end());
    rep(i, 0, 3) cout << vec[i] << " ";
}