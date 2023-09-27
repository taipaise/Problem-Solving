#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include <set>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;
int n, k;
vector<int> vec;
int main(void){
    cin >> n >> k;

    vec.resize(n);

    rep(i, 0, n) cin >> vec[i];

    sort(vec.begin(), vec.end(), greater<int>());

    cout << vec[k - 1];
}