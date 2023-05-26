#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <set>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end() 
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20
#define MAX 1000001

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

int n;
//우선 순위 큐에는 현재 이용하는 사람들의 정보가 <끝나는 시간, 좌석 번호> 형태로 들어간다.
priority_queue<pii, vector<pii>, greater<pii>> cur_using;

set<pii> t;

//<시작시간, 끝나는 시간> 기록하는 벡터
vector<pii> person;

//좌석별 몇명인지 기록하는 배열
int computer[MAX];

bool compare(const pair<int, int> &a, const pair<int, int> &b)
{
    return a.second < b.second;
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif

    cin >> n;
    rep(i, 0, n){
        int start, end;
        cin >> start >> end;
        person.pb({start, end});
    }
    //시작 시간 기준 오름차순 정렬. 만약 시작 시간 같으면 끝나는 시간 기준 오름차순 정렬한다.
    sort(person.begin(), person.end());

    //초기 좌석 번호는 1번
    int num = 1;
    REP(i, 1, n){
        //큐가 비어있다는 말은 현재 사용하는 사람이 없다는 뜻. 따라서 1번 자리에 사람이 들어간다.
        // cout << "입력: " << person[i - 1].first << " " << person[i - 1].second << endl;
        if(cur_using.empty() && t.empty()){    
            // cout << "큐가 비어있는 상태\n";
            // cout << "좌석 번호 1번에 집어 넣는다.\n";
            cur_using.push({person[i - 1].second, 1});
            ++computer[1];
        }
        else{
            //현재 이용중인 사람의 종료 시간보다 다음 사람의 시작 시간이 큰 경우 
            
            // cout << cur_using.top().first << endl;
            while(!cur_using.empty() && person[i - 1].first > cur_using.top().first){
                t.insert({cur_using.top().second, cur_using.top().first});
                cur_using.pop();
            }

            
            if(!t.empty()){
                //이용중인 사람 종료
                // cout << "입력 가능 하므로 " << temp.second << "자리에 추가한다.\n"; 
                //해당 좌석에 새로운 사람이 들어가기 때문에 값을 증가 시킨다.

                // cout <<"좌석번호 제일 낮은 것은: " <<t.begin()->first << "시간은: " << t.begin()->second << endl;
                ++computer[t.begin() -> first];
                cur_using.push({person[i - 1].second, t.begin()-> first});
                t.erase(t.begin());
            }
            //새로운 자리를 마련해야 함
            else{
                ++num;
                ++computer[num];
                // cout << "입력 불가능 하므로 " << num << "자리에 추가한다.\n"; 
                cur_using.push({person[i - 1].second, num});                
            }
        }
    }

    cout << num << "\n";

    REP(i, 1, num){
        cout << computer[i] << " ";
    }

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
