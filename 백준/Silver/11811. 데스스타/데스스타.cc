#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;

int main(void){
    int n; cin >> n;
    
    rep(i, 0, n){
        int a = 0; 
        rep(j, 0, n){
            int temp; 
            cin >> temp;
            a = (a | temp);
        }
        cout << a << " ";
    }
    return 0;
}
