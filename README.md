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

It's `144` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10bf
d007bd0400e86300e4
60240fbba0003c087e
02b304c0e8023c0274
02f7db29df81ff9c0f
7fd585ff78d1d1fb8d
4102b1a0f6f184e474
c4b80900ae74be4f26
803d070f94c4aa4f57
89eb8a078847024b79
f8893e000084e47509
3e8b7e00b020aaeb05
4545e803005feb9d60
01d7f7f781e2fc0f81
fa9c0f7ff289d7b009
ae74eb4fb007aa61c3
```
</details>

