#include <iostream>
#include <queue>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)

using namespace std;

struct POS{
    int z;
    int y;
    int x;
    int t;

    bool operator==(const POS& rhs)const{
        return (z == rhs.z) && (y == rhs.y) && (x == rhs.x);
    }
};

int l, r, c;

POS start, endd;
char map[30][30][30];
int visited[30][30][30];
int dz[] = {-1, 1, 0, 0, 0, 0};
int dy[] = {0, 0, -1, 1, 0, 0};
int dx[] = {0, 0, 0, 0, -1, 1};

void init(){
    memset(visited, 0, sizeof(visited));
}

bool in_range(int z, int y, int x){
    return (0 <= z && z < l) && (0 <= y && y < r) && (0 <= x && x < c);
}

void bfs(){
    queue<POS> q;
    q.push(start);
    

    while(!q.empty()){
        POS cur = q.front();
        q.pop();
        int z = cur.z;
        int y = cur.y;
        int x = cur.x;
        int t = cur.t;
        
        visited[z][y][x] = 1;

        if(cur == endd){
            cout << "Escaped in " << t << " minute(s).\n";
            return;
        }

        for(int dir = 0; dir < 6; dir++){
            int nz = z + dz[dir];
            int ny = y + dy[dir];
            int nx = x + dx[dir];

            if(!in_range(nz, ny, nx)) continue;
            if(map[nz][ny][nx] == '#') continue;
            if(visited[nz][ny][nx]) continue;
            visited[nz][ny][nx] = 1;
            q.push({nz, ny, nx, t + 1});
        }
    }
    cout << "Trapped!\n";
}

int main(void){
    FAST;
    //freopen("input.txt", "r", stdin);

    do{
        cin >> l >> r >> c;
        //빌딩 구조 입력 받기
        for(int i = 0; i < l; i++){
            for(int j =0; j < r; j++){
                for(int k = 0; k < c; k++){
                    cin >> map[i][j][k];
                    if(map[i][j][k] == 'S') start = {i, j, k, 0};
                    if(map[i][j][k] == 'E') endd = {i, j, k, 0 };
                }
            }
        }
    //bfs 통해 확인
    if(l && r && c){
        init();
        bfs();
    }
    }while(l && r && c);
    return 0;
}