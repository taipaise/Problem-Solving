#include <iostream>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;


struct Dice{
    int x;
    int y;

    int top = 0;
    int down = 0;
    int front = 0;
    int back = 0;
    int left = 0;
    int right = 0;

    Dice(int x, int y):y(y), x(x){
    }
    Dice(){}
};

int n, m, k;
int mapp[20][20];
//동서남북이 각 1, 2, 3, 4
int dx[]= {0, 0, 0, -1, 1};
int dy[]= {0, 1, -1, 0, 0};
Dice dice;

bool in_range(int x, int y){
    return (0 <= x && x < n) && (0 <= y && y < m);
}

//주사위 오른쪽으로 굴리기
void roll_right(){
    int temp;
    temp = dice.down;
    dice.down = dice.right;
    dice.right = dice.top;
    dice.top = dice.left;
    dice.left = temp;
}

//주사위 왼쪽으로 굴리기
void roll_left(){
    int temp;
    temp = dice.down;
    dice.down = dice.left;
    dice.left = dice.top;
    dice.top = dice.right;
    dice.right = temp;
}

//주사위 위쪽으로 굴리기
void roll_up(){
    int temp;
    temp = dice.down;
    dice.down = dice.back;
    dice.back = dice.top;
    dice.top = dice.front;
    dice.front = temp;
}

//주사위 아래쪽으로 굴리기
void roll_down(){
    int temp;
    temp = dice.down;
    dice.down = dice.front;
    dice.front = dice.top;
    dice.top = dice.back;
    dice.back = temp;
}

void roll(int dir){
    int x = dice.x;
    int y = dice.y;

    int nx = x + dx[dir];
    int ny = y + dy[dir];
    if(!in_range(nx, ny)) return;

    dice.x = nx;
    dice.y = ny;
    //주사위 굴리기
    //주사위를 굴릴 경우 4가지 값만 회전하게 됨
    switch (dir)
    {
    case 1:
    roll_right();
        break;
    case 2:
    roll_left();
        break;
    case 3:
    roll_up();
        break;
    case 4:
    roll_down();
        break;
    default:
        break;
    }

    if(mapp[nx][ny] == 0)
        mapp[nx][ny] = dice.down;
    else{
        dice.down = mapp[nx][ny];
        mapp[nx][ny] = 0;
    }
    cout << dice.top << "\n";
}

int main(void){
    int x, y;
    cin >> n >> m;
    cin >> x >> y;
    cin >> k;
    dice = Dice(x, y);

    rep(i, 0, n){
        rep(j, 0, m){
            cin >> mapp[i][j];
        }
    }
    rep(i, 0, k){
        int operation;
        cin >> operation;

        roll(operation);
    }
    return 0;
}
