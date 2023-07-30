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

It's `100` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b81fb80300cd10bf
d0078d76fcf7f581e29c
0f89d3803f0974f3c607
07e460bba000a8017402
b304a8147402f7db29df
81ff9c0f77ccd1fb8d41
02b3a0f6f384e474bf80
3d070f95c1803d0974b4
c60509897e004545e3b5
268b1c4646c60720ebbb
```
</details>

