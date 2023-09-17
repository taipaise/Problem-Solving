#include <iostream>
#include <algorithm>
#include <vector>
#include <cstring>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;
struct Person{
    int a;
    int b;

    bool operator<(const Person& rhs)const{
        return a < rhs.a;
    }
};

int tc;
int n;
vector<Person> vec;



int main(void){
    cin >> tc;

    rep(t, 0, tc){
        cin >> n;
        vec.clear();
        vec.resize(n);

        rep(i, 0, n){
            int a, b;
            cin >> a >> b;
            vec[i] = {a, b};
        }

        sort(vec.begin(), vec.end());

        int minB = vec[0].b;
        int cnt = 1;

        rep(i, 1, n){
            if(vec[i].b < minB){
                ++cnt;
                minB = vec[i].b;
            }
        }

        cout << cnt << "\n";
    }
}