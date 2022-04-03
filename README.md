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

It's `218` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
50501f17b800b8500731ffb9d007b8200260f3abb8ffffb126bfa802f3abb111ab60b12931c0f3abb8ffffab6181c79e00e2edb126bf4a0df3ab616a06515f5de86400e460247f3c4874173c4b740f3c4d74083c5075ec81c79c0083c70881c79c0081efa000b00926803d070f
94c4740626803d207589aa4f6006551e0759418db6dc008d7c02fdf3a4fc076157893edc0008e475098bbedc00b020aaeb054545e803005feb9c60b9ffff66f7f181e2ff0f81fa80027df06a2852525f585931d2f7f183fa127de081c7d300c1e70226803d0974d3b007aa61c3
```
</details>

You can add `32` bytes and add a score by uncommenting the commented lines in _snake.asm_
