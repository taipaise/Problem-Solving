#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

struct POS{
    int y;
    int x;

    bool operator<(const POS& rhs)const{
        if(y != rhs.y) return y < rhs.y;
        return x < rhs.x; 
    }
};
int n, m, l, k;
vector<POS> stars;
int maximum = 0;

int main(void){
    FAST;
    cin >> n >> m >> l >> k;

    rep(i, 0, k){
        int x,  y;
        cin >> x >> y;
        stars.push_back({y, x});
    }

    for(auto &star_y: stars){
        for(auto &star_x: stars){
            int res = 0;
            int y = star_y.y;
            int x = star_x.x;

            for(auto &star: stars){
                int cur_y = star.y;
                int cur_x = star.x;

                if((y <= cur_y) && (cur_y <= (y + l)) &&((x <= cur_x) && (cur_x <= (x + l))))
                    ++res;
            }
            maximum = max(maximum, res);
        }
    }

    cout << k - maximum;
}