#include <iostream>
#include <vector>
#include <queue>
#include <cstring>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

struct POS{
    int y;
    int x;
};

struct Dice{
    int y = 1;
    int x = 1;
    int up = 1;
    int down = 6;
    int right = 3;
    int left = 4;
    int front = 5;
    int back = 2;

    int dir = 0; //동0 남1 서2 북3

    void change_dir(bool flag){ //1: A>B , 0: A<B
        if(flag){
            ++dir;
            if(dir == 4) dir = 0;
        }
        //A < B
        else{
            --dir;
            if(dir == -1) dir = 3;
        }
    }

    void turn_up(){
        --y;
        int temp = up;
        up = front;
        front = down;
        down = back;
        back = temp;
    }
    void turn_down(){
        ++y;
        int temp = up;
        up = back;
        back = down;
        down = front;
        front = temp;   
    }
    void turn_right(){
        ++x;
        int temp = up;
        up = left;
        left = down;
        down = right;
        right = temp;
    }
    void turn_left(){
        --x;
        int temp = up;
        up = right;
        right = down;
        down = left;
        left = temp;
    }
};

int n, m, k;
int board[21][21];
bool visited[21][21];
//동 남 서 북
int dy[4] = {0, 1, 0, -1};
int dx[4] = {1, 0, -1, 0};
int score = 0;
int res = 0;
Dice dice;

bool in_range(int y, int x){
    return (0 < y && y <= n) && (0 < x && x <= m);
}

void bfs(){
    queue<POS> q;
    q.push({dice.y, dice.x});
    memset(visited, false, sizeof(visited));
    visited[dice.y][dice.x] = true;
    int move_cnt = 1;

    while(!q.empty()){
        int y = q.front().y;
        int x = q.front().x;
        q.pop();

        rep(dir, 0, 4){
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(ny, nx)) continue;
            if(visited[ny][nx]) continue;
            if(board[ny][nx] != board[dice.y][dice.x]) continue;

            visited[ny][nx] = true;
            // cout << ny << " " << nx << "\n";
            ++move_cnt;
            q.push({ny, nx});
        }
    }
    // cout << "move: " << move_cnt << "\n";
    score += (move_cnt * board[dice.y][dice.x]);
}

void move_dice(){
    while(k--){
        int ny = dice.y + dy[dice.dir];
        int nx = dice.x + dx[dice.dir];

        //주사위 굴릴 수 있나 확인
        if(!in_range(ny, nx)){
            dice.dir = (dice.dir + 2) % 4;
            ny = dice.y + dy[dice.dir];
            nx = dice.x + dx[dice.dir];
        }

        //주사위 방향으로 주사위 굴리기
        switch(dice.dir){
            case 0:
                dice.turn_right();
                break;
            case 1:
                dice.turn_down();
                break;
            case 2:
                dice.turn_left();
                break;
            case 3:
                dice.turn_up();
                break;
            default:
                break;
        }

        // cout << dice.y << " "<< dice.x <<" "<<dice.down <<"\n";

        //이동한 칸에 대해 점수 계산
        bfs();

        //주사위 다음 방향을 결정
        if(dice.down > board[dice.y][dice.x]){
            dice.change_dir(true); // 주사위 시계 방향 회전
        }
        if(dice.down < board[dice.y][dice.x]){
            dice.change_dir(false); // 주사위 반시계 방향 회전
        }
    }
}

int main(void){
    FAST;
    cin >> n >> m >> k;

    REP(i, 1, n){
        REP(j, 1, m){
            cin >> board[i][j];
        }
    }

    move_dice();
    cout << score;
}