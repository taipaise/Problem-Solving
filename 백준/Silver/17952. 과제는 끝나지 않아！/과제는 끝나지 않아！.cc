#include <iostream>
#include <vector>
#include <stack>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

struct Subject{
    int score;
    int time;
    int done;

    Subject(int s, int t):score(s), time(t){
        done = 1;
    }
};

int n;
int score = 0;
int flag;
stack<Subject> subjects;
// vector<Subject> subjects;
int main(void){
    FAST;
    cin >> n;
    
    rep(i, 0, n){
        cin >> flag;
        if(flag){
            int s, t;
            cin >> s >> t;
            if(t == 1){
                score += s;
                continue;
            }
            subjects.push(Subject(s, t));
        }
        else{
            if(subjects.empty()) continue;

            if(++subjects.top().done == subjects.top().time){
                score += subjects.top().score;
                subjects.pop();
            }
        }
    }
    cout << score;

}