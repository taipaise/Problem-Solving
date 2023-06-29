#include <iostream>
#include <iomanip>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;

long a, b, c;
int main()
{
	cin >> a >> b >> c;
	cout << a + b + c;
	
	return 0;
}
