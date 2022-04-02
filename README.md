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

It's `229` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
e2feb800b8500731ffb9d007b8200260f3abb8ffff6a116a2659bfa802f3ab59ab606a295931c0f3abb8ffffab6181c79e00e2ec6a2659bf4a0df3ab616a06515f5de86b00e460247f3c48741c3c4b74133c4d740a3c5075ec81c7a000eb0e83c704eb0983ef04eb0481efa000b00926803d070f94c4740626803d207584aa4f6006551e075941bee80001ee565f4747fdf3a4fc076157893ee80008e475098bbee800b020aaeb054545e803005feb9560b9ffff66f7f181e2ff0f81fa80027df0525f83c22883ea2883fa287df883fa127dde81c7d300c1e70226803d0974d1b007aa61c3
```
</details>

You can add `32` bytes and add a score by uncommenting the commented lines in _snake.asm_
