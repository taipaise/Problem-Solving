#include <iostream>
#include <algorithm>
#include <vector>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
using namespace std;

int n, m, block;
vector<int> map;

int hi = 256;
int lo = 0;
int res;
int timee = 500 * 500 * 256 * 2;



int main(void){
    cin >> n >> m >> block;
    map.resize(n * m);

    for(int i = 0; i < (n * m); i++){
        cin >> map[i];
    }

    sort(map.begin(), map.end());
    lo = map[0];
    hi = map.back();

    for(int i = lo; i <= hi; i++){
        //임시로 시간을 저장
        int temp = 0;
        int b = block;

        for(int j = 0; j < map.size(); j++){
            if(map[j] == i) continue;
            if(map[j] > i){
                b += (map[j] - i);
                temp += ((map[j] - i) << 1);
            }
            else{
                b -= (i - map[j]);
                temp += (i - map[j]);
            }
        }
        if(b < 0) continue;
        if(temp <= timee){
            timee = temp;
            res = i;
        } 
    }
    cout << timee << " " << res;
    
    return 0;
} 