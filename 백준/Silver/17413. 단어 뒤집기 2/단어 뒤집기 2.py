MIS = lambda: map(int, input().rstrip().split())

str= input()
list(str)
buffer = list()

is_tag_finish = True


def print_reverse():
    global buffer
    buffer.reverse()
    print("".join(buffer), end="")
    buffer = []

for item in str:
    if item == '<':
        print_reverse()
        is_tag_finish = False
        
    elif item == '>':
        is_tag_finish = True
        print(item, end="")
        continue

    if not is_tag_finish:
        print(item, end="")
    else:
        if item == ' ':
            print_reverse()
            print(' ', end='')
        else:
            buffer.append(item)

print_reverse()


