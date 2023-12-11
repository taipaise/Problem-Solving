#include <iostream>
#include <algorithm>
#include <string>
#include <vector>
#include <stack>
#include <queue>
#include <set>
#include <cstring>
#include <list>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

struct Line {
    int srt;
    int end;

    bool operator<(const Line &rhs) const {
        if (srt != rhs.srt)
            return srt > rhs.srt;
        return end > rhs.end;
    }
};

priority_queue<Line> pq;
Line curLine;
int n;
int res = 0;

int main(void) {
    FAST;
    cin >> n;
    int srt, end;

    rep(i, 0, n) {
        cin >> srt >> end;
        pq.push({srt, end});
    }

    curLine = pq.top();
    pq.pop();

    while(!pq.empty()){
        Line nextLine = pq.top();
        pq.pop();

        if(curLine.end >= nextLine.srt) {
            curLine = {curLine.srt, max(curLine.end, nextLine.end)};
        } else {
            res += (curLine.end - curLine.srt);
            curLine = nextLine;
        }
    }

    res += (curLine.end - curLine.srt);
    cout << res;
}