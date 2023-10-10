#include <iostream>
#include <vector>
#include <queue>
#include <cstdlib>
#include <algorithm>
#include <set>
#include <unordered_map>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
using namespace std;

struct Serial{
    string serial;
    int num;

    bool operator<(const Serial& rhs )const {
        if(rhs.serial.length() != serial.length())
            return serial.length() < rhs.serial.length();
        if(num != rhs.num)
            return num < rhs.num;
        return  serial < rhs.serial;
    }
};

int n;
vector<Serial> vec;


int getNum(string str){
    int sum = 0;

    rep(i, 0, str.length()){
        if(!(str[i] >= '0' && str[i] <= '9')) continue;
        sum += (str[i] - '0');
    }

    return sum;
}

int main(void){
    FAST;
    cin >> n;
    vec.resize(n);

    string str;
    rep(i, 0, n){
        cin >> str;
        vec[i] = {str, getNum(str)};
    }

    sort(vec.begin(), vec.end());

    rep(i, 0, n) cout << vec[i].serial << "\n";
}