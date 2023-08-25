# Snake

This is a snake game in assembly made for DOS.

The game was covered in [Hackaday](https://hackaday.com/2023/08/03/its-snake-in-a-qr-code-but-smaller/).

You can view the online [Demo](https://donno2048.github.io/snake/) (Use your arrow keys on pc or swipe on mobile).

Inspired by [Can you fit a whole game into a QR code?](https://youtu.be/ExwqNreocpg)

It was made in order to create the smallest "fun" game possible.

To build and run it use:

```sh
sudo add-apt-repository ppa:feignint/dosbox-staging
sudo apt update
sudo apt install nasm libsdl2-2.0-0 libsdl2-image-2.0-0 libsdl2-net-2.0-0 libopusfile0 dosbox-staging -y
git clone https://github.com/donno2048/snake
cd snake
nasm snake.asm -o snake.com -f bin
dosbox snake.com -c "cycles 1"
```

It is so small I could fit it into a single QR:

<img src="./snake.png" width="250"/>

It's `80` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
fdc54c04a00f00b8
0300cd10bfd00789
e6e5409321cb382f
74f7880fe460bb04
00241e7a0288cb24
147402f7db29df39
cf77d4d1fb8d4102
f6f120e474c9382d
74c557380d882d74
c826ad938827ebcc
```
</details>

