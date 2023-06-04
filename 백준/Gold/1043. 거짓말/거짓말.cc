#include <iostream>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

int n, m;
int cnt;
int res = 0;
int know = 0;
int party_member;
vector<int> party[50];

struct DisjointSet{
    int n;
    vector<int> parent;
    vector<int> rank;

    DisjointSet(int n): n(n), parent(n + 1), rank(n + 1){
        for(int i = 0; i <= n; i++){
            parent[i] = i;
            rank[i] = 1;
        }
    }
        
    int find(int u){
        if(u == parent[u]) 
            return u;
        else 
            return parent[u] = find(parent[u]);
    }

    void merge(int u, int v){
        u = find(u);
        v = find(v);

        if(u == v) return;

        if(rank[u] > rank[v]) swap(u, v);
        parent[u] = v;

        if(rank[u] == rank[v]) ++rank[v];
    }
 };


int main(void){
    FAST;
    cin >> n >> m;

    DisjointSet disjointSet = DisjointSet(n);

    cin >> cnt;

    //know 변수에 진실을 알고 있는 첫번째 사람이 저장됨. 이 사람이 파티에서 그짓말해도 되는지 안되는지 기준이 되어줄 것이다.
    for(int i = 0; i < cnt; i++){
        int temp;
        cin >> temp;
        if(i == 0) know = temp;
        //진실을 알고 있는 사람들을 know와 같은 분리집합에 집어 넣음
        disjointSet.merge(know, temp);
    }

    //같은 파티에 있는 사람은 같은 분리 집합에 집어 넣음
    for(int i = 0; i < m; i++){
        cin >> party_member;

        for(int j = 0; j < party_member; j++){
            int temp;
            cin >> temp;
            party[i].push_back(temp);

            disjointSet.merge(temp, party[i][0]);
        }
    }

    for(int i = 0; i < m; i++){
        bool flag = true;
    
        for(auto e: party[i]){
            if(disjointSet.find(e) == disjointSet.find(know)){
                flag = false;
                break;
            }
        }

        if(flag) ++res;
    
    }

    cout << res;

    return 0;
}