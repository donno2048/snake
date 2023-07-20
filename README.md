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

It's `126` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b003cd10bf
d007bd040031c9e84f
00e460bba000a80174
02b304247f3c4d7c02
f7db29df81ff9c0f77
d6d1fb8d4102b3a0f6
f384e474c926803d07
0f94c4b009ae74bd4f
aa4f897e004584e475
0b89cb8b1f26c60720
41ebb6e80200ebb160
01d7f7f781e2fc0f81
fa9c0f7ff289d7b009
ae74eb4fb007aa61c3
```
</details>

