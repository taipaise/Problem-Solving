#include <iostream>
#include <list>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

struct Query{
    int op;
    int num;

    Query(int op, int num): op(op), num(num){}
    Query(int op): op(op), num(0) {}
    Query(): op(0), num(0) {}
};

bool flag = true;
int n, q, k;
int op;
int num;

vector<Query> vec;
list<int> lst;

int main(void){
    FAST;
    cin >> n >> q >> k;

    vec.resize(q);

    rep(i, 0, q){
        cin >> op;

        if(op == 0){
            cin >> num;
            vec[i] = Query(op, num);
        }
        else vec[i] = Query(op);
    }


    int index = 0;
    for(int i = q - 1; i >= 0; --i){
        if(vec[i].op == 1){
            index = i;
            break;
        }
    }

    rep(i, 0, index)
        if(vec[i].op == 0) lst.push_back(vec[i].num);

    lst.sort();

    rep(i, index, q){
        op = vec[i].op;

        if(op == 0){
            num = vec[i].num;
            if(flag) lst.push_front(num);
            else lst.push_back(num);
        }

        else if(op == 1){
            lst.sort();
            flag = true;
        }
        
        else flag ^= 1;
    }
     
    if(flag){
        auto it = lst.begin();
        advance(it, k - 1);
        cout << *it;
    }
    else{
        auto it = lst.rbegin();
        advance(it, k - 1);
        cout << *it;
    }

}