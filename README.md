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
50506800b8071f1731
ffb9d007b8200251f3
ab5f6a065de86200e4
60240fbba0003c087e
02b304c0e8023c0274
02f7db29df26803d09
74c881ff9c0f7fc283
ff007cbd26803d070f
94c4b009aa4f600655
1e0759418db69c008d
7c02fdf3a4fc076157
893e9c0008e475098b
be9c00b020aaeb0545
45e803005feb9e60b9
fffff7f181e2fc0f81
fa9c0f7ff1525f2680
3d0974e9b007aa61c3
```
</details>

