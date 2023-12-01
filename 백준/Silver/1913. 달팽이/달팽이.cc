#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <stack>
#include <set>
#include <cstring>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;
int n, target;
int y, x;
struct Board {
    int dy[4] = {1, 0, -1, 0};
    int dx[4] = {0, 1, 0, -1};
    int board[1000][1000];

    int y = 0;
    int x = 0;
    int dir = 0;
    
    void turn_left() {
        dir = (dir + 1) % 4;
    }

    bool in_range(int y, int x) {
        return (0 <= y && y < n) && (0 <= x && x < n);
    }

    bool can_move() {
        int ny = y + dy[dir];
        int nx = x + dx[dir];
        if(!in_range(ny, nx)) return false;
        if(board[ny][nx]) return false;
        return true;
    }

    void move() {
        y += dy[dir];
        x += dx[dir];
    }

    void record(int p) {
        board[y][x] = p;
    }

    void print() {
        rep(i, 0, n) {
            rep(j, 0, n) {
                cout << board[i][j] << " ";
            }
            cout << "\n";
        }
    }
};
Board board;

int main(void){
    cin >> n >> target;
    for(int i = n * n; i >= 1; --i) {
        board.record(i);
        if(i == target) {
            y = board.y;
            x = board.x;
        }

        if(!board.can_move()) board.turn_left();
        board.move();
    }

    board.print();
    cout << y + 1 << " " << x + 1;
}