import sys
from collections import deque
# sys.stdin = open("input.txt",'r')
# sys.stdout = open("output.txt",'w')
input = sys.stdin.readline
MIS = lambda: map(int, input().rstrip().split())

def print_arr(arr):
    print("[", end="")
    print(*arr, sep=",", end="")
    print("]")

case_cnt = int(input())
arr_len = 0

for _ in range(case_cnt):
    is_abrupt = False
    is_reverse = False

    funcs = input()
    arr_len = int(input())
    arr = input()
    arr = arr.replace('[',' ')
    arr = arr.replace(']',' ')
    arr =arr.replace(',',' ')

    arr = deque(arr.split())
    
    for func in list(funcs):
        
        if not arr:
            if func == "D":
                is_abrupt = True
                break

        if func == "R":
            is_reverse = not is_reverse
        elif func == "D":
            if is_reverse:
                arr.pop()
            else:
                arr.popleft()
    
    if is_abrupt:
        print("error")
        continue
    if is_reverse: arr.reverse()
    print_arr(arr)

    