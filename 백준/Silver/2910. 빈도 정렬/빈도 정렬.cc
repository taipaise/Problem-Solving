#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
struct Num{
    int cnt;
    int index;
};

bool cmp(pair<int, Num> a, pair<int, Num> b){
    if(a.second.cnt != b.second.cnt) return a.second.cnt > b.second.cnt;
    return a.second.index < b.second.index;
}
unordered_map<int, Num> m;
int n, c;

int main(void){
    cin >> n >> c;

    rep(i, 0, n){
        int temp;
        cin >> temp;
        
        if(m.find(temp) != m.end()) m[temp].cnt++;
        else m[temp] = {1, i};
    }

    vector<pair<int, Num>> vec(m.begin(), m.end());
    sort(vec.begin(), vec.end(), cmp);

    rep(i, 0, vec.size()){
        rep(j, 0, vec[i].second.cnt) cout << vec[i].first << " ";
    }
}