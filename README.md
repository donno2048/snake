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

It's `81` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b81fb9a00ffdb8
0300cd10bfd00789e6
0fafdc21cb382f74f7
880fe460bb0400241e
7a0288cb24147402f7
db29df39cf77d4d1fb
8d4102f6f120e474c9
382d74c557380d882d
74c826ad938827ebcc
```
</details>

