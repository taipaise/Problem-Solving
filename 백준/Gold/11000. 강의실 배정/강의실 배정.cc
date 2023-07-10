#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i,a,b) for(auto i = a; i <= b; i++)
using namespace std;

struct T{
    int my_srt;
    int my_end;

    bool operator<(const T& rhs)const{
        if(my_srt != rhs.my_srt) return my_srt < rhs.my_srt;
        return my_end < rhs.my_end;
    }
};

int n;
int res;

vector<T> vec;
priority_queue<int, vector<int>, greater<int>>pq;

int main(void){
    int s, e;
    cin >> n;
    rep(i, 0, n){
        cin >> s >> e;
        vec.push_back({s, e});
    }

    sort(vec.begin(), vec.end());

    pq.push(vec[0].my_end);

    rep(i, 1, n){
        pq.push(vec[i].my_end);
        //끝나는 시간이 시작시간보다 작으면 가능
        if(pq.top() <= vec[i].my_srt) pq.pop();
    }
    cout << pq.size();
}