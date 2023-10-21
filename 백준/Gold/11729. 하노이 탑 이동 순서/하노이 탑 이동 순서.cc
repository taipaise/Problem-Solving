#include <iostream>
#include <string>
#include <cmath>

#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;
int n;

void move(int srt, int end){
    cout << srt << " " << end << "\n";
}

void hanoi(int num, int srt, int sub, int end){
    if (num == 1){
        move(srt, end);
        return;
    }

    hanoi(num - 1, srt, end, sub);
    move(srt, end);
    hanoi(num - 1, sub, srt, end);
}

int main(void){
    cin >> n;
    cout << int(pow(2, n)) - 1 << "\n";
    hanoi(n, 1, 2, 3);
}