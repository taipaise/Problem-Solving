#include <iostream>
#include <deque>
#include <cctype>
#include <algorithm>


#define rep(i, a, b) for (auto i = a; i < b; i++)
#define REP(i, a, b) for (auto i = a; i <= b; i++)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)

using namespace std;

int case_cnt;
int arr_len;
string funcs;
string number_string;
deque<int> arr;

void print_arr(bool is_reverse)
{
    cout << "[";

    if (is_reverse)
    {
        for (int i = arr.size() - 1; i >= 0; i--)
        {
            cout << arr[i];
            if (i != 0)
                cout << ",";
        }
    }
    else
    {
        rep(i, 0, arr.size())
        {
            cout << arr[i];
            if (i != arr.size() - 1)
                cout << ",";
        }
    }
    cout << "]\n";
}

int main(void){
    FAST;
    cin >> case_cnt;

    rep(i, 0, case_cnt){
        arr.resize(0);
        cin >> funcs;
        cin >> arr_len;
        cin >> number_string;

        int temp = 0;
        bool is_reverse = false;
        bool is_abrupt = false;

        rep(j, 0, number_string.length()){
            // cout << number_string[j];
            if (isdigit(number_string[j])){
                temp *= 10;
                temp += (number_string[j] - '0');
            }
            else{
                if(temp)
                    arr.push_back(temp);
                temp = 0;
            }
        }

        rep(j, 0, funcs.length()){
            if (funcs[j] == 'R'){
                is_reverse = !is_reverse;
            }
            else{
                if (arr.empty()){
                    is_abrupt = true;
                    break;
                }

                if (is_reverse)
                    arr.pop_back();
                else
                    arr.pop_front();
            }
        }
        if(is_abrupt) cout << "error\n";
        else print_arr(is_reverse);
    }
    
}
