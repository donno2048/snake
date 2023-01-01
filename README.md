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

It's `148` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
50506800b8071f17b003cd10bfd0076a065de
86200e460240fbba0003c087e02b304c0e802
3c027402f7db29df26803d0974cd81ff9c0f7
fc783ff007cc226803d070f94c4b009aa4f60
06551e0759418db694008d7c02fdf3a4fc076
157893e940008e475098bbe9400b020aaeb05
4545e803005feb9e60b9fffff7f181e2fc0f8
1fa9c0f7ff1525f26803d0974e9b007aa61c3
```
</details>

