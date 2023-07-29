#include <iostream>
using namespace std;

int main() {
	int n, f;
	int res = 0;
	cin >> n >> f;
	
	n /= 100;
	n *= 100;
	
	while((n + res) % f != 0 && res < 100) res ++;
	
	if(res < 10) printf("0%d", res);
	else printf("%d", res);
	
}