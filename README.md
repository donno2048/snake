# Snake

This is a snake game in assembly made for DOSBox and Linux.

You can view the online [Demo](https://donno2048.github.io/snake/) (Use your arrow keys on pc or swipe on mobile).

It was made in order to create the smallest "fun" game possible.

To build and run it use:

```sh
sudo apt update
sudo apt install dosbox nasm -y
git clone https://github.com/donno2048/snake
cd snake
nasm snake.asm -o snake.com -f bin
dosbox -c "cycles 1" -c "mount c ." -c "c:" -c "cls" -c "snake"
```

It is so small I could fit it into a single QR:

<img src="./snake.png" width="250"/>

It's `256` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
8ed88ed0b800b88ec031ffb9d007b820
abb91100ab60b9290031c0f3abb8ffff
f3ab6189cfbd0600e88000e460247f3c
ec81c7a000eb0e83c704eb0983ef04eb
740626803d207580aa4f60061e0789e9
076157893e007d80fc0174098bbe007d
01a1fc7cb30af6f386c40430aae80300
81fa80027df089d783c22883ea2883fa
```
</details>

