#include <string>
#include <vector>
#include <iostream>
#include <algorithm>
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)


using namespace std;

bool compare(const vector<int> a, const vector<int> b){
    return a[1] < b[1];
}


int solution(vector<vector<int>> targets) {
    int answer = 0;
    sort(targets.begin(), targets.end(), compare);
    int fin = -1;
    for(auto& e: targets){
        if(e[0] < fin && e[1] >= fin) continue;
        else{
            fin = e[1];
            ++answer;
        }
    }
    return answer;
}