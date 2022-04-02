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

It's `225` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
50501f17b800b8500731ffb9d007b8
200260f3abb8ffffb126bfa802f3ab
b111ab60b12931c0f3abb8ffffab61
81c79e00e2edb126bf4a0df3ab616a
06515f5de86b00e460247f3c48741c
3c4b74133c4d740a3c5075ec81c7a0
00eb0e83c704eb0983ef04eb0481ef
a000b00926803d070f94c474062680
3d207584aa4f6006551e075941bee4
0001ee565f4747fdf3a4fc07615789
3ee40008e475098bbee400b020aaeb
054545e803005feb9560b9ffff66f7
f181e2ff0f81fa80027df06a285252
5f585931d2f7f183fa127de081c7d3
00c1e70226803d0974d3b007aa61c3
```
</details>

You can add `32` bytes and add a score by uncommenting the commented lines in _snake.asm_
