#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;

enum Direction {
    Up, Down, Left, Right
};

struct Pos {
    int y;
    int x;
};

struct Edge {
    int from;
    int to;
    int cost;

    bool operator<(const Edge& rhs) const {
        return cost > rhs.cost;
    }
};

struct DisjointSet {
    vector<int> parents;
    vector<int> ranks;

    DisjointSet(int n) {
        parents.resize(n + 1);
        ranks.resize(n + 1, 1);

        REP(i, 0, n) {
            parents[i] = i;
        }
    }

    void merge(int u, int v) {
        u = find(u);
        v = find(v);

        if (u == v) { return; }

        if (ranks[u] > ranks[v]) {
            swap(u, v);
        }

        parents[u] = v;

        if (ranks[u] == ranks[v]) ++ranks[v];
    }

    int find(int u) {
        if (parents[u] == u) {
            return u;
        }

        return parents[u] = find(parents[u]);
    }

    bool isAllConnected() {
        int target = find(1);

        rep(i, 1, parents.size()) {
            if (target != find(i)) {
                return false;
            }
        }

        return true;
    }
};

int height, width;
vector<int> dy = {-1, 1, 0, 0};
vector<int> dx = {0, 0, -1, 1};
vector<vector<int>> boards;
priority_queue<Edge> edges;
DisjointSet disjointSet(0);

bool inRange(int y, int x) {
    return 0 <= y && y < height && 0 <= x && x <width;
}

void bfs(int island, Pos start) {
    queue<Pos> q;
    boards[start.y][start.x] = island;
    q.push(start);

    while(!q.empty()) {
        Pos pos = q.front();
        int y = pos.y;
        int x = pos.x;
        q.pop();

        rep(dir, 0, 4) {
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if (!inRange(ny, nx)) { continue; }
            if (boards[ny][nx] != 0) { continue; }
            

            boards[ny][nx] = island;
            q.push({ny, nx});
        }
    }
}

vector<Direction> isEdge(int y, int x) {
    vector<Direction> res;

    rep(dir, 0, 4) {
        int ny = y + dy[dir];
        int nx = x + dx[dir];

        if (!inRange(ny, nx)) { continue; }

        if (boards[ny][nx] == -1) { 
            res.push_back((Direction)dir);
        }
    }

    return res;
}

Edge findEdge(Pos start, Direction direction) {
    Edge res = {-1, -1, -1};
    int startIsland = boards[start.y][start.x];
    int y = start.y;
    int x = start.x;
    int cost = 0;

    while (true) {
        int ny = y + dy[direction];
        int nx = x + dx[direction];

        if (!inRange(ny, nx)) { break; }
        if (boards[ny][nx] > 0) {
            if (boards[ny][nx] != startIsland) {
                res = {startIsland, boards[ny][nx], cost};
            }
            break;
        }

        ++cost;
        y = ny;
        x = nx;
    }
    
    return res;
}

void findEdges() {
    rep(y, 0, height) {
        rep(x, 0, width) {
            if (boards[y][x] == -1) { continue; }

            vector<Direction> directions = isEdge(y, x);
            for(Direction direction: directions) {
                Edge edge = findEdge({y, x}, direction);

                if (edge.cost < 2) { continue; }
                
                edges.push(edge);
            }
        }
    }
}

int makeMST() {
    int totalCost = 0;

    while (!edges.empty()) {
        Edge edge = edges.top();
        int from = edge.from;
        int to = edge.to;
        edges.pop();

        if (disjointSet.find(from) == disjointSet.find(to)) { continue; }

        disjointSet.merge(from, to);
        totalCost += edge.cost;
    }

    return totalCost;
}

int main() {
    FAST;
    cin >> height >> width;
    boards.resize(height, vector<int>(width));

    rep(y, 0, height) {
        rep(x, 0, width) {
            cin >> boards[y][x];

            boards[y][x] = boards[y][x] == 1 ? 0 : -1;
        }
    }

    int island = 0;
    rep(y, 0, height) {
        rep(x, 0, width) {
            if (boards[y][x] != 0) { continue; }
            bfs(++island, {y, x});
        }
    }

    disjointSet = DisjointSet(island);
    findEdges();
    int totalCost = makeMST();

    if (disjointSet.isAllConnected()) {
        cout << totalCost;
    } else {
        cout << -1;
    }
}