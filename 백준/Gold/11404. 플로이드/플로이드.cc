#include <iostream>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define MAX 987654321
using namespace std;

int n, m;
int city[101][101];

void floyd(){
    REP(k, 1, n)
        REP(i, 1, n)
            REP(j, 1, n)
                city[i][j] = min(city[i][j], city[i][k] + city[k][j]);
}

void print(){
    REP(i, 1, n){
        REP(j, 1, n){
            if(city[i][j] == MAX) cout << "0 ";
            else cout << city[i][j] << " ";
        }
        cout << "\n";
    }
}

int main(void){
    FAST;
    cin >> n >> m;
    REP(i, 1, 100){
        REP(j, 1, 100){
            if(i == j) city[i][j] = 0;
            else city[i][j] = MAX;
        }
    }

    int srt, dest, w;

    rep(i, 0, m){
        cin >> srt >> dest >> w;
        city[srt][dest] = min(city[srt][dest], w);
    }
    
    floyd();
    print();
}