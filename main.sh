#!/bin/bash
set -e
nasm -f bin snake.asm -o snake.com
zip demo/snake.zip snake.com
python3 -m http.server -d demo
