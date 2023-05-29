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

struct Status{
    ll atk;
    ll str;
    ll critical_rate;
    ll critical_multiplier;
    ll atk_speed;

    Status operator+(const Status& rhs) const{
        Status status;
        status.atk = atk + rhs.atk;
        status.str = str + rhs.str;
        status.critical_rate = critical_rate + rhs.critical_rate;
        status.critical_multiplier = critical_multiplier + rhs.critical_multiplier;
        status.atk_speed = atk_speed + rhs.atk_speed;
        return status;
    }

    Status operator-(const Status& rhs) const{
        Status status;
        status.atk = atk - rhs.atk;
        status.str = str - rhs.str;
        status.critical_rate = critical_rate - rhs.critical_rate;
        status.critical_multiplier = critical_multiplier - rhs.critical_multiplier;
        status.atk_speed = atk_speed - rhs.atk_speed;
        return status;
    }
};

Status characters[2];
Status weapons[2];

ll cri_power;
ll pabu_power;

ll get_power(Status status){
    ll power;

    power = status.atk * (ll(100) + status.str) * (100 * (ll(100) - min(status.critical_rate, ll(100))) + min(status.critical_rate, ll(100)) * (status.critical_multiplier)) * (ll(100) + status.atk_speed);
    return power;
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    
    //장비 착용상태 스탯 입력
    rep(i, 0, 2){
        ll a, b, c, d, e;
        cin >> a >> b >> c >> d >> e;
        characters[i] = {a ,b, c, d, e};
    }

    //크리, 파부 전투력 계산
    cri_power = get_power(characters[0]);
    pabu_power = get_power(characters[1]);


    //크리, 파부 장비 벗기기
    rep(i, 0, 2){
        ll a, b, c, d, e;
        cin >> a >> b >> c >> d >> e;
        weapons[i] = {a ,b, c, d, e};
        characters[i] = characters[i] -  weapons[i];
    }

    //서로 장비 바꿔 입히기
    characters[0] = characters[0] + weapons[1];
    characters[1] = characters[1] + weapons[0];

    if(cri_power < get_power(characters[0]))
        cout << "+";
    else if(cri_power == get_power(characters[0]))
        cout << "0";
    else
        cout << "-";

    cout << endl;

    if(pabu_power < get_power(characters[1]))
        cout << "+";
    else if(pabu_power == get_power(characters[1]))
        cout << "0";
    else
        cout << "-";

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
