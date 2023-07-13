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

It's `136` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10b
fd007bd0400e85b00
e460bba000a801740
2b304247f3c4d7c02
f7db29df81ff9c0f7
7d8d1fb8d4102b1a0
f6f184e474cbb8090
0ae74c54f26803d07
0f94c4aa4f5789eb8
a078847024b79f889
7f0184e475093e8b7
e00b020aaeb054545
e803005feba56001d
7f7f781e2fc0f81fa
9c0f7ff289d7b009a
e74eb4fb007aa61c3
```
</details>

