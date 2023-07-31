#include <iostream>
#include <algorithm>
#include <vector>
#include <cstring>
#include <unordered_map>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int tc;
int n; 
int k;
int build_time[1001];
int complete_time[1001];
vector<int> pre_building [1001];

int target;

void init(){
    memset(build_time, -1, sizeof(build_time));
    memset(complete_time, -1, sizeof(complete_time));
    REP(i, 1, 1000) pre_building[i].clear();
}

int get_time(int x){
    if(complete_time[x] != -1) return complete_time[x];

    int res = 0;
    rep(i, 0, pre_building[x].size()) res = max(res, get_time(pre_building[x][i]));
        
    res += build_time[x];
    complete_time[x] = res;

    return complete_time[x];
}

int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    cin >> tc;

    REP(t, 1, tc){
        cin >> n >> k;
        init();

        //해당 건물만 짓는 시간을 입력받음
        REP(i, 1, n)
            cin >> build_time[i];
    
        //선행 건물 정보를 입력 받음
        int srt, end;
        rep(i, 0, k){
            cin >> srt >> end;
            pre_building[end].push_back(srt);
        }

        //선행 건물이 없는 건물들의 짓는 시간을 complete_time에 입력
        REP(i, 1, n)
            if(pre_building[i].empty()) complete_time[i] = build_time[i];

        cin >> target;
        cout << get_time(target) << "\n";
    }
}


