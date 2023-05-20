#include <iostream>
#include <vector>
#include <map>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end() 
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

struct Student{
    int no;
    int time;//어느 시점에 들어왔는지
    int cnt; //추천 받은 횟수

    bool operator<(const Student& rhs)const{
        if(cnt == rhs.cnt) return time < rhs.time;
        else return cnt < rhs.cnt;
    }
};

vector<Student> frame;
bool is_exist[101];
int n, total;
vector<int> res;

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n >> total;

    rep(i, 0, total){
        int temp;
        cin >> temp;

        if(is_exist[temp]){
            rep(i, 0, frame.size()){
                if(frame[i].no == temp){
                    // cout << temp << "증가 \n";
                    frame[i].cnt++;
                    // cout << temp << " " <<  frame[i].cnt <<"\n";
                    break;
                }
            }
        }
        else{
            if(frame.size() == n){
                sort(all(frame));
                // cout <<frame.begin() -> no<< " 삭제\n";
                is_exist[frame.begin() -> no] = false;
                frame.erase(frame.begin());
            }
            // cout << temp << "추가\n";
            is_exist[temp] = true;
            frame.push_back({temp, i, 1});
        }
    }

    for(auto i : frame){
        res.pb(i.no);
    }
    sort(all(res));
    
    for(auto i : res){
        cout << i << " ";
    }

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
