#include <iostream>
#include <iomanip>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

int score;
int main()
{
	cin >> score;
	
	if(score >= 90) cout << "A";
	else if(score >= 80) cout << "B";
	else if(score >= 70) cout << "C";
	else if(score >= 60) cout << "D";
	else cout << "F";
	
	return 0;
}
