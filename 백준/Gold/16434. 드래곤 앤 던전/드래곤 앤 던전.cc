#include <iostream>
#include <algorithm>
#include <vector>


#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
typedef long long ll;
struct Room{
    ll type;
    ll atk;
    ll hp;
};

ll atk;
ll n;
vector<Room> vec;

ll battle(ll cur_hp, ll cur_atk, ll e_hp, ll e_atk){
    ll turn, e_turn;
    
    turn = e_hp / cur_atk;
    if(e_hp % cur_atk) ++ turn;

    e_turn = cur_hp / e_atk;
    if(cur_hp % e_atk) ++ e_turn;

    if(turn <= e_turn) return cur_hp - ((turn - 1) * e_atk);
    return 0;
}

bool check(ll mid){
    ll cur_hp = mid;
    ll cur_atk = atk;
    rep(i, 0, n){
        ll room_type = vec[i].type;
        ll room_atk = vec[i].atk;
        ll room_hp = vec[i].hp;

        //몬스터가 있는 방
        if(room_type == 1){
            cur_hp = battle(cur_hp, cur_atk, room_hp, room_atk);
            //용사 hp가 0이하일 경우 false
            if(cur_hp == 0) return false; 
        }
        //포션이 있는 방
        else{
            cur_hp += room_hp;
            cur_atk += room_atk;
            //hp 최대치 이상 회복 불가능
            if(cur_hp > mid) cur_hp = mid;
        }
    }

    //모든 방을 통과하면 true
    return true;
}

ll solve(){
    ll lo = 0;
    ll hi = 1e18;
    
    while(lo + 1 < hi){
        ll mid = (lo + hi) >> 1;
        // cout << lo << " " << hi << "\n";

        if(check(mid)) hi = mid;
        else lo = mid;
    }
    return hi; 
}

int main(void){
    FAST;
    cin >> n >> atk;
    vec.resize(n);
    rep(i, 0, n){
        ll t, a, h;
        cin >> t >> a >> h;
        vec[i] = {t, a, h};
    }

    cout << solve();
}
