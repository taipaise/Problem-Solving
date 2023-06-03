#include <iostream>
#include <vector>
#include <set>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

int n, m;
int cnt;
int res = 0;
int know = 0;
int party_member;
set<int> party[50];

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
    for(int i = 0; i < cnt; i++){
        int temp;
        cin >> temp;
        if(i == 0) know = temp;
        disjointSet.merge(know, temp);
    }

    for(int i = 0; i < m; i++){
        cin >> party_member;
        int first_member;

        for(int j = 0; j < party_member; j++){
            int temp;
            cin >> temp;
            party[i].insert(temp);
            if(j == 0) first_member = temp;
            disjointSet.merge(temp, first_member);
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