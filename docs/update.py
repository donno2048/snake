#!/usr/bin/env python3

from re import findall
from pathlib import Path
from sysconfig import get_platform

data = open("demo/snake.com", "rb").read()

length = len(data) * 2

div = next(filter(lambda x: length % x == 0, range(int(length ** .5), length)))

open("README.md", "w", encoding="utf-8").write(open("docs/template.md", encoding="utf-8").read().format(
  size = length // 2,
  hex = "\n".join(findall('.' * div, data.hex())),
  platform = get_platform(),
  empty_size = Path("empty.out").stat().st_size,
  optimized_size = Path("optimized.out").stat().st_size
))
