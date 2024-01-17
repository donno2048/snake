#!/bin/bash
set -e
nasm -f bin snake.asm -o snake.com
zip demo/snake.zip snake.com
algernon -t -n demo/
