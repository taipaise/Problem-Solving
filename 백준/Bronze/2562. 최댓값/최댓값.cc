#include <iostream>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;



int main(void){
    vector<pair<int, int>> vec;
	REP(i, 1, 9) {
        int temp;
        cin >> temp;

        vec.push_back({temp, i});
    }
    sort(vec.begin(), vec.end());

    cout << vec[8].first <<"\n";
    cout << vec[8].second <<"\n";
}