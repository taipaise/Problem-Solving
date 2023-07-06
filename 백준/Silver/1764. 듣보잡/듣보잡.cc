#include <iostream>
#include <vector>
#include <set>
#include <algorithm>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

int n, m;
set<string> s;
vector<string> vec;

int main()
{
	cin >> n >> m;
	string temp;
	rep(i, 0, n){
		cin >> temp;
		s.insert(temp);
	}

	rep(i, 0, m){
		cin >> temp;
		if(s.find(temp) != s.end()) vec.push_back(temp);
	}
	sort(vec.begin(), vec.end());
	cout << vec.size() << "\n";
	rep(i, 0, vec.size()){
		cout << vec[i] << "\n";
	}

}
