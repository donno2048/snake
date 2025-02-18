#!/bin/sh

{ command -v nasm && command -v python3; } > /dev/null || \
    { echo "Error: nasm or python3 is not installed.";
      echo "Try 'apt install nasm python3'."; exit 1; }
nasm -f bin snake.asm -o demo/snake.com || exit 1
python3 -m http.server -d demo
