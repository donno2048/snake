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

It's `113` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b807b80300cd10bfd0078d76fce84900e460bba000a8017402b304a8147402f7db29df81ff9c0f77d9d1fb8d4102b3a0f6f384e474cc2
6803d070f95c1b009ae74c04faa4f897e004545e308ad9326c60720ebbce80200ebb76001d7f7f781e29c0f89d7b009ae74f14fb007aa61c3
```
</details>

