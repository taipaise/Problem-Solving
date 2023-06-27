#include <iostream>
#include <iomanip>
#include <string>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define endl "\n"

using namespace std;


int main()
{
	cout << "SHIP NAME      CLASS          DEPLOYMENT IN SERVICE" << endl;
	cout << "N2 Bomber      Heavy Fighter  Limited    21        " << endl;	
	cout << "J-Type 327     Light Combat   Unlimited  1         " << endl;
	cout << "NX Cruiser     Medium Fighter Limited    18        " << endl;
	cout << "N1 Starfighter Medium Fighter Unlimited  25        " << endl;
	cout << "Royal Cruiser  Light Combat   Limited    4        " << endl;
	
	return 0;
}
