from pathlib import Path
from re import findall

hexdata = open(0).read().replace("\n", "")

length = len(hexdata)

div = next(filter(lambda x: not length % x, range(int(length ** .5), length // 2 + 1)))

open("README.md", "w").write(open(Path(__file__).parent.resolve() / 'template.md').read().format(size = length // 2, hex = "\n".join(findall('.' * div, hexdata))))
