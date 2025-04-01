#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;

struct Pos {
    int y;
    int x;
};

int height, width;
int throwCount;
vector<int> dy = {-1, 1, 0, 0};
vector<int> dx = {0, 0, -1, 1};
vector<int>throwDx = {1, -1};
vector<vector<int>> chunks;
vector<vector<char>> boards;
vector<int> throwHeights;

void input() {
    cin >> height >> width;
    boards = vector<vector<char>>(height, vector<char>(width));
    chunks = vector<vector<int>>(height, vector<int>(width, 0));

    rep(y, 0, height) {
        rep(x, 0, width) {
            cin >> boards[y][x];
        }
    }

    cin >> throwCount;
    throwHeights.resize(throwCount);

    rep(i, 0, throwCount) {
        cin >> throwHeights[i];
        throwHeights[i] = height - throwHeights[i];
    }
}

void printBoards() {
    rep(y, 0, height) {
        rep(x, 0, width) {
            cout << boards[y][x];
        }
        cout << "\n";
    }
}

void printChunks() { // 디버깅용
    rep(y, 0, height) {
        rep(x, 0, width) {
            cout << chunks[y][x];
        }
        cout << "\n";
    }
}

bool inRange(int y, int x) {
    return 0 <= y && y < height && 0 <= x && x < width;
}

// 청크 번호 bfs 부여. 인접한 chunk가 있다면 set에 넣어 반환
unordered_set<int> configureChunks(int chunkNumber, Pos start) {
    queue<Pos> q;
    unordered_set<int> res;
    
    chunks[start.y][start.x] = chunkNumber;
    q.push(start);
    res.insert(chunkNumber);

    while (!q.empty()) {
        Pos pos = q.front();
        q.pop();

        int y = pos.y;
        int x = pos.x;

        rep(dir, 0, 4) {
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if (!inRange(ny, nx)) { continue; }
            if (boards[ny][nx] == '.') { continue; }
            if (chunks[ny][nx] > 0) {
                res.insert(chunks[ny][nx]);
                continue;
            }

            chunks[ny][nx] = chunkNumber;
            q.push({ny, nx});
        }
    }

    return res;
}

// 부술 위치를 찾는다.
Pos fetchPosToBreak(int direction, int row) {
    Pos res = {-1, -1};
    int x = direction == 0 ? 0 : width - 1;

    while (true) {
        if (!inRange(row, x)) { break; }
        if (boards[row][x] == 'x') {
            res = {row, x};
            break;
        }

        x += throwDx[direction];
    }
    return res;
}

vector<Pos> eraseChunkNum(Pos start) {
    queue<Pos> q;
    vector<Pos> erased;
    chunks[start.y][start.x] = 0;
    q.push(start);
    erased.push_back(start);

    while (!q.empty()) {
        Pos pos = q.front();
        int y = pos.y;
        int x = pos.x;
        q.pop();

        rep(dir, 0, 4) {
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if (!inRange(ny, nx)) { continue; }
            if (boards[ny][nx] == '.') { continue; }
            if (chunks[ny][nx] == 0) { continue; }

            chunks[ny][nx] = 0;
            q.push({ny, nx});
            erased.push_back({ny, nx});
        }
    }
    return erased;
}

bool canMoveDown(vector<Pos> positions) {
    for (Pos position: positions) {
        int ny = position.y + 1;

        if (!inRange(ny, position.x)) { return false; }
        if (chunks[ny][position.x] > 0) { return false; }
    }

    return true;
}

vector<Pos> moveDown(vector<Pos> positions) {
    while (canMoveDown(positions)) {
        for(Pos position: positions) {
            boards[position.y][position.x] = '.';
        }

        rep(i, 0, positions.size()) {
            ++positions[i].y;
            boards[positions[i].y][positions[i].x] = 'x';
        }
    }

    return positions;
}

void unifyChunk(unordered_set<int> chunkNums) {
    int unifiedChunkNum = *chunkNums.begin();

    rep(y, 0, height) {
        rep(x, 0, width) {
            if (!chunkNums.count(chunks[y][x])) { continue; }
            chunks[y][x] = unifiedChunkNum;
        }
    }
}

int main() {
    FAST;
    input();

    // 초기 청크 넘버 부여
    int chunkNumber = 0;
    rep(y, 0, height) {
        rep(x, 0, width) {
            if (boards[y][x] == '.') { continue; }
            if (chunks[y][x] > 0) { continue; }
            configureChunks(++chunkNumber, {y, x});
        }
    }

    int throwDirection = 1;
    for(int throwHeight: throwHeights) {
        throwDirection = (throwDirection + 1) % 2;

        Pos posToBreak = fetchPosToBreak(throwDirection, throwHeight);

        if (posToBreak.y == -1) { continue; } // 부순게 아무것도 없으면 건너뜀

        boards[posToBreak.y][posToBreak.x] = '.';
        int preChunkNum = chunks[posToBreak.y][posToBreak.x];
        chunks[posToBreak.y][posToBreak.x] = 0;

        rep(dir, 0, 4) {
            int ny = posToBreak.y + dy[dir];
            int nx = posToBreak.x + dx[dir];

            if (!inRange(ny, nx)) { continue; }
            if (boards[ny][nx] == '.') { continue; }
            if (chunks[ny][nx] != preChunkNum) { continue; }

            vector<Pos> erasedPositions = eraseChunkNum({ny, nx});
            
            if (erasedPositions.empty()) { continue; }
            
            erasedPositions = moveDown(erasedPositions);

            unordered_set<int> chunksToUnify = configureChunks(++chunkNumber, erasedPositions[0]);
            unifyChunk(chunksToUnify);
        }
    }

    printBoards();
}