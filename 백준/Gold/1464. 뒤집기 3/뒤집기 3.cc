#include <iostream>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

string str;
//string을 유사 deque으로 사용할것임
string res = "";
bool is_reverse = false;

int main(void){
    FAST;
    cin >> str;
    //일단 문자열의 첫 글자를 덱에 넣어준다.
    res.push_back(str[0]);

    //문자열을 하나씩 넣어준다. 덱의 front 보다 작거나 같으면 앞에, 크면 뒤에 push한다.
    rep(i, 1, str.length()){
        int res_front = int(res[0]);
        int temp = int(str[i]);

        if(res_front >= temp) res = str[i] + res;
        else res.push_back(str[i]);
    }

    cout << res;
}