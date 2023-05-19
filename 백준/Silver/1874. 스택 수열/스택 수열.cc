#include <iostream>
#include <stack>
#include <vector>
#include <map>

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

int n;
int sequence[100001];
vector<char> res;
stack<int> s;
map<int, int> m;
int max_num = 0;

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif
    cin >> n;
    rep(i, 0, n){
        int temp;
        cin >> temp;

        if(m.find(temp) != m.end()){
            //이미 한번 뺀적 있는 숫자는 다시 출력 불가능
            cout << "NO";
            return 0;
        }
        if(s.empty() || s.top() < temp){
            REP(j, max_num, temp){
                s.push(max_num);
                res.pb('+');
                max_num++;
            }
            m.insert({s.top(), 1});
            s.pop();
            res.pb('-');
        }
        else{
            while(s.top() >= temp){
                //map에 사용했음을 표시
                m.insert({s.top(), 1});
                s.pop();
                res.pb('-');
            }
        }
    }
    rep(i, 1, res.size()){
        cout << res[i] << endl;
    }
    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
