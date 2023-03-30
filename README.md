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

It's `147` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
31c06800b8078ed88ed0b
003cd10bfd007bd0600e8
5f00e460240fbba0003c0
87e02b304c0e8023c0274
02f7db29df26803d0974c
b81ff9c0f7fc583ff007c
c026803d070f94c4b009a
a4f60061e0789ee8d4e01
8d7e02fdf3a4fc0761578
93e000008e475088b7e00
b020aaeb054545e803005
feba160b9fffff7f181e2
fc0f81fa9c0f7ff189d72
6803d0974e9b007aa61c3
```
</details>

