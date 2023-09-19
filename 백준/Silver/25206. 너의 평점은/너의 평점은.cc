#include <iostream>
#include <vector>
#include <cstdlib>
#include <algorithm>
#include <set>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;

string sub, grade;
double total_credit;
double grade_sum;
double credit;

int main(void){
    FAST;
    rep(i, 0, 20){
        cin >> sub >> credit >> grade;

        if(grade == "P") continue;

        total_credit += credit;
        double val;
        if(grade == "A+") val = 4.5;
        else if(grade == "A0") val = 4.0;
        else if(grade == "B+") val = 3.5;
        else if(grade == "B0") val = 3.0;
        else if(grade == "C+") val = 2.5;
        else if(grade == "C0") val = 2.0;
        else if(grade == "D+") val = 1.5;
        else if(grade == "D0") val = 1.0;
        else val = 0;

        grade_sum += (credit * val);
    }

    cout << grade_sum / total_credit;
}