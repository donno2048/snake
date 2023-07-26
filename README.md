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
6800b807b003cd10bfd0078d76fce84a00e460bba000a8017402b304a8147402f7db29df81ff9c0f77dad1fb8d4102b3a0f6f384e474cd268
03d070f94c4b009ae74c14faa4f897e0045459e7208ad9326c60720ebbbe80200ebb66001d7f7f781e29c0f89d7b009ae74f14fb007aa61c3
```
</details>

