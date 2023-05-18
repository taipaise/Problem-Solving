#include <iostream>
#include <algorithm>

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

//dpMax[i][j] := i행 j열까지 왔을때 최대 점수
//dpMin[i][j] := i행 j열까지 왔을때 최소 점수

//if j == 0
//dpMax[i][j] = max(dpMax[i - 1][j], dpMax[i - 1][j + 1]) + dpMax[i][j]
//if j == 1
//dpMax[i][j] = max(dpMax[i - 1][j], dpMax[i - 1][j + 1]) + dpMax[i][j]
//if j == 2
//dpMAX[i][j] = max({dpMax[i - 1][j -1], dpMax[i - 1][j], dpMax[i - 1][j + 1]}) + dpMax[i][j]

int n;
int map[3];
int dpMax[3];
int dpMin[3];
int tempMax[3];
int tempMin[3];

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n;
    rep(i, 0, 3) cin >> map[i];

    rep(i, 0, 3){
        dpMax[i] = map[i];
        dpMin[i] = map[i];
    }

    rep(i, 0, n - 1){
        cin >> map[0] >> map[1] >> map[2];

        rep(j, 0, 3){
            if(j == 0){
                tempMax[0] = max(dpMax[j], dpMax[j + 1]) + map[0];
                tempMin[0] = min(dpMin[j], dpMin[j + 1]) + map[0];
            }
            else if(j == 1){
                tempMax[1] = max({dpMax[j - 1], dpMax[j], dpMax[j + 1]}) + map[1];
                tempMin[1] = min({dpMin[j - 1], dpMin[j], dpMin[j + 1]}) + map[1];
            }
            else{
                tempMax[2] = max(dpMax[j - 1], dpMax[j]) + map[2];
                tempMin[2] = min(dpMin[j - 1], dpMin[j]) + map[2];
            }
        }

        rep(j, 0, 3){
            dpMax[j] = tempMax[j];
            dpMin[j] = tempMin[j];
        }
    }
    cout << *max_element(dpMax, dpMax + 3) << " ";
    cout << *min_element(dpMin, dpMin + 3);

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
