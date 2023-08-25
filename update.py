from re import findall

README = '''# Snake

This is a snake game in assembly made for DOSBox and Linux.

You can view the online [Demo](https://donno2048.github.io/snake/) (Use your arrow keys on pc or swipe on mobile).

Inspired by [Can you fit a whole game into a QR code?](https://youtu.be/ExwqNreocpg)

It was made in order to create the smallest "fun" game possible.

To build and run it use:

```sh
sudo add-apt-repository ppa:feignint/dosbox-staging
sudo apt update
sudo apt install nasm libsdl2-2.0-0 libsdl2-image-2.0-0 libsdl2-net-2.0-0 libopusfile0 dosbox-staging -y
git clone https://github.com/donno2048/snake
cd snake
nasm snake.asm -o snake.com -f bin
dosbox snake.com -c "cycles 1"
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

hexdata = open("snake.hex").read().replace("\n", "")

length = len(hexdata)

for div in range(int(length ** .5), 0, -1):
    if not length % div:
        break

open("README.md", "w").write(README % (length // 2, "\n".join(findall('.' * (length // div), hexdata))))
