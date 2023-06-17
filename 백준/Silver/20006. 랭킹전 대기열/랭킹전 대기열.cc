#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
int p, m;
struct Room{
    int lv;
    int cnt;
    vector<pair<string, int>> players;

    Room(pair<string, int> p):lv(p.second), cnt(1){
        players.push_back(p);
    }

    bool can_enter(int level){
        if(cnt < m)
            return ((lv - 10) <= level) && (level <= (lv + 10));
        return false;
    }

    void enter(pair<string, int> player){
        players.push_back(player);
        ++cnt;
    }

    void print_players(){
        rep(i, 0, players.size()){
            sort(players.begin(), players.end());
            cout << players[i].second << " " << players[i].first << "\n";
        }
    }
};

vector<Room> rooms;


int main(void){
    cin >> p >> m;

    string name;
    int level;
    int flag;
    rep(i, 0, p){
        cin >> level >> name;
        flag = false;

        for(auto&e: rooms){
            if(e.can_enter(level)){
                e.enter({name, level});
                flag = true;
                break;
            }
        }
        if(!flag){
            rooms.push_back(Room({name, level}));
        }
    }

    for(auto&e: rooms){
        if(e.cnt == m){
            cout << "Started!\n";
            e.print_players();
        }
        else{
            cout << "Waiting!\n";
            e.print_players();
        } 
    }
}