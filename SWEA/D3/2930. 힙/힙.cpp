#include <iostream>
#include <cassert>
#include <algorithm>

#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL);cout.tie(NULL)
#define rep(i, a, b) for(int i = a; i < b; i++)
#define REP(i, a, b) for(int i = a; i <= b; i++)

using namespace std;

struct MaxHeap{
    #define MAX_SIZE int(1e5)
    #define parent (i >> 1)
    #define left (i << 1)
    #define right (i << 1 | 1)
    
    int size;
    int data[MAX_SIZE + 1];

    int top(){
        //size가 0일 경우 assert error
        assert(size != 0);
        return data[1];
    }

    void push(int x){
        data[++size] = x;
        for(int i = size; parent != 0 && data[parent] < data[i]; i >>= 1)
            swap(data[parent], data[i]);
    }

    void pop(){
        if(size == 0){
            cout << -1 <<" ";
            return;
        }

        cout << top() << " ";
        data[1] = data[size--];
        for(int i = 1; left <= size;){
            if(left == size || data[left] > data[right]){
                if(data[i] < data[left]){
                swap(data[i], data[left]);
                i = left;
                }
                else break;    
            }
            else{
                if(data[i] < data[right]){
                swap(data[i], data[right]);
                i = right;
                }
                else break;    
            }   
        }
    }
};

int tc;
int n;
int op, num;

int main(void){
    FAST;
 //   freopen("input.txt", "r", stdin);
    cin >> tc;

    REP(t, 1, tc){
        cin >> n;
        MaxHeap heap = MaxHeap();

        cout << "#" << t << " ";
        rep(i, 0, n){
            cin >> op;

            if(op == 1){
                cin >> num;
                heap.push(num);
            }
            else heap.pop();
        }
        cout << "\n";
    }
}
