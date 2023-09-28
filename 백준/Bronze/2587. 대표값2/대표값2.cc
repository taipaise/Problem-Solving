#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include <set>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;
vector<int> vec(5);
double sum = 0;

int main(void){
    
    rep(i, 0, 5){
        cin >> vec[i];
        sum += double(vec[i]);
    }

    cout << sum / 5 << "\n";
    sort(vec.begin(), vec.end());
    cout << vec[2];
}