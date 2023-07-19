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

It's `133` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10bfd
007bd0400e85800e460
bba000a8017402b3042
47f3c4d7c02f7db29df
81ff9c0f77d8d1fb8d4
102b1a0f6f184e474cb
26803d070f94c4b009a
e74bf4faa4f89eb8a07
8847024b79f8897f018
4e475098b760026c604
20ebaf4545e80200eba
86001d7f7f781e2fc0f
81fa9c0f7ff289d7b00
9ae74eb4fb007aa61c3
```
</details>

