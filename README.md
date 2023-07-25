# Snake

This is a snake game in assembly made for DOSBox and Linux.

You can view the online [Demo](https://donno2048.github.io/snake/) (Use your arrow keys on pc or swipe on mobile).

Inspired by [Can you fit a whole game into a QR code?](https://youtu.be/ExwqNreocpg)

It was made in order to create the smallest "fun" game possible.

To build and run it use:

```sh
sudo apt update
sudo apt install dosbox nasm -y
git clone https://github.com/donno2048/snake
cd snake
nasm snake.asm -o snake.com -f bin
dosbox -c "cycles 1" -c "mount c ." -c "c:" -c "snake"
```

It is so small I could fit it into a single QR:

<img src="./snake.png" width="250"/>

It's `117` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10bf
d007bd040031c9e84c
00e460bba000a80174
02b304a8147402f7db
29df81ff9c0f77d8d1
fb8d4102b3a0f6f384
e474cb26803d070f94
c4b009ae74bf4faa4f
897e00459e720b89cb
8b1f26c6072041ebb9
e80200ebb46001d7f7
f781e29c0f89d7b009
ae74f14fb007aa61c3
```
</details>

