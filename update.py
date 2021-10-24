from re import findall

README = '''# Snake

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

It's `%i` bytes.

<details>
  <summary>Hex</summary>
  <br/>
    
```
%s
```
</details>

'''

hexdata = open("snake.hex").read().strip()

length = len(hexdata) // 2

for div in range(int(length ** .5), 0, -1):
    if not length % div:
        break

open("README.md", "w").write(README % (length, "\n".join(findall('..' * (length // div), hexdata))))
