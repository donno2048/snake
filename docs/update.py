from re import findall
from pathlib import Path
from sysconfig import get_platform

hexdata = open(0).read().replace("\n", "")

length = len(hexdata)

div = next(filter(lambda x: not length % x, range(int(length ** .5), length)))

open("README.md", "w").write(open(Path(__file__).parent.resolve() / 'template.md').read().format(size = length // 2, hex = "\n".join(findall('.' * div, hexdata)), platform = get_platform(), empty_size = Path("a.out").stat().st_size))
