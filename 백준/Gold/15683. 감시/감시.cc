#include <iostream>
#include <vector>
#include <algorithm>
#include <map>
#include <climits>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
using namespace std;

// 데이터 구조
enum Direction {
    UP, Right, DOWN, LEFT
};

enum SpaceType {
    BLANK, WALL, CAMERA
};

enum CameraType {
    ONE = 1, TWO, THREE, FOUR, FIVE
};

struct Camera {
    CameraType type;
    Direction startDirection;
};

struct Pos {
    int y;
    int x;

    bool operator<(const Pos& rhs) const {
        if (y != rhs.y) return y < rhs.y;
        return x < rhs.x;
    }
};

// 상수 및 변수
const vector<int> dy = {-1, 0, 1, 0};
const vector<int> dx = {0, 1, 0, -1};
vector<vector<SpaceType>> boards;
vector<Pos> cameraPositions;
map<Pos, Camera> cameras;
int height, width;
int res = INT_MAX;

// 카메라 종류에 따른 감시 방향
vector<int> getDirectionOffsets(CameraType type) {
    vector<int> res;
    switch (type) {
    case ONE:
        res = {0};
        break;
    case TWO:
        res = {0, 2};
        break;
    case THREE:
        res = {0, 1};
        break;
    case FOUR:
        res = {0, 1, 3};
        break;
    case FIVE:
        res = {0, 1, 2, 3};
        break;
    }
    return res;
}

// 감시 시작
bool inRange(int y, int x) {
    return 0 <= y && y < height && 0 <= x && x < width;
}

int simulate() {
    vector<vector<bool>> visited(height, vector<bool>(width, false));
    int res = 0;
    for(const auto& [pos, camera]: cameras) {
        visited[pos.y][pos.x] = true;
        
        for(const auto& offset: getDirectionOffsets(camera.type)) {
            int y = pos.y;
            int x = pos.x;

            Direction direction = Direction((camera.startDirection + offset) % 4);

            while (true) {
                int ny = y + dy[direction];
                int nx = x + dx[direction];

                if (!inRange(ny, nx)) { break; }
                if (boards[ny][nx] == WALL) { break; }

                visited[ny][nx] = true;
                y = ny;
                x = nx;
            }
        }
    }

    rep(y, 0, height)
        rep(x, 0, width)
            if (!visited[y][x] && boards[y][x] == BLANK) ++res;
    return res;
}

// 방향 회전 함수
Direction rotate(Direction direction) {
    return Direction((direction + 1) % 4);
}

// 카메라 방향 설정 (재귀)
void configureCamera(int count, int index) {
    if (count == cameras.size()) {
        res = min(res, simulate());
        return;
    }

    rep(i, index, cameras.size()) {
        rep(dir, 0, 4) {
            // 카메라 방향 설정
            Pos pos = cameraPositions[i];
            cameras[pos].startDirection = rotate(cameras[pos].startDirection);
            configureCamera(count + 1, i + 1);
        }
    }
}

int main() {
    cin >> height >> width;
    boards.resize(height);

    rep(y, 0, height) {
        boards[y].resize(width);

        rep(x, 0, width) {
            int input;
            cin >> input;

            switch (input) {
            case 0:
                boards[y][x] = BLANK;
                break;
            case 6:
                boards[y][x] = WALL;
                break;
            default:
                boards[y][x] = CAMERA;
                cameraPositions.push_back({y, x});
                cameras[{y, x}] = {CameraType(input), UP};
                break;
            }
        } 
    }

    configureCamera(0, 0);

    cout << res;
}