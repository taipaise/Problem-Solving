#include <iostream>
#include <vector>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
struct Node{
    string data;
    int left;
    int right;
};

int n;
int my_index, my_left, my_right;
string str;
vector<Node> vec;

bool is_operator(string str){
    if(str == "+") return true;
    if(str == "-") return true;
    if(str == "/") return true;
    if(str == "*") return true;
    return false;
}

int cal(int index){
    if(vec[index].data == "+"){
        return cal(vec[index].left) + cal(vec[index].right);
    }
    else if(vec[index].data == "-"){
        return cal(vec[index].left) - cal(vec[index].right);
    }
    else if(vec[index].data == "*"){
        return cal(vec[index].left) * cal(vec[index].right);
    }
    else if(vec[index].data == "/"){
        return cal(vec[index].left) / cal(vec[index].right);
    }
    else{
        return stod(vec[index].data);
    }
}


int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    REP(tc, 1, 10){
        cin >> n;

        vec.clear();
        vec.resize(1001);

        rep(i, 0, n){
            cin >> my_index >> str;

            if(is_operator(str)) cin >> my_left >> my_right;
            else{
                my_left = 0;
                my_right = 0;
            }
            vec[my_index] = {str, my_left, my_right};
        }

        cout << "#" << tc << " " << cal(1) << "\n";
    }
}