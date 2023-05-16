#include <iostream>
#include <vector>

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

struct FB{
    int row;
    int col;
    int mass;
    int speed;
    int dist;
};

vector<FB> map[51][51];

int dy[] = {-1, -1, 0, 1, 1, 1, 0, -1};
int dx[] = {0, 1, 1, 1, 0, -1, -1, -1};
int dist1[] = {0, 2, 4, 6};
int dist2[] = {1, 3, 5, 7};

int n, m, k;
vector<FB> fireballs;

void clear_map(){
    REP(i, 1, n){
        REP(j, 1, n){
            map[i][j].clear();
        }
    }
}

void move_fire(){
    clear_map();

    rep(i, 0, fireballs.size()){
        int row = fireballs[i].row;
        int col = fireballs[i].col;
        int dist = fireballs[i].dist;
        int speed = fireballs[i].speed;
        int mass = fireballs[i].mass;

	   	int new_row = row + ((speed * dy[dist]) % n);
        int new_col = col + ((speed * dx[dist]) % n);
        
		if(new_row > n)
			new_row -= n;

		if (new_row < 1)
			new_row += n;

		if(new_col > n)
			new_col -= n;

		if (new_col < 1)
			new_col += n;

        map[new_row][new_col].pb({new_row, new_col, mass, speed, dist});
    }
}

void split_fire(){
    fireballs.clear();

    REP(i, 1, n){
        REP(j, 1, n){
            if(map[i][j].size() < 2) {
                if(map[i][j].size())
                    fireballs.pb(map[i][j][0]);
                continue;
            }
            int new_mass = 0;
            int new_speed = 0;
            int odd = 0;
            int even = 0;

            rep(q, 0, map[i][j].size()){
                new_mass += map[i][j][q].mass;
                new_speed += map[i][j][q].speed;
                if(map[i][j][q].dist % 2)
					++odd;
				else
                    ++even;
            }
            new_mass /= 5;
            if(new_mass){
                new_speed /= map[i][j].size();
				
                if(odd == map[i][j].size() || even == map[i][j].size())
                    rep(q, 0, 4){
						// cout << i << ' ' << j << ' ' << new_mass << ' ' << new_speed << ' ' << dist1[q] <<endl;
                        fireballs.pb({i, j, new_mass, new_speed, dist1[q]});
                    }
                else{
                    rep(q, 0, 4){
                        fireballs.pb({i, j, new_mass, new_speed, dist2[q]});
                    }
                }
            }
        }
    }
}


int get_mass(){
    int mass = 0;
    rep(i, 0, fireballs.size()){
        mass += fireballs[i].mass;
    }
    return mass;
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n >> m >> k;

    rep(i, 0, m){
        int r, c, m, s, d;
        cin >> r >> c >> m >> s >> d;
        fireballs.pb({r, c, m, s, d});
    }

    rep(i, 0, k){
        move_fire();
        split_fire();
        // print_map();
        // cout << fireballs.size() << endl;
    }
    cout << get_mass();

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
