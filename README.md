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

It's `95` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b81fb80300cd10b
fd0078d76fcf7f581e2
9c0f89d3803f0974f3c
60707e460bba000a801
7402b304a8147402f7d
b29df81ff9c0f77ccd1
fb8d4102b3a0f6f384e
474bf803d0974ba897e
004545803d07c605097
4b826ad93c60720ebc0
```
</details>

