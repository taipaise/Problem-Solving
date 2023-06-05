import sys

input = sys.stdin.readline
MIS = lambda: map(int, input().rstrip().split())

words = set()
cnt = int(input())

for i in range(cnt):
    word = input().rstrip()
    words.add(word)

words_list = list(words)
words_list.sort(key=lambda x: (len(x), x))

for item in words_list:
    print(item)