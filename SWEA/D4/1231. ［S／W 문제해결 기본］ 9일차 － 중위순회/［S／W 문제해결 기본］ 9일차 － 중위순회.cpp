#include <iostream>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

vector<char> vec;
int n;
int my_index;
int my_left, my_right;
char c;


bool is_valid(int my_index){
    return (0 < my_index && my_index <= n);
}

void in_order(int my_index){
    if(!is_valid(my_index))return;
    
    in_order(my_index * 2);
    cout << vec[my_index];
    in_order(my_index * 2 + 1);
}


int main(void){
    REP(tc, 1, 10){
        vec.clear();
        cin >> n;
        vec.resize(n + 1);

        cin.ignore();
        rep(i, 0, n){
            cin >> my_index >> c;            
            //왼쪽 자식이 있는 경우
            if(my_index * 2 <= n) cin >> my_left;
            //오른쪽 자식이 있는 경우
            if(my_index * 2 + 1 <= n) cin >> my_right;

            vec[my_index] = c;
        }
        cout << "#" << tc << " ";
        in_order(1);
        cout << "\n";

    }
}