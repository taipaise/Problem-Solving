#include <iostream>
#include <stack>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

struct POS{
    int x;
    int y;
};

int n;
int res = 0;
stack<POS> g;

//높으면 스택에 그냥 넣는다.
// 낮으면 같은 높이가 나올때까지 스택에서 빼야함
int main(void){
    cin >> n;
    int x, y;

    rep(i, 0, n){
        cin >> x >> y;
        if(g.empty()) g.push({x, y});
        else{
            int cur_x = g.top().x;
            int cur_y = g.top().y;

            if(cur_y < y) g.push({x, y});
            else{
                while(!g.empty()){
                    if(g.top().y >= y){
                        if(g.top().y > y) ++res;
                        g.pop();
                    }
                    else break;
                }
                g.push({x, y});
            }
        }
    }
    while(!g.empty()){
        if(g.top().y > 0){
            ++res;
            g.pop();
        }
        else break;
    }
    cout << res;

}