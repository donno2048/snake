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

It's `130` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10bfd0
07bd0400e85500e460bb
a000a8017402b304a814
7402f7db29df81ff9c0f
77dad1fb8d4102b1a0f6
f184e474cd26803d070f
94c4b009ae74c14faa4f
89eb8a078847024b79f8
897f019e72098b760026
c60420ebb24545e80200
ebab6001d7f7f781e2fc
0f81fa9c0f7ff289d7b0
09ae74eb4fb007aa61c3
```
</details>

