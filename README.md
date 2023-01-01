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

It's `159` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
6800b8078ed88ed0b003cd10bfd007bd0600e86d00e460240fbba
0003c087e02b304c0e8023c027402f7db29df26803d0974cd8d01
31f8c0e0023cf0750081ff9c0f7fbc83ff007cb726803d070f94c
4b009aa4f60061e078d4e018db6a0008d7c02fdf3a4fc07615789
3ea00008e475098bbea000b020aaeb054545e803005feb9360b9f
ffff7f181e2fc0f81fa9c0f7ff189d726803d0974e9b007aa61c3
```
</details>

