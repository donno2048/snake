from re import findall

hexdata = open("snake.hex").read().replace("\n", "")

length = len(hexdata)

for div in range(int(length ** .5), 0, -1):
    if not length % div:
        break

open("../README.md", "w").write(open('template.md').read().format(size = length // 2, hex = "\n".join(findall('.' * (length // div), hexdata))))
