#include <iostream>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int n;
string str;
int my_index;
int my_left, my_right;
vector<string> vec;

bool is_operator(string str){
    if(str == "+") return true;
    if(str == "-") return true;
    if(str == "/") return true;
    if(str == "*") return true;

    return false;
}

bool is_valid(){
    REP(i, 1, n){
        //자식이 있는 경우 (리프 노드가 아닌 경우)
        if(i * 2 <= n){
            if(!is_operator(vec[i])) return false;
        }
        //리프 노드인 경우
        else{
            if(is_operator(vec[i])) return false;
        }
    }

    return true;
}

int main(void){
    REP(tc, 1, 10){
        vec.clear();
        cin >> n;
        vec.resize(n + 1);

        rep(i, 0, n){
            cin >> my_index >> str;

            //왼쪽 자식이 있는 경우
            if(my_index * 2 <= n) cin >> my_left;
            //오른쪽 자식이 있는 경우
            if(my_index * 2 + 1 <= n) cin >> my_right;

            vec[my_index] = str;
        }

        cout << "#" << tc << " ";
        if(is_valid()) cout << 1 << "\n";
        else cout << 0 << "\n";
    }
}