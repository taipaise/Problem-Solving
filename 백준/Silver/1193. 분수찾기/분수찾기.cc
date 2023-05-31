#include <iostream>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;
typedef long long ll;

ll n;

ll get_num(){
    ll lo = 1;
    ll hi = n;

    while(lo <= hi){
        ll mid = (lo + hi) >> 1;
    
        if(mid * (mid + 1) / 2 < n)
            lo = mid + 1;
        else
            hi = mid - 1;
    }
    return lo;
}


int main(){
    cin >> n;
    
    ll order = get_num();

    if(order == 1){
        cout << "1/1";
        return 0;
    }
    
    ll child, parent;
    ll temp = (order - 1) * order / 2;
    temp = n - temp;
    
    //짝수
    if(order % 2 == 0){
        child = temp;
        parent = order - temp + 1;    
    }
    //홀수
    else{
        child = order - temp + 1;    
        parent = temp;
    }
    cout << child << "/" << parent;
}