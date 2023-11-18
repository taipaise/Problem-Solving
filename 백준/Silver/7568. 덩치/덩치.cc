#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <deque>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

struct Person {
    int w;
    int h;
    int rank;
};

vector<Person> vec;
int n;

int main(void) {
    cin >> n;
    vec.resize(n);

    rep(i, 0, n) {
        int w, h;
        cin >> w >> h;
        vec[i] = {w, h, 1};
    }

    rep(i, 0, n) {
        rep(j, 0, n) {
            if(i == j) continue;
            if (vec[i].w < vec[j].w && (vec[i].h < vec[j].h)) ++vec[i].rank;
        }
    }

    rep(i, 0, n) cout << vec[i].rank << " ";
    
}