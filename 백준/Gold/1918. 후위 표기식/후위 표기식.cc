#include <iostream>
#include <vector>
#define rep(i, a, b) for(auto i = a; i < b; ++i)
#define REP(i, a, b) for(auto i = a; i <= b; ++i)
#define FAST ios_base::sync_with_stdio(false); cin.tie(NULL); cout.tie(NULL)

using namespace std;

enum Operator {
    Addition, Substraction, Multiplication, Division, Open, Close
};

const vector<int> priority = {0, 0, 1, 1, 2, 2};
const vector<char> operatorString = {'+', '-', '*', '/', '(', ')'};

int getOperatorIndex(char c) {
    switch (c) {
        case '+':
            return Addition;
        case '-':
            return Substraction;
        case '*':
            return Multiplication;
        case '/':
            return Division;
        case '(':
            return Open;
        case ')':
            return Close;
        default:
            return -1;
    }
}

int main() {
    FAST;
    string infix;
    vector<Operator> stack;
    string res = "";

    cin >> infix;

    rep(i, 0, infix.size()) {
        int curOp = getOperatorIndex(infix[i]);

        // 피연산자 그대로 추가
        if (curOp == -1) {
            res += infix[i];
            continue;
        }

        // 닫는 연산자라면
        if (curOp == Close) {
            while (true) {
                Operator op = stack.back();
                stack.pop_back();

                if (op == Open) { break; }

                res += operatorString[op];
            }
            continue;
        }

        // 현재 연산자보다 우선 순위가 크거나 같은걸 뺀다.
        while (!stack.empty()) {
            Operator preOp = stack.back();
            
            if (preOp == Open) { break; }
            if (priority[curOp] > priority[preOp]) { break; }
            stack.pop_back();

            res += operatorString[preOp];
        }

        stack.push_back((Operator)curOp);
    }

    // 스택에 남아있는 연산자들을 결과에 추가
    while (!stack.empty()) {
        Operator op = stack.back();
        stack.pop_back();

        res += operatorString[op];
    }

    cout << res;
}