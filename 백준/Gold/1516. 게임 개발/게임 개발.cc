#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

int n;
int build_time[501];
int total_time[501];
vector<int> pre[501];

int get_time(int no){
    if(total_time[no] == 0){
        int time = 0;
        rep(i, 0, pre[no].size())
            time = max(time, get_time(pre[no][i]));
        time += build_time[no];
        total_time[no] = time;
    }
    return total_time[no];
}

int main(void){
    cin >> n;

    REP(i, 1, n){
        cin >> build_time[i];

        //선행 건물 입력
        int temp;
        while(1){
            cin >> temp;
            if(temp == -1) break;
            pre[i].push_back(temp);
        }
        //선행 건물이 없는 경우
        if(pre[i].size() == 0)
            total_time[i] = build_time[i];
    }

    REP(i, 1, n){
        cout << get_time(i) << "\n";
    }
}
