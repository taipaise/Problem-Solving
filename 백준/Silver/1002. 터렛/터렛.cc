#include <iostream>
#include <algorithm>
#include <cmath>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

double x1, x2;
double y, y2;
double r1, r2;
double resx, resy;
int tc;


int main(void){
    // freopen("input.txt", "r", stdin);
    cin >> tc;

    rep(t, 0, tc){
        cin >> x1 >> y >> r1 >> x2 >> y2 >> r2;

        double dist = sqrt((x1 - x2) * (x1 - x2) + (y - y2) * (y - y2));
        
        if(dist == 0){
            if(r1 == r2) cout << -1 << "\n";
            else cout << 0 << "\n";
        }
        else if(dist == abs(r1 - r2) || dist == r1 + r2) cout << 1 << "\n";
        else if(abs(r1 - r2) < dist && dist < r1 + r2) cout << 2 << "\n";
        else cout << 0 << "\n";
        
    }
}