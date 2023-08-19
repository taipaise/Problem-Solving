#include <iostream>
#include <algorithm>
#include <string>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int n;
int res = 0;
vector<int> vec;

double getInclination(int a, int b){
    double dx = double(b - a);
    double dy = double(vec[b] - vec[a]);

    return dy / dx;
}

int getCnt(int index){
    double maxInclination;
    double minInclination;
    
    int l_cnt = 0;
    int r_cnt = 0;

    //기울기가 감소해야함
    for(int i = index - 1; i >= 0; i--){
        if(l_cnt == 0){
            minInclination = getInclination(index, i);
            ++l_cnt;
        }
        else{
            double curInclination = getInclination(index, i);
            if(minInclination > curInclination){
                minInclination = curInclination;
                ++l_cnt;
            }
        }
    }

    //기울기가 증가해야 함
    for(int i = index + 1; i < n; i++){
        if(r_cnt == 0){
            maxInclination = getInclination(index, i);
            ++r_cnt;
        }
        else{
            double curInclination = getInclination(index, i);
            if(maxInclination < curInclination){
                maxInclination = curInclination;
                ++r_cnt;
            }
        }
    }

    return l_cnt + r_cnt;
}

int main(void){
    cin >> n;
    vec.resize(n);

    rep(i, 0, n) cin >> vec[i];

    rep(i, 0, n) res = max(res, getCnt(i));
    cout << res;


}