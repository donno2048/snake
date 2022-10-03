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

It's `207` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
50501f176800b80731ffb9d
007b8200260f3abb8ffffb1
26bfa802f3abb111ab60b12
931c0f3abb8ffffab6181c7
9e00e2edb126bf4a0df3ab6
16a06515f5de85a00e46024
0fbba0003c087e03bb0400c
0e8023c027402f7db29dfb0
0926803d070f94c47406268
03d207594aa4f6006551e07
59418db6d0008d7c02fdf3a
4fc076157893ed00008e475
098bbed000b020aaeb05454
5e803005feba660b9ffff66
f7f181e2ff0f81fa80027df
06a2852525f585931d2f7f1
83fa127de081c7d300c1e70
226803d0974d3b007aa61c3
```
</details>

You can add `32` bytes and add a score by uncommenting the commented lines in _snake.asm_
