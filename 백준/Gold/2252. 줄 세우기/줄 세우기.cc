#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>
#include <unordered_set>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
using namespace std;

struct Student {
    int number;
    int inDegree = 0;
    unordered_set<int> nexts = {};
};

int main() {
    FAST;

    int n, m;
    queue<Student> queue;
    cin >> n >> m;
    vector<Student> students;
    
    students.resize(n + 1);
    REP(i, 1, n) {
        students[i].number = i;
    }

    rep(i, 0, m) {
        int pre, next;
        cin >> pre >> next;

        students[pre].nexts.insert(next);
        ++students[next].inDegree;
    }

    REP(i, 1, n) {
        if (students[i].inDegree == 0) {
            queue.push(students[i]);
        }
    }

    while(!queue.empty()) {
        Student student = queue.front();
        cout << student.number << " ";
        queue.pop();

        for(int next: student.nexts) {
            if(--students[next].inDegree == 0) {
                queue.push(students[next]);
            }
        }
    }
}