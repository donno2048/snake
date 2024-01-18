# Snake

<img src="https://github.com/donno2048/snake/actions/workflows/update.yml/badge.svg"/>

This is an x86 snake game made for DOS.

The game was [covered on Hackaday](https://hackaday.com/2023/08/03/its-snake-in-a-qr-code-but-smaller/).

## Running

### Online demo

To test the code you can view the online [demo](https://donno2048.github.io/snake/) which updates for every change in [snake.asm](/snake.asm) (Use your arrow keys on PC or swipe on mobile).

### Self-hosting

If you want to test the code yourself you need to install the requirements for the build process and run it on your computer.

#### Installation

I'm using `nasm` and `python3` which can be installed with `apt install nasm python3 -y`.

#### Building

To test it just run [main.sh](/main.sh) and open http://localhost:8000.

## Motivation

Inspired by "[Can you fit a whole game into a QR code?](https://youtu.be/ExwqNreocpg)" by @itsmattkc which was also [featured on Hackaday](https://hackaday.com/2020/08/17/fitting-snake-into-a-qr-code/).

<details>
  <summary>It was made to create the smallest "fun" game possible.</summary>
  <br/>

For the countless people saying I'm intentionally not mentioning the _Hugi Size Coding Competition_ (a competition in which the competitors had to make the smallest nibbles game to win) here is my reply to one such comment (from when the game was still 133 bytes):

> Firstly, it seems that you didn't even read the rules of the "Nibbles" game:
>
> > in the inside of this border  a  "snake"  is  supposed  to grow,  whose size  is  one  pixel at the beginning. after starting the program, the snake's size shall grow one pixel more in each repetition  of the program's main-loop.
>
> Which is simply not the same as snake and a **lot** less difficult to implement.
>
> Secondly, the implementations from this competition have flaws (not that they're not good but I'm saying it doesn't make my version bad) like, for example from the comments in the winning entry:
>
> > game can't handle any other keys but keypad arrow keys, you need to start it by typing pause|nibbles in DOS prompt and then hitting an arrow key
>
> and
>
> > Because top memory segment in PSP is environment dependant\[sic\] you need version suitable for your environment
>
> and it doesn't even work on DOSBox because of some special configurations needed.
>
> From the second place entry:
>
> > When starting this program, press the 2 (DOWN) key \_\_IMMEDIATELY\_\_
>
> And it too won't work without setting the cycle count and changing it sometimes breaks the game
>
> As for the third place
>
> > press  '8','4','6' but not '2' once game begins immediately
>
> and the game breaks in the same way the second place does (and needs the same cycle adjusting) but the walls are also broken.
>
> I'll look at the fourth place entry and stop wasting my time doing this,
>
> Well, just looked at it and couldn't make it to boot
>
> And lastly, what place is your entry to the competition? Before you criticize other people first check your criticism is correct and try doing it yourself before you judge.
>
> Thanks for the feedback anyways :)
>
> P.S. I didn't even claim my version was ideal, the main point of the post was asking for help, and this comment actually made me feel better about my implementation in a way, as in an actual size optimization competition someone had a submission of 121 bytes for just a line extending over the screen and my entire snake game (which obviously contains this functionality just as a small part of the entire program) takes only 12 bytes more now, and if I can fix the PR only 7 bytes more.

AFAIK This is the smallest snake game ever made.
</details>

## Perspectives

It is so small I could fit it into a single QR:

<img src="/demo/qr.png" width="250"/>

It's {size} bytes.

How little is {size} bytes? Well, this line of text weighs more than 70 bytes.

And so does this arbitrary sequence of emojis: 👩🏼‍❤️‍💋‍👨🏼🧔🏽‍♀️👩🏼‍❤️‍💋‍👨🏼

<details>
  <summary>Hex</summary>
  <br/>
    
```
{hex}
```
</details>

### Comparison

||My version|MattKC's version|ibara's version|
|-|-|-|-|
|Bytes|{size}|~1400|2024|
|QR|<img src="/demo/qr.png" width="250"/>|<img src="https://mattkc.com/etc/snakeqr/code.png" width="250"/>|<img src="https://raw.githubusercontent.com/ibara/snakeqr/master/snakeqr.png" width="250"/>|
|Link|https://github.com/donno2048/snake|https://mattkc.com/etc/snakeqr/|https://github.com/ibara/snakeqr|
