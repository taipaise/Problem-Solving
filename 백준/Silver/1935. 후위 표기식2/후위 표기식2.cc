#include <iostream>
#include <stack>
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
string str;
stack<double> s;
map<char, double> m;

char srt = 65;

bool is_number(char c){
    return ('A' <= c && c <= 'Z');
}

double op(double a, double b, char c){
    if(c == '+') return a + b;
    else if(c == '-') return a - b;
    else if(c == '*') return a * b;
    else return a / b;
}

int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif

    cin >> n;
    cin >> str;
    // cout << str<< endl;

    rep(i, 0, n){
        double temp;
        cin >> temp;
        m.insert({srt++, temp});
    }

    rep(i, 0, str.length()){
        if(is_number(str[i])){
            //숫자면 스택에 넣어줌
            s.push(m[str[i]]);
            // cout << m[str[i]] << endl;
        }
        else{
            //숫자가 아니면 스택에서 두개를 꺼낸다.
            double a, b, res;
            b = s.top();
            s.pop();
            a = s.top();
            s.pop();
            //계산을 해주고
            res = op(a, b, str[i]);
            //다시 넣는다.
            s.push(res);
        }
    }
    cout << fixed;
    cout.precision(2);
    cout << s.top();

    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
