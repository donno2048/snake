#!/bin/bash
set -e
nasm -f bin snake.asm -o snake.com
zip demo/snake.zip snake.com
config=$(mktemp)
sed "s/PWD/${PWD//\//\\\/}/" lighttpd.conf > "$config"
lighttpd -D -f "$config" || rm "$config"
