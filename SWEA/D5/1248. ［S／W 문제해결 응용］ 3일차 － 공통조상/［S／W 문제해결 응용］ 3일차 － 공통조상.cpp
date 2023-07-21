#include <iostream>
#include <vector>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
struct Node{
    int parent;
    int left;
    int right;
    // Node(int p, int l, int r): p(p), left(l), right(r){}
};

int tc;
int v, e, target1, target2;
int parent, child;
int in_common;
int s;
vector<Node> tree;

void add_node(int p, int c){
    if(tree[p].left) tree[p].right = c;
    else tree[p].left = c;

    tree[c].parent = p;
}

int get_s(int cur){
    if(cur == 0) return 0;
    if(tree[cur].left == 0) return 1;

    int left_size = get_s(tree[cur].left);
    int right_size = get_s(tree[cur].right);

    return left_size + right_size + 1;
}

int find_common(int tar1, int tar2){
    vector<bool> visited(0);
    visited.resize(v + 1);

    while(tar1){
        visited[tar1] = true;
        tar1 = tree[tar1].parent;
    }

    while(tar2){
        if(visited[tar2]) return tar2;
        visited[tar2] = true;
        tar2 = tree[tar2].parent;
    }

    return 1;
}

int main(void){
    FAST;
   // freopen("input.txt", "r", stdin);
    cin >> tc;
    REP(t, 1, tc){
        cin >> v >> e >> target1 >> target2;
        //트리 초기화
        tree.clear();
        tree.resize(v + 1);

        //간선 입력
        rep(i, 0, e){
            cin >> parent >> child;
            add_node(parent, child);
        }

        in_common = find_common(target1, target2);
        s = get_s(in_common);

        cout << "#" << t << " ";
        cout << in_common << " " << s << "\n";
    }
}