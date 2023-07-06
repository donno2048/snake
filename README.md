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

It's `153` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10bf
d007bd0400e86c00e4
60240fbba0003c087e
02b304c0e8023c0274
02f7db29df26803d09
74d581ff9c0f7fcf85
ff78cbd1fb8d4102b1
a0f6f184e474be2680
3d070f94c4b009aa4f
60061e0789ee8d4e01
8d7e02fdf3a4fc0761
57893e000008e47509
3e8b7e00b020aaeb05
4545e803005feb9460
01d7f7f781e2fc0f81
fa9c0f7ff289d72680
3d0974eab007aa61c3
```
</details>

