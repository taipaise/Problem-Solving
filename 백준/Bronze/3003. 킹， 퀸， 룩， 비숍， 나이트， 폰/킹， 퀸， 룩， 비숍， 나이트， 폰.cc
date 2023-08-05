#include <iostream>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;
int chess[] = {1, 1, 2, 2, 2, 8};
int main(void){
    rep(i, 0, 6){
        int temp;
        cin >> temp;
        cout << chess[i] - temp << " ";
    }
}