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

It's `156` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
8ed88ed06800b807b003cd10
bfd007bd0400e86b00e46024
0fbba0003c087e02b304c0e8
023c027402f7db29df26803d
0974d181ff9c0f7fcb85ff78
c7d1fb8d4102b1a0f6f184e4
74ba26803d070f94c4b009aa
4f60061e0789ee8d4e018d7e
02fdf3a4fc076157893e0000
08e475088b7e00b020aaeb05
4545e803005feb956001d7f7
f781e2fc0f81fa9c0f7ff289
d726803d0974eab007aa61c3
```
</details>

