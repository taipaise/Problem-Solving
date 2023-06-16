import sys
from collections import Counter

input = sys.stdin.readline
MIS = lambda: map(int, input().rstrip().split())

n = int(input())
cards1 = list(map(int, input().split()))

counter = Counter(cards1)

m = int(input())
cards2 = list(map(int, input().split()))

for i in cards2:
    print(counter[i], end=" ")