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

It's `98` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b81fb80300
cd10bfd0078d76
fcf7f581e29c0f
89d3803f0974f3
c60707e460bba0
00a8017402b304
a8147402f7db29
df81ff9c0f77cc
d1fb8d4102b3a0
f6f384e474bf80
3d070f95c1803d
0974b4c6050989
7e004545e3b526
ad93c60720ebbd
```
</details>

