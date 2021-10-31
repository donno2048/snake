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
dosbox -c "cycles 1" -c "mount c ." -c "c:" -c "snake"
```

It is so small I could fit it into a single QR:

<img src="./snake.png" width="250"/>

It's `232` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
8ed88ed0b800b88ec031ffb9d007b8200260f3abb8ffffb92600bfa802
f3abb91100ab60b9290031c0f3abb8ffffab6181c79e00e2ecb92600bf
4a0df3ab6189cfbd0600e86c00e460247f3c48741c3c4b74133c4d740a
3c5075ec81c7a000eb0e83c704eb0983ef04eb0481efa000b00926803d
070f94c4740626803d207580aa4f60061e0789e941beec7c01ee89f747
47fdf3a4fc076157893eec7c80fc0174098bbeec7cb020aaeb054545e8
03005feb9460b9ffff66f7f181e2ff0f81fa80027df089d783c22883ea
2883fa287df883fa127dde81c7d300c1e70226803d0974d1b007aa61c3
```
</details>

You can add `32` bytes and add a score by using uncommenting the commented lines in _snake.asm_

