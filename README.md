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

It's `154` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
50506800b8071f1731ffb9
d007b8200251f3ab5f6a06
5de86300e460240fbba000
3c087e03bb0400c0e8023c
027402f7db29df26803d09
74c781ff9c0f7fc183ff00
7cbc26803d070f94c4b009
aa4f6006551e0759418db6
9c008d7c02fdf3a4fc0761
57893e9c0008e475098bbe
9c00b020aaeb054545e803
005feb9d60b9fffff7f181
e2fc0f81fa9c0f7ff1525f
26803d0974e9b007aa61c3
```
</details>

You can add `32` bytes and add a score by uncommenting the commented lines in _snake.asm_
