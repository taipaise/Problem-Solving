#include <iostream>
#include <deque>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

int n, m;
int res = 0;
deque<int> num;

//원하는 수가 앞쪽에 있을때는 왼쪽으로 회전
void rotate_left(){
    if(!num.empty()){
        int temp = num.front();
        num.pop_front();
        num.push_back(temp);
    }
    return;
}

//원하는 수가 뒤쪽에 있을때는 오른쪽으로 회전
void rotate_right(){
    if(!num.empty()){
        int temp = num.back();
        num.pop_back();
        num.push_front(temp);
    }
    return;
}

//원하는 숫자가 몇번째 Index인지 확인
int get_index(int seq){
    int index = 0;
    for(auto& e : num){
        if(e == seq) return index;
        else ++index;
    }
    return -1;
}

int main(void){
    cin >> n >> m;
    bool flag = false;

    REP(i, 1, n) num.push_back(i);

    rep(i, 0, m){
        int seq;
        cin >> seq;

        //원하는 수가 앞쪽에 있을때는 flag를 true로
        if(get_index(seq) <= (num.size() / 2)) flag = true;
        else flag = false;
        
        while(num.front() != seq){
            if(flag) rotate_left();
            else rotate_right();
            ++res;
        }
        num.pop_front();
    }
    cout << res;
}
