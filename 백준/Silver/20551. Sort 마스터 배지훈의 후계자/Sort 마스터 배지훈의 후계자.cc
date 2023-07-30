#include <iostream>
#include <vector>
#include <algorithm>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

vector<int> vec;
int n, m;

bool in_range(int x){
    return (0 <= x && x < n);
}

int main() {
    FAST;
	
    // freopen("input.txt", "r", stdin);
    cin >> n >> m;
    vec.resize(n);

    rep(i, 0, n)
        cin >> vec[i];

    sort(vec.begin(), vec.end());

    int temp, index;
    rep(i, 0, m){
        cin >> temp;
        index = lower_bound(vec.begin(), vec.end(), temp) - vec.begin();

        if(in_range(index) && vec[index] == temp)
            cout << index << "\n";
        else{
            cout << -1 << "\n";
        }
            
    }	
}