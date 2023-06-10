#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;


struct Node{
    int no;
    int dist;

    bool operator<(const Node& rhs)const{
        return dist > rhs.dist;
    }
};

struct V{
    int no;
    vector<Node> ad;

    bool operator<(const V& rhs)const{
        return no < rhs.no;
    }
};


int n;
vector<V> graph;
vector<Node> dist;

void dfs(int x){
    //x의 인접 노드 수만큼 반복
    rep(i, 0, graph[x].ad.size()){
        //만약 이미 방문했다면 건너뛰기
        if(dist[graph[x].ad[i].no].dist != -1) continue;

        //해당 인접 노드까지의 거리를 갱신: 기준 노드에서 x까지의 거리 + x에서 인접 노드까지의 거리
        dist[graph[x].ad[i].no].dist = dist[x].dist + graph[x].ad[i].dist;
        dfs(graph[x].ad[i].no);
    }
}

void init(int x){
    dist.clear();
    dist.resize(n + 1);

    REP(i, 1, n){
        dist[i].no = i;
        dist[i].dist = -1;
    }

    dist[x].dist = 0;

    return;
}


int main(void){
    FAST;
    cin >> n;
    graph.resize(n + 1);

    REP(i, 1, n){
        int cur_node;
        cin >> cur_node;
        int no, d;
        while(true){
            cin >> no;
            if(no == -1) break;
            cin >> d;
            graph[cur_node].ad.push_back({no, d});
        }
    }

    init(1);
    dfs(1);
    sort(dist.begin() + 1, dist.end());
    
    int next = dist[1].no;
    
    init(next);
    dfs(next);
    sort(dist.begin() + 1, dist.end());

    cout << dist[1].dist;   
}