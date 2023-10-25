#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

struct Chapter{
    int time;
    int score;
};

int n;
int t;
int dp[101][10001];
vector<Chapter> vec;

void makeDp(){
    REP(i, 1, n){
        REP(j, 1, t){
            if(vec[i].time > j)
                dp[i][j] = dp[i - 1][j];
            else
                dp[i][j] = max(dp[i - 1][j], dp[i - 1][j - vec[i].time] + vec[i].score);
        }
    }
}

int main(void){
    FAST;
    cin >> n >> t;
    vec.resize(n + 1);

    int time, score;
    REP(i, 1, n){
        cin >> time >> score;
        vec[i] = {time, score};
    }

    makeDp();
    cout << dp[n][t];
}