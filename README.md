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

It's `209` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
50501f17b800b8500731ff
b9d007b8200260f3abb8ff
ffb126bfa802f3abb111ab
60b12931c0f3abb8ffffab
6181c79e00e2edb126bf4a
0df3ab616a06515f5de85b
00e460240fbba0003c087e
03bb0400c0e8023c027403
f7d34329dfb00926803d07
0f94c4740626803d207592
aa4f6006551e0759418db6
d4008d7c02fdf3a4fc0761
57893ed40008e475098bbe
d400b020aaeb054545e803
005feba560b9ffff66f7f1
81e2ff0f81fa80027df06a
2852525f585931d2f7f183
fa127de081c7d300c1e702
26803d0974d3b007aa61c3
```
</details>

You can add `32` bytes and add a score by uncommenting the commented lines in _snake.asm_
