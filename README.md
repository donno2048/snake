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

It's `140` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10bfd0
07bd0400e85f00e46024
0fbba0003c087e02b304
c0e8023c027402f7db29
df81ff9c0f77d5d1fb8d
4102b1a0f6f184e474c8
b80900ae74c24f26803d
070f94c4aa4f5789eb8a
078847024b79f8893e00
0084e475093e8b7e00b0
20aaeb054545e803005f
eba16001d7f7f781e2fc
0f81fa9c0f7ff289d7b0
09ae74eb4fb007aa61c3
```
</details>

