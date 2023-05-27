#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <cmath>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end() 
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20

using namespace std;
typedef long long ll;
typedef unsigned long long ull;

int n;
int max_num, min_num;
int mid_index;
int mode;
int mid;
double aver;
int sum = 0;

vector<pii> numbers_count;
priority_queue<int> numbers;

bool compare1(pii a, pii b){
    if(a.first == b.first){
        return a.second < b.second;
    }
    return a.first > b.first;
}

//최빈값을 알아내기 위해 등장 순서 내림 차순 정렬하기 위한 함수
bool compare2(pii a, pii b){
    return a.second > b.second;
}


int main(void){
    FAST;
    #ifndef ONLINE_JUDGE
        clock_t start = clock();
        freopen("input.txt", "r", stdin);
    #endif

    cin >> n;
    //0번 부터 인덱스 시작이므로 2를 나누면 중간값이 나옴.
    mid_index = n / 2;

    rep(i, 0, n){
        int in;
        cin >> in;
        numbers.push(in);
    }
    
    if(n == 1){
        cout << numbers.top() << "\n" << numbers.top() << "\n" << numbers.top() << "\n" << 0;
        return 0;
    }

    rep(i, 0, n){
        int num = numbers.top();
        numbers.pop();
        sum += num;
        //중앙값
        if(i == mid_index)
            mid = num;
        if(!numbers_count.empty() && numbers_count.back().second == num){
            numbers_count.back().first++;
        }
        else{
            numbers_count.push_back({1, num});
        }   
    }

    aver = floor(double(sum)/double(n) + 0.5);
    
    sort(all(numbers_count), compare1);

    if(numbers_count[0].first == numbers_count[1].first){
        mode = numbers_count[1].second;
    }
    else{
        mode = numbers_count[0].second;
    }
    sort(all(numbers_count), compare2);

    cout << aver << "\n" << mid << "\n" << mode << "\n" << numbers_count.front().second - numbers_count.back().second;
    


    #ifndef ONLINE_JUDGE
        cout << endl << "elapsed time: " << static_cast<double>(clock() - start) / CLOCKS_PER_SEC << "ms" << endl;
    #endif
}
