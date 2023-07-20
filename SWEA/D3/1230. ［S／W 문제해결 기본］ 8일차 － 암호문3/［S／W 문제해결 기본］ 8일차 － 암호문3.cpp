#include <iostream>
#include <string>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)
using namespace std;

vector<string> vec;
int n, m;
char c;
int x, y, s;

void insert_pw(int index, int cnt){
    string str;
    rep(i, 0, cnt){
        cin >> str;
        vec.insert(vec.begin() + index + i, str);
    }
}

void delete_pw(int index, int cnt){
    vec.erase(vec.begin() + index, vec.begin() + index + cnt);
}

void add_pw(int cnt){
    string str;
    rep(i, 0, cnt){
        cin >> str;
        vec.push_back(str);
    }
}

int main(void){
    REP(tc, 1, 10){
        vec.clear();
        cin >> n;
        vec.resize(n);
        rep(i, 0, n) cin >> vec[i];


        cin >> m;
        rep(i, 0, m){
            cin >> c;

            if(c == 'I'){
                cin >> x >> y;
                insert_pw(x, y);
            }
            else if(c == 'D'){
                cin >> x >> y;
                delete_pw(x, y);
            }
            else{
                cin >> y;
                add_pw(y);
            }
        }

        cout << "#" << tc << " ";
        rep(i, 0, 10){
            cout << vec[i] << " ";
        }
        cout << "\n";
    }
}