#include <iostream>
#include <algorithm>
#include <string>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define endl "\n"

using namespace std;

long long add_serial(string str){
    long long res = 0;
    rep(i, 0, str.length()){
        if(str[i] >= '0' && str[i] <= '9') res += (str[i] - '0');
    }
    return res;
}

bool compare(string str1, string str2){
    if(str1.length() != str2.length()) return str1.length() < str2.length();
    long long sum1 = add_serial(str1);
    long long sum2 = add_serial(str2);

    if(sum1 != sum2) return sum1 < sum2;
    return str1 < str2;
}

int n;

int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    cin >> n;
    vector<string> serials(n);

    rep(i, 0, n){
        cin >> serials[i];
    }

    sort(serials.begin(), serials.end(), compare);

    for(auto& e : serials) cout << e << endl;

    return 0;
}