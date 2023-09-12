#include <iostream>
#include <vector>
#include <set>
#include <algorithm>
#include <cmath>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
typedef long long ll;

int n;
int total_cnt = 1;
double res = 0;
vector<string> vec;
vector<int> possible[9];

string number[5] = {
    "###...#.###.###.#.#.###.###.###.###.###",
    "#.#...#...#...#.#.#.#...#.....#.#.#.#.#",
    "#.#...#.###.###.###.###.###...#.###.###",
    "#.#...#.#.....#...#...#.#.#...#.#.#...#",
    "###...#.###.###...#.###.###...#.###.###"
};

bool is_possible(int num, int index){
    int num_pos = num * 4;
    int pos = index * 4;

    rep(i, 0, 5){
        rep(j, 0, 3){
            if(vec[i][pos + j] == '.') continue;
            if(number[i][num_pos + j] == '#') continue;
            return false;
        }
    }
    return true;
}

bool fill_possible(int index){
    rep(i, 0, 10)
        if(is_possible(i, index))
            possible[index].push_back(i);

    total_cnt *= possible[index].size();
    return possible[index].size();
}

int main(void){
    FAST;
    cin >> n;
    vec.resize(5);
    rep(i, 0, 5) cin >> vec[i];

    rep(i, 0, n) {
        if(!fill_possible(i)){
            cout << -1;
            return 0;
        }
    }
    
    rep(i, 0, n){
        int tenSq = pow(10, n - (i + 1));

        int temp = 0;
        rep(j, 0, possible[i].size()) temp += possible[i][j];
        res += ((double)temp / possible[i].size()) * tenSq;        
    }

    cout << res;
}