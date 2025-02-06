#!/bin/sh

set -e
nasm -f bin snake.asm -o demo/snake.com
python3 -m http.server -d demo
