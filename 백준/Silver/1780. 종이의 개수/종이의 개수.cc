#include <iostream>
#include <vector>
#include <map>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end() 
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

int n;
vector<vector<int>> paper;
map<int, int> res;

bool check(int y, int x, int num){
    int c = paper[y][x];

    rep(i, y, y + num){
        rep(j, x, x + num){
            if(c != paper[i][j])
                return false;
        }
    }
    return true;
}

void divide(int y, int x, int num){
    if(check(y, x, num))
        res[paper[y][x]]++;
        
    else{
        int s = num / 3;
        rep(i, 0, 3){
            rep(j, 0, 3){
                divide((y + i * s), (x + j * s), s);
            }
        }
    }
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n;
    paper.resize(n, vector<int>(n));

    rep(i, 0, n){
        rep(j, 0, n){
            cin >> paper[i][j];
        }
    }
    res.insert({-1, 0});
    res.insert({0, 0});
    res.insert({1, 0});

    divide(0, 0, n);
    cout << res[-1] << endl;
    cout << res[0] << endl;
    cout << res[1] << endl;
    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
