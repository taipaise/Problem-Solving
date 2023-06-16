#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

struct Title{
    string name;
    int power;

    bool operator<(const Title& rhs)const{
        return power < rhs.power;
    }
};

int n, m;
vector<Title> titles;

void bi_search(int power){
    int lo = 0;
    int hi = titles.size();
    
    while(lo <= hi){
        int mid = (lo + hi) >> 1;

        if(titles[mid].power < power) lo = mid + 1;
        else hi = mid - 1;
    }
    cout << titles[lo].name << "\n";
}

int main(void){
    FAST;
    //freopen("input.txt", "r", stdin);
    cin >> n >> m;

    int temp = -1;
    rep(i, 0, n){
        string name;
        int power;    
        cin >> name >> power;
        if(power == temp) continue;
        
        temp = power;
        titles.push_back({name, power});
    }
    
    sort(titles.begin(), titles.end());

    rep(i, 0, m){
        int power;
        cin >> power;
        bi_search(power);
    }
}