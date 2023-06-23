#include <iostream>
#include <vector>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

int n, k;
int max_val = 0;
vector<string> strs;
unsigned long long char_set = 0;

int get_index(char c){
    return c - 'a';
}

//bit 켜져있나 확인하는 함수
bool is_bit_on(char c){
    int index = get_index(c);
    return(char_set & (1 << index)) > 0;
}

//bit 켜는 함수
void set_bit(char c){
    int index = get_index(c);
    char_set |= (1 << index);
}

//bit 끄는 함수
void clear_bit(char c){
    int index = get_index(c);
    char_set &= ~(1 << index);
}

//읽을 수 있는 단어 갯수 확인
void check_cnt(){
    int res = 0;
    rep(i, 0, strs.size()){
        bool can_read = true;
        rep(j, 0, strs[i].size()){
            if(!is_bit_on(strs[i][j])){
                can_read = false;
                break;
            }
        }
        if (can_read) ++res;
    }
    max_val = max(max_val, res);
}

//재귀적으로 가르칠 단어를 K개 만큼 정한다.
void solve(int cnt, char search_start){
    if(cnt == k){
        check_cnt();
        return;
    }

    for(char i = search_start; i <= 'z'; i++){
        //필수로 배워야 하는 단어는 이미 추가 되었으므로 건너뜀
        if(i == 'a') continue;
        if(i == 'n') continue;
        if(i == 't') continue;
        if(i == 'i') continue;
        if(i == 'c') continue;

        if(is_bit_on(i)) continue;
        set_bit(i);
        solve(cnt + 1, i + 1);
        clear_bit(i);
    }
}

int main(void){
    FAST;
    cin >> n >> k;

    //a, n, t, i ,c 5글자는 꼭 배워야 함.
    if(k < 5){
        cout << 0;
        return 0;
    }

    set_bit('a');
    set_bit('n');
    set_bit('t');
    set_bit('i');
    set_bit('c');

    //문자열 입력 받음
    rep(i, 0, n){
        string temp;
        cin >> temp;
        strs.push_back(temp);
    }

    solve(5, 'b');
    cout << max_val;
}