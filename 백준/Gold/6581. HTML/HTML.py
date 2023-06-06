import sys
# sys.stdin = open("input.txt",'r')
# sys.stdout = open("output.txt",'w')
# input = sys.stdin.readline
# # MIS = lambda: map(int, input().rstrip().split())

string = ""
for temp in sys.stdin:
    string += temp

buffer = ""

cnt = 0
string = string.replace('\n', ' ')
str_list = string.split()

for word in str_list:
    if word == '<br>':
        if(len(buffer) > 0):
            print(buffer.strip(), end="")
            buffer = ""
        print('\n', end="")
    elif word == '<hr>':
        line = '-' * 80
        if(len(buffer) > 0):
            print(buffer.strip())
            buffer = ""
        print(line)
    else:
        if len(buffer) + len(word) <= 80:  
            buffer += (word + ' ')
        else:
            print(buffer.strip())
            buffer = ""
            buffer += (word + ' ')

if(len(buffer) > 0):
            print(buffer.strip())
            buffer = ""            
