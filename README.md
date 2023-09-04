# Snake

This is a snake game in assembly made for DOS.

The game was [covered in Hackaday](https://hackaday.com/2023/08/03/its-snake-in-a-qr-code-but-smaller/).

You can view the online [Demo](https://donno2048.github.io/snake/) (Use your arrow keys on PC or swipe on mobile).

Inspired by [Can you fit a whole game into a QR code?](https://youtu.be/ExwqNreocpg) by @itsmattkc which was also [featured in Hackaday](https://hackaday.com/2020/08/17/fitting-snake-into-a-qr-code/).

It was made to create the smallest "fun" game possible.

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

It's `73` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
fdc54c04a00f00b80300cd10ba200abfd00789e6e540259c0f93381775f6882fe460f6e6d
406d57698938d410201df01df39cf73d2f6f120e474cc300d79c8577ad226ad938817ebd7
```
</details>

