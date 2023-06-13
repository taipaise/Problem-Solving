#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <unordered_map>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
using namespace std;

int word_cnt;
int sentence_cnt;
unordered_map<string, int> words;
string sentence;
int res = 0;

void solve(string str){
    string temp = "";
    rep(i, 0, str.length()){
        if(str[i] != ' ')
            temp += str[i];
        else{
            if(temp.length() > 3) sort(temp.begin() + 1, temp.end() - 1);
            res *= words[temp];
            temp = "";
        }
    }

    if(temp != ""){
        if(temp.length() > 3) sort(temp.begin() + 1, temp.end() - 1);
        res *= words[temp];
    }
}


int main(void){
    FAST;
    // freopen("input.txt", "r", stdin);
    // freopen("output.txt", "w", stdout);
    cin >> word_cnt;
    string temp;
    rep(i, 0, word_cnt){
        cin >> temp;
        if(temp.length() > 3) sort(temp.begin() + 1, temp.end() - 1);
        if(words.find(temp) != words.end()) ++words[temp];
        else words.insert({temp, 1});
    }

    cin >> sentence_cnt;
    cin.ignore();
    rep(i, 0, sentence_cnt){
        res = 1;
        getline(cin, sentence);
        solve(sentence);
        cout << res << "\n";
    }
}