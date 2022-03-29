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

It's `246` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
8ed88ed0b800b88ec031ffb9d007b8200260f3abb8ffffb92600bfa802f3abb91100268905474760b9
290031c0f3abb8ffff2689056181c79e00e2e6b92600bf4a0df3ab6189cfbd0600e87200e460247f3c
48741c3c4b74133c4d740a3c5075ec81c7a000eb0e83c704eb0983ef04eb0481efa000b00926803d07
b401740ab40026803d200f8577ff26880560061e0789e941bef87c01ee89f74747fdf3a4fc07615789
3ef87c80fc01740b8bbef87cb020268805eb054545e803005feb8e60b9ffff66f7f181e2ff0f81fa80
027df089d783c22883ea2883fa287df883fa127dde81c7d300c1e70226803d0974d1b00726880561c3
```
</details>

You can add `32` bytes and add a score by uncommenting the commented lines in _snake.asm_

