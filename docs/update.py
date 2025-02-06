#!/usr/bin/env python3

from sys import stdin
from re import findall
from pathlib import Path
from sysconfig import get_platform

hexdata = stdin.read().replace("\n", "")

length = len(hexdata)

div = next(filter(lambda x: length % x == 0, range(int(length ** .5), length)))

open("README.md", "w").write(open("docs/template.md").read().format(
  size = length // 2,
  hex = "\n".join(findall('.' * div, hexdata)),
  platform = get_platform(),
  empty_size = Path("a.out").stat().st_size
))
