#include <iostream>
#include <vector>
#include <algorithm>
#include <string>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

// 백트래킹? 진짜 나이브하게 27^81 번인데 터지지 않을까
// 오름 차순 정렬 -> unordered_set이 아닌 set을 사용

struct Pos {
    int y;
    int x;
};

vector<vector<int>> boards(9, vector<int>(9));
vector<Pos> positions;
bool found = false;

// 들어갈 수 있는 숫자 찾기. 0번째 비트는 항상 켜져있음 주의
int checkCol(int col) {
    int res = (1 << 11) - 1;

    rep(i, 0, 9) {
        if (boards[i][col] == 0) { continue; }
        res &= ~(1 << boards[i][col]);
    }
    return res;
}

int checkRow(int row) {
    int res = (1 << 11) - 1;

    rep(i, 0, 9) {
        if (boards[row][i] == 0) { continue; }
        res &= ~(1 << boards[row][i]);
    }
    return res;
}

int checkBlock(int y, int x) {
    int res = (1 << 11) - 1;
    int startX = (x / 3) * 3;
    int startY = (y / 3) * 3;

    rep(i, startY, startY + 3) {
        rep(j, startX, startX + 3) {
            if (boards[i][j] == 0) { continue; }
            
            res &= ~(1 << boards[i][j]);
        }
    }

    return res;
}

void printBoards() {
    for (vector<int> line: boards) {
        for (int element: line) {
            cout << element;
        }
        cout << "\n";
    }
}

void recursion(int posIndex) {
    if (found) { return; }

    if (positions.size() == posIndex) {
        printBoards();
        found = true;
        return;
    }

    Pos curPos = positions[posIndex];
    int rowAvailable = checkRow(curPos.y);
    int colAvailable = checkCol(curPos.x);
    int blockAvailable = checkBlock(curPos.y, curPos.x);

    int availables = ((rowAvailable & colAvailable) & blockAvailable);

    REP(i, 1, 9) {
        if ((availables & (1 << i)) == 0) { continue; }

        boards[curPos.y][curPos.x] = i;
        recursion(posIndex + 1);
        boards[curPos.y][curPos.x] = 0;
    }
}

int main() {
    // 입력
    rep(i, 0, 9) {
        string line;
        cin >> line;

        rep(j, 0, 9) {
            int num = line[j] - '0';
            boards[i][j] = num;
            
            if (num == 0) positions.push_back({i, j});
        }
    }

    recursion(0);
}