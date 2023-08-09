#include <iostream>
#include <vector>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
vector<int> vec(4);
string str;
bool res = true;


bool is_valid(int index){
    if(vec[index -1] < vec[index]) return false;

    int temp = vec[0];
    REP(i, 1, index - 1){
        if(temp != vec[i]) return false;
    }
    return true;
}


int main(void){ 
    cin >> str;

    int len = str.length();
    rep(i, 0, len){
        if(str[i] == 'w'){
            if(vec[1] && vec[0] > vec[3]){
                res = false;
                break;
            }
            ++vec[0];
        }
        else if(str[i] == 'o'){
            ++vec[1];
            if(!is_valid(1)){
                res = false;
                break;
            }
        }
        else if(str[i] == 'l'){
            ++vec[2];
            if(!is_valid(2)){
                res = false;
                break;
            }
        }
        else{
            ++vec[3];
            if(!is_valid(3)){
                res = false;
                break;
            }

            if(vec[0] == vec[3])
                rep(j, 0, 4) vec[j] = 0;
        }
    }

    if(vec[0] != vec[3]) res = false;
    cout << res;

}