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

It's `85` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b81fb9a00fb80
300cd10bfd0078d76
fc0fafdd21cb382f7
4f7880fe460bb0400
a801750288cba8147
402f7db29df39cf77
d3d1fb8d4102f6f18
4e474c8382d74c489
7e004545380d882d7
4c426ad938827ebc8
```
</details>

