#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define endl "\n"
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define pii pair<int, int>
#define all(v) (v).begin(), (v).end()
#define pb push_back
#define INF numeric_limits<int>::max()
#define PIV 1 << 20

using namespace std;

struct Process {
    int id;
    int time;
    int priority;

    Process(int _id, int _time, int _priority): id(_id), time(_time), priority(_priority) {}

    bool operator<(const Process& other) const {
        if (priority != other.priority)
            return priority < other.priority; // 우선순위 높은 순으로 실행
        return id > other.id; // 같은 우선순위면 ID 작은 순으로 실행
    }
};

int main() {
    FAST;

    int T, N;
    cin >> T >> N;

    priority_queue<Process> processes;

    rep(i, 0, N) {
        int id, time, priority;
        cin >> id >> time >> priority;
        processes.emplace(id, time, priority);
    }

    rep(i, 0, T) {
        if (processes.empty()) break;

        Process process = processes.top();
        processes.pop();

        cout << process.id << endl; // 실행할 프로세스 ID 출력

        process.time -= 1;
        process.priority -= 1;

        if (process.time > 0) {
            processes.emplace(process);
        }
    }

    return 0;
}