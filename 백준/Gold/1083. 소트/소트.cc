#include <iostream>
#include <vector>
#include <set>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

struct Info{
    int index;
    int value;
};

int n, s;
int curIndex = 0;
vector<int> vec;

Info findMax(int srt, int moveCnt){
    int maxVal = 0;
    int index = srt;

    REP(i, 1, moveCnt){
        if(srt + i == vec.size()) break;
        if(vec[srt + i] < maxVal) continue;
        maxVal = vec[srt + i];
        index = srt + i;
    }

    return {index, maxVal};
}

void bubble(int srt, int dest){
    int cnt = 0;

    for(int i = srt; i > dest; --i) swap(vec[i], vec[i - 1]);
}

void printVec(){
    rep(i, 0, vec.size()) cout << vec[i] << " ";
}

int main(void){
    FAST;

    cin >> n;
    vec.resize(n);
    rep(i, 0, n) cin >> vec[i];
    cin >> s;

    while(curIndex < vec.size() && s > 0){
        Info temp = findMax(curIndex, s);
        if(temp.value > vec[curIndex]){
            bubble(temp.index, curIndex);
            s -= (temp.index - curIndex);
        }
        ++curIndex;

    }
    printVec();
}
