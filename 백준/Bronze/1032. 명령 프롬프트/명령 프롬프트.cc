#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)

using namespace std;

string str;
int n;

int main(void){
	cin >> n;
	cin >> str;
	rep(i, 1, n){
		string temp;
		cin >> temp;
		
		rep(j, 0, str.length()){
			if(str[j] != temp[j]){
				if(str[j] == '?') continue;
				else str[j] = '?';
			}
		}
	}

	cout << str;
}