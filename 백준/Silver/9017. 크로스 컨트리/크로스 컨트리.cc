#include <iostream>
#include <unordered_map>
#include <vector>
#include <set>
#include <algorithm>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

struct Team {
    int team_no;
    int score;
    int cnt;
    int fifth;

    Team(){
        team_no = 0;
        score = 0;
        cnt = 0;
        fifth = 0;
    }

    void add_player(int team_n, int s) {
        team_no = team_n;
        ++cnt;
        if (cnt == 5) fifth = s;
        if(cnt < 5) score += s;
    }
    //오름 차순 정렬 기준
    //인원수가 많을수록 우선순위 높음
    //점수가 작을수록 우선순위 높음
    //5번째 주자의 점수가 낮을수록 우선순위 높음

    bool operator<(const Team& rhs) const {
        if (cnt != rhs.cnt) return cnt > rhs.cnt;
        if (score != rhs.score) return score < rhs.score;
        return fifth < rhs.fifth;
    }
};

int cases, n;

int main(void) {
    FAST;
    //freopen("input.txt", "r", stdin);
    cin >> cases;

    while(cases--) {
        //변수 선언
        vector<Team> teams(201);
        vector<int> players;
        int cnt[201] = {0, };

        cin >> n;
        players.resize(n);

        //player를 입력받고, team의 인원수를 체크
        rep(i, 0, n) {
            cin >> players[i];
            ++cnt[players[i]];
        }
        
        //인원이 6명인 팀만 점수를 올려줌
        int score = 0;
        rep(i, 0, n) {
            if (cnt[players[i]] == 6) teams[players[i]].add_player(players[i], ++score);
        }

        sort(teams.begin(), teams.end());
        
        cout << teams[0].team_no;
        if(cases) cout <<"\n";
    }
}
