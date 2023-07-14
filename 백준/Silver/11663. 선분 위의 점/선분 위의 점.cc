#include <iostream>
#include <algorithm>


#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

int n, m;
vector<int> dot;
int my_srt;
int my_end;

bool check_min(int mid){
    return my_srt <=dot[mid];
}

bool check_max(int mid){
    return dot[mid] <= my_end;
}

int get_min(){
    int lo = -1;
    int hi = dot.size();
    
    while(lo + 1 < hi){
        int mid = (lo + hi) >> 1;
        
        if(check_min(mid)) hi = mid;
        else lo = mid;
    }
    return hi;
}

int get_max(){
    int lo = -1;
    int hi = dot.size();

    while(lo + 1 < hi){
        int mid = (lo + hi) >> 1;

        if(check_max(mid)) lo = mid;
        else hi = mid;
    }
    return lo;
}

int main(void){
    FAST;
    //freopen("input.txt", "r", stdin);
    cin >> n >> m;

    dot.resize(n);
    rep(i, 0, n) cin >> dot[i];
    
    sort(dot.begin(), dot.end());

    rep(i, 0, m){
        cin >> my_srt >> my_end;
        int max_index = get_max();
        int min_index = get_min();
        
        cout << max_index - min_index + 1 << "\n";
    }
}