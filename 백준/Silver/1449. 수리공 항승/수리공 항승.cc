#include <iostream>
#include <vector>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)

using namespace std;
int n, l;
vector<int> vec;
int curPos = 0;
int res = 1;

bool isAble(int pos){
    return pos < curPos + l;
}

int main() {    
    cin >> n >> l;
    vec.resize(n);
    rep(i, 0, n) cin >> vec[i];

    sort(vec.begin(), vec.end());
    curPos = vec[0];

    rep(i, 0, vec.size()){
        if(isAble(vec[i])) continue;
        
        curPos = vec[i];
        ++res;
    }

    cout << res;
}
