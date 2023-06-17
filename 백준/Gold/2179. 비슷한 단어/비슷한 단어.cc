#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; i++)
#define REP(i, a, b) for(auto i = a; i <= b; i++)
using namespace std;

int n;
int maximum;
vector<pair<string, int>> strs;
vector<pair<string, int>> res;
bool flag = false;
string pre;

bool cmp(const pair<string, int>&a, const pair<string, int>&b){
    return a.second < b.second;
}
int get_prefix(string a, string b){
    int res = 0;
    rep(i, 0, min(a.length(), b.length())){
        if(a[i] == b[i]) ++res;
        else break;
    }
    return res;
}

int main(void){
    FAST;
    cin >> n;
    string str_temp;
    rep(i, 0, n){
        cin >> str_temp;
        strs.push_back({str_temp, i});
    }
    sort(strs.begin(), strs.end());

    rep(i, 0, n){
        rep(j, i + 1, n){
            if(strs[i].first == strs[j].first) continue;
            // cout << strs[i].first << " " << strs[j].first << "\n";
            int temp = get_prefix(strs[i].first, strs[j].first);
            if(temp == 0) break;
            if(maximum <= temp){
                if(maximum < temp){
                    res.clear();
                    pre = strs[i].first;
                    res.push_back(strs[i]);
                    res.push_back(strs[j]);
                    maximum = temp;
                }
                else{
                    if(pre != strs[i].first)
                        res.push_back(strs[i]);
                    res.push_back(strs[j]);
                }
            }
            else break;
        }
    }
    sort(res.begin(), res.end(), cmp);
    if(maximum){
        cout << res[0].first << "\n";
        string temp = res[0].first.substr(0, maximum);
        int temp_cnt = res[0].second;
        rep(i, 1, res.size()){
            if(res[i].first.substr(0, maximum) == temp){
                if(res[i].second == temp_cnt) continue;
                cout << res[i].first;
                break;
            }
        }

    }
    else{
        string temp = strs[0].first;
        cout << temp << "\n";
        rep(i, 1, strs.size()){
            if(temp == strs[i].first) continue;
            cout << strs[i].first;
            break;
        }
    }
}