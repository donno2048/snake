#!/bin/sh
if ! command -v nasm >/dev/null; then
    echo "Error: 'nasm' is not installed. Try 'apt install nasm'."
    exit 1
fi
if ! command -v python3 >/dev/null; then
    echo "Error: 'python3' is not installed. Try 'apt install python3'."
    exit 1
fi
nasm -f bin snake.asm -o demo/snake.com || exit 1
python3 -m http.server -d demo
