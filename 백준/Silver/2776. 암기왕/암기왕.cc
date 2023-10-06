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

int tc;
int n, m;
vector<int> vec;
int num;

int main(void){
    FAST;
    cin >> tc;

    rep(t, 0, tc){
        vec.clear();

        cin >> n;
        vec.resize(n);
        rep(i, 0, n) cin >> vec[i];
        sort(vec.begin(), vec.end());

        cin >> m;
        rep(i, 0, m){
            cin >> num;
            int index = lower_bound(vec.begin(), vec.end(), num) - vec.begin();
            if(index == n || vec[index] != num) cout << 0 << "\n";
			else cout << 1 << "\n";
        }
    }   
}
