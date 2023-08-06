#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;
int n;
unordered_map<string, int> in;
vector<string> out;

int main(void){
    cin >> n;
    string temp;
    
    rep(i, 0, n){
        cin >> temp;
        in[temp] = i;
    }

    rep(i, 0, n){
        cin >> temp;
        out.push_back(temp);
    }

    int res = 0;
    rep(i, 0, n){
        rep(j, i + 1, n){
            if(in[out[i]] > in[out[j]]) {
                ++res;
                break;
            }
        }
    }
    cout << res;
}

