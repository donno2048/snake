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

It's `128` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10
bfd007bd040031c9
e85100e460bba000
a8017402b304247f
3c4d7c02f7db29df
81ff9c0f77d6d1fb
8d410251b1a0f6f1
5984e474c726803d
070f94c4b009ae74
bb4faa4f897e0045
84e4750b89cb8b1f
26c6072041ebb4e8
0200ebaf6001d7f7
f781e2fc0f81fa9c
0f7ff289d7b009ae
74eb4fb007aa61c3
```
</details>

