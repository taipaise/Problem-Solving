#include <iostream> 
#include <vector>
#include <queue>
#include <string>
#include <unordered_map>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
using namespace std;

struct Pos {
    int y;
    int x;
};

const int AlphaCount = 26;
const vector<int> dy = {-1, 1, 0, 0};
const vector<int> dx = {0, 0, -1, 1};
int height, width;
vector<string> boards;
vector<vector<bool>> visited;
vector<bool> keys(26, false);

bool inRange(int y, int x) {
    return 0 <= y && y < height && 0<= x && x < width;
}

int bfs() {
    int res = 0;
    queue<Pos> queue;
    unordered_map<char, vector<Pos>> candidates;
    visited[0][0] = true;
    queue.push({0, 0});

    while(!queue.empty()) {
        Pos pos = queue.front();
        int y = pos.y;
        int x = pos.x;
        queue.pop();

        if (boards[y][x] == '$') {
            ++res;
            boards[y][x] = '.';
        }

        rep(dir, 0, 4) {
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if (!inRange(ny, nx)) { continue; }
            if (boards[ny][nx] == '*') { continue; }
            if (visited[ny][nx]) { continue; }

            if (boards[ny][nx] == '.' || boards[ny][nx] == '$') {
                visited[ny][nx] = true;
                queue.push({ny, nx});
                continue;
            }

            if (islower(boards[ny][nx])) { // 열쇠인 경우
                keys[boards[ny][nx] - 'a'] = true;
                visited[ny][nx] = true;
                queue.push({ny, nx});

                vector<Pos> positions = candidates[boards[ny][nx]];
                candidates.erase(boards[ny][nx]);

                for(Pos pos: positions) {
                    queue.push(pos);
                    visited[pos.y][pos.x] = true;
                }
                continue;
            }

            // 열쇠가 있는 경우
            if (keys[boards[ny][nx] - 'A']) {
                visited[ny][nx] = true;
                queue.push({ny, nx});
            } else {
                candidates[tolower(boards[ny][nx])].push_back({ny, nx});
            }
        }
    }

    return res;
}

void initializeBoards() {
    boards.clear();
    boards.resize(height);

    visited.clear();
    visited.resize(
        height,
        vector<bool>(width, false)
    );
}

void configureKeys(string intialKeys) {
    keys = vector<bool>(26, false);

    if (intialKeys == "0") { return; }

    for(auto key: intialKeys) {
        keys[(key - 'a')] = true;
    }
}

void solve() {
    cin >> height >> width;

    height += 2;
    width += 2;
    initializeBoards();

    string padding(width, '.');
    boards[0] = padding;
    boards[height - 1] = padding;

    rep(i, 1, height - 1) {
        string line;
        cin >> line;
        boards[i] = '.' + line + '.';
    }

    string initialKeys;
    cin >> initialKeys;
    configureKeys(initialKeys);

    cout << bfs() << "\n";
}


int main() {
    int tc;
    cin >> tc;
    
    rep(i, 0, tc) {
        solve();
    }

}