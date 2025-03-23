#include <iostream>
#include <vector>
#include <algorithm>
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)
#define endl "\n"


using namespace std;

struct Edge {
    int start;
    int end;

    bool operator<(const Edge rhs) const {
        if (start != rhs.start) {
            return start < rhs.start;
        }
        return end < rhs.end;
    }
};

int main() {
    FAST;
    
    int n;
    int res = 0;
    vector<Edge> edges;

    cin >> n;
    
    edges.resize(n);

    for (int i = 0; i < n; i++) {
        int start, end;
        cin >> start >> end;
        Edge edge = {start, end};
        edges[i] = edge;
    }

    sort(edges.begin(), edges.end());

    int start, end;
    Edge edge = edges[0];
    start = edge.start;
    end = edge.end;

    for(int i = 1; i < n; i++) {
        int curStart = edges[i].start;
        int curEnd = edges[i].end;

        if (curStart <= end) {
            end = max(end, curEnd);
        } else {
            res += end - start;
            start = curStart;
            end = curEnd;
        }
    }

    res += (end - start);
    cout << res;
    return 0;
}