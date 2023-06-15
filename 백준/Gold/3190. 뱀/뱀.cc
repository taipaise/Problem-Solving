#include <iostream>
#include <vector>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

struct POS{
    int y;
    int x;
};

struct Snake{
    POS pos;
    int dir;
    int change_cnt;
    int move_cnt;

    Snake(){
        pos = {1, 1};
        dir = 0;
        change_cnt = 0;
        move_cnt = 0;
    }
    void turn_right(){
        ++dir;
        if(dir > 3) dir = 0;
    }
    
    void turn_left(){
        --dir;
        if(dir < 0) dir = 3;
    }
};

struct Direction{
    int t;
    char d;
};

int n, k, l;
vector<POS> apples;
vector<Direction> cd; //change direction
Snake snake;
Snake tail;
int board[101][101]; // 1이면 뱀이 존재 하는 것임
//오른쪽으로 회전할 경우 Index를 1증가, 왼쪽 회전할 경우 index 1 감소
int dy[4] = {0, 1, 0, -1};
int dx[4] = {1, 0, -1, 0};

void print_map(){
    REP(i, 1, n){
        REP(j, 1, n){
            cout << board[i][j];
        }
        cout << "\n";
    }
}

bool in_range(int y, int x){
    return (0 < y && y <= n) && (0 < x && x <= n);
}

void solve(){
    bool eat_apple;

    while(true){
        eat_apple = false;
        int y = snake.pos.y;
        int x = snake.pos.x;

        ++snake.move_cnt;
        // cout <<"time " << time << "\n";
        int ny = y + dy[snake.dir];
        int nx = x + dx[snake.dir];

        //벽을 만나면 끝냄
        if(!in_range(ny, nx)) return;
        //만약 이동한 자리에 이미 몸통이 있으면 끝냄
        if(board[ny][nx]) return;
        
        //이동 가능하면 일단 머리를 이동
        board[ny][nx] = 1;

        rep(i, 0, apples.size()){
            if(ny == apples[i].y && nx == apples[i].x){
                apples.erase(apples.begin() + i);
                eat_apple = true;
                break;
            }
        }

        if(!eat_apple){
            board[tail.pos.y][tail.pos.x] = 0;
            ++tail.move_cnt;
            
            int tail_ny = tail.pos.y + dy[tail.dir];
            int tail_nx = tail.pos.x + dx[tail.dir];
            tail.pos = {tail_ny, tail_nx};
        
            if(tail.change_cnt < cd.size()){
                if(tail.move_cnt == cd[tail.change_cnt].t){
                    if(cd[tail.change_cnt].d == 'L') tail.turn_left();
                    else tail.turn_right();
                    ++tail.change_cnt;
                }
            }
        }
        if(snake.change_cnt < cd.size())
        {
            if(snake.move_cnt == cd[snake.change_cnt].t){
                if(cd[snake.change_cnt].d == 'L') snake.turn_left();
                else snake.turn_right();
                ++snake.change_cnt;
            }
        }

        y = ny;
        x = nx;
        snake.pos = {y, x};
        // print_map();
        // cout << "\n";
    }
}


int main(void){
    cin >> n >> k;
    rep(i, 0, k){
        int y, x;
        cin >> y >> x;
        apples.push_back({y, x});
    }
    cin >> l;
    rep(i, 0, l){
        int time;
        char dir;
        cin >> time;
        cin >> dir;
        cd.push_back({time, dir});
    }

    board[1][1] = 1; // 뱀의 최초 시작은 좌측 최상단
    snake = Snake();
    tail = Snake();
    solve();
    cout << snake.move_cnt;
}