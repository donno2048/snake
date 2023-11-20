from pathlib import Path
from re import findall

hexdata = open(0).read().replace("\n", "")

length = len(hexdata)

for div in range(int(length ** .5), 0, -1):
    if not length % div:
        break

open("README.md", "w").write(open(Path(__file__).parent.resolve() / 'template.md').read().format(size = length // 2, hex = "\n".join(findall('.' * (length // div), hexdata))))
