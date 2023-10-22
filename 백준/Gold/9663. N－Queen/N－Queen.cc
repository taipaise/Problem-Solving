#include <iostream>
#include <vector>
#include <algorithm>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define INF numeric_limits<int>::max()

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

vector<int> chess;
int n;
int res = 0;

int promising(int k){
	rep(i, 0, k){
		//칼럼 값 중복 확인
		if (chess[i] == chess[k])
		 	return 0;
		//대각선 확인
		if (abs(chess[i] - chess[k]) == k - i)
			return 0;
	}
    return 1;
}

void n_queen(int index, int cnt){
	if (cnt == n) {
        ++res;
        return;
    }

	rep(i, 0, n){
        chess[index] = i;
		if (promising(index))
			n_queen(index + 1, cnt + 1);
	}
}

int main(){
    cin >> n;
	chess.resize(n);
	n_queen(0, 0);
	cout << res;
    return 0;
}
