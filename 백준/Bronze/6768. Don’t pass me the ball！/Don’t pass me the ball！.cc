#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
int n; 

int main(void){
    cin >> n;

    if(n < 4) cout << 0;
    else cout << ((n - 1) * (n - 2) * (n - 3)) / (3 * 2 * 1);
}