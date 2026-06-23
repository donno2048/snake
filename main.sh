#!/bin/sh
set -e
if ! command -v nasm >/dev/null; then
    echo "Error: 'nasm' is not installed. Try 'apt install nasm'."
    exit 1
fi
if ! command -v wget >/dev/null; then
    echo "Error: 'wget' is not installed. Try 'apt install wget'."
    exit 1
fi
if ! command -v python3 >/dev/null; then
    echo "Error: 'python3' is not installed. Try 'apt install python3'."
    exit 1
fi
nasm -f bin snake.asm -o demo/snake.com
wget https://v8.js-dos.com/latest/js-dos.js -q -P demo -nc
wget https://v8.js-dos.com/latest/emulators/emulators.js -q -P demo -nc
wget https://v8.js-dos.com/latest/emulators/wdosbox.wasm -q -P demo -nc
wget https://v8.js-dos.com/latest/emulators/wdosbox.js -q -P demo -nc
python3 -m http.server -d demo
