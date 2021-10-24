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

It's `252` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
8ed88ed0b800b88ec031ffb9d007b8200260
f3abb8ffffb92600bfa802f3abb91100ab60
b9290031c0f3abb8ffffab6181c79e00e2ec
b92600bf4a0df3ab6189cfbd0600e88000e4
60247f3c48741c3c4b74133c4d740a3c5075
ec81c7a000eb0e83c704eb0983ef04eb0481
efa000b00926803d070f94c4740626803d20
7580aa4f60061e0789e941be007d01ee89f7
4747fdf3a4fc076157893e007d80fc017409
8bbe007db020aaeb194545bf30028306fc7c
01a1fc7cb30af6f386c40430aae803005feb
8060b9ffff66f7f181e2ff0f81fa80027df0
89d783c22883ea2883fa287df883fa127dde
81c7d300c1e70226803d0974d1b007aa61c3
```
</details>

