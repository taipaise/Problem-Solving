#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
struct POS{
    int y;
    int x;
};

int tc;
int n;
int edge_core = 0;
int core_cnt;
int line_cnt;
int board[12][12];
int dy[5] = {-1, 1, 0, 0, 0};
int dx[5] = {0, 0, -1, 1, 0};
vector<POS> core_list;


bool in_range(int y, int x){
    return (0 <= y && y < n) && (0 <= x && x < n);
}

void print_map(){
    cout << "####srt####\n";
    rep(i, 0, n){
        rep(j, 0, n){
            cout << board[i][j];
        }
        cout << "\n";
    }
    cout << "####end####\n";
}

bool is_corner(int y, int x){
    if(y == 0 || y == n - 1) return true;
    if(x == 0 || x == n - 1) return true;
    return false;
}

void init(){
    // memset(board, 0, sizeof(board));
    core_list.clear();
    core_cnt = 0;
    line_cnt = 999;
    edge_core = 0;
}

int can_reach(int index, int direction){
    int ny = core_list[index].y;
    int nx = core_list[index].x;
    int cnt = 0;

    while(1){
        ny += dy[direction];
        nx += dx[direction];

        if(!in_range(ny, nx)) break;
        if(board[ny][nx] == 1){
            cnt = 0;
            break;
        }
        ++cnt;
    }
    return cnt;
}

void draw_line(int index, int direction){
    int ny = core_list[index].y;
    int nx = core_list[index].x;

    while(1){
        ny += dy[direction];
        nx += dx[direction];

        board[ny][nx] = 1;
        if(is_corner(ny, nx)) break;
    }
}

void erase_line(int index, int direction){
    int ny = core_list[index].y;
    int nx = core_list[index].x;

    while(1){
        ny += dy[direction];
        nx += dx[direction];

        board[ny][nx] = 0;
        if(is_corner(ny, nx)) break;
    }
}

void search(int cur_core, int cur_line, int core_index){
    if(core_index == core_list.size()){
        if(cur_core && cur_core > core_cnt){
            core_cnt = cur_core; 
            line_cnt = cur_line;
            // print_map();
        }
        else if(cur_core && cur_core == core_cnt){
            // if(line_cnt > cur_line) print_map();
            line_cnt = min(line_cnt, cur_line);
        }
        return;
    }

    rep(dir, 0, 5){
        if(cur_core + core_list.size() - core_index < core_cnt) continue;

        //코어 연결 안하고 지나감
        if(dir == 4)
            search(cur_core, cur_line, core_index + 1);

        int check = can_reach(core_index, dir);
        if(check){
            draw_line(core_index, dir);
            search(cur_core + 1, cur_line + check, core_index + 1);
            erase_line(core_index, dir);
        }
        else
            search(cur_core, cur_line, core_index + 1);
    }
}

int main(void){
    FAST;
    //freopen("input.txt", "r", stdin);
    cin >> tc;

    REP(t, 1, tc){
        init();
        cin >> n;
        rep(i, 0, n){
            rep(j, 0, n){
                cin >> board[i][j];
                if(board[i][j])
                    if(!is_corner(i, j)) core_list.push_back({i, j});
            }
        }

        search(0, 0, 0);
        cout << "#" << t << " ";
        cout << line_cnt << "\n";
    }
}