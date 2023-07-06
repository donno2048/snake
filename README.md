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

It's `151` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
fd6800b807b003cd10bfd007bd0400e86900e460240fbba0003c087e02b304c0e8023c027402f7db29df81ff9c0f7fd585ff78d1d1fb8d4102b1a0f6f184e474c4b80900ae74be4726803d0
70f94c4aa4760061e0789ee8d4e018d7e02f3a4076157893e000008e475093e8b7e00b020aaeb054545e803005feb976001d7f7f781e2fc0f81fa9c0f7ff289d7b009ae74eb47b007aa61c3
```
</details>

