import sys
input = sys.stdin.readline
MIS = lambda: map(int, input().rstrip().split())

dst = int(input())
len_broken = int(input())
broken = list(MIS())

rst = abs(100 - dst)

for current_channel in range(1000001):
    for i in str(current_channel):
        if int(i) in broken:
            break
    else:
        # temp = rst
        rst = min(rst, len(str(current_channel)) + abs(current_channel - dst))
        # if temp != rst:
        #     print(current_channel, rst)

print(rst)