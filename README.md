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

It's `88` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b81fb99c0fb8
0300cd10bfd0078d
76fcf7f521ca89d3
382f74f6880fe460
bba000a8017402b3
04a8147402f7db29
df39cf77d2d1fb8d
4102b3a0f6f384e4
74c5382d74c1897e
004545380d882d74
c126ad938827ebc6
```
</details>

