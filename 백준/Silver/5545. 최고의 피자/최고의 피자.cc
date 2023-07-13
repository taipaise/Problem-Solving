#include <iostream>
#include <vector>
#include <algorithm>

#define rep(i, a, b) for (auto i = a; i < b; i++)
#define REP(i, a, b) for (auto i = a; i <= b; i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)

using namespace std;

int n;//토핑 갯수
double a, b; //도우가격, 토핑 가격
double c; // 도우 칼로리
vector<double> vec; // 토핑 칼로리
double kcal;//총 칼로리
double price; //총 가격

int main(void){
    cin >> n;
    cin >> a >> b;
    cin >> c;
    vec.resize(n);
    rep(i, 0, n) cin >> vec[i];

    sort(vec.begin(), vec.end(), greater<int>());

    kcal = c;
    price = a;
    rep(i, 0, n){
        if(((kcal + vec[i]) / (price + b)) < (kcal / price)) break;
        kcal += vec[i];
        price += b;
    }
    cout << int(kcal / price);
}   