push 0xB800                 ; push the offset to video memory for DMA
pop ds                      ; pop that value into the data segment register so that every memory access will edit the video memory
mov cx, 0xFA0               ; move the size of the screen in text mode 3 into cx, also the cp437 values of the food and snake body into ch, cl, and the width of the screen to cl
std                         ; set direction flag to inverse the direction of lodsw for reading the stack as FIFO
start:                      ; start new game setup
	mov ax, 0x3         ; set ah=0 (change video mode) and al=3 (80x25 16 color text mode)
	int 0x10            ; video BIOS interrupt
	mov di, 0x7D0       ; move the middle of the screen (0xFA0/2) into di which is the initial position for the snake
	mov si, sp          ; make si point to the stack by moving the value of the stack pointer into it so that every lods will access the stack
.food:                      ; print new food
	imul bx, sp         ; multiply bx by sp to pseudo randomize bx which points to the place we'll put the food
	and bx, cx          ; and bx with cx to make it divisible by 4 (so it'll be eatable by the snake) and fit on the screen
	cmp [bx], ch        ; check if bx points to a place on the screen with a snake body character 
	je .food            ; if it is try to get another random bx
	mov [bx], cl        ; else put a food character there
.input:                     ; process keyboard input
	in al, 0x60         ; scan port 60h (keyboard input)
	mov bx, 0x4         ; set the default distance to move the snake to 4 (one step leftwards)
	and al, 0x1E        ; and al with 1e, 48 and 50 (down and up) will yield a parity flag of 0 and 4b and 4d (sides) of 1
	jp $+0x4            ; if the input is one of the sides jump over the next instruction
	mov bl, cl          ; set the value of the move to cl with is the width of the screen (i.e. one step up)
	and al, 0x14        ; and al with 14h, (48 & 1e) & 14h = (4b & 1e) & 14h = 0 and (50 & 1e) & 14h ≠ 0 and (4d & 1e) & 14h ≠ 0
	jz $+0x4            ; if the result was zero jump over the next instruction 
	neg bx              ; negate bx resulting in inversing the direction of the move
	sub di, bx          ; subtract bx from di which points to the next position of the snake's head, essentially executing the move
	cmp di, cx          ; subtract cx from di without saving the result
	ja start            ; if the result of the previous operation is above zero (unsigned so if di>cx or di<0 which means the snake went through a wall) restart the game
	sar bx, 0x1         ; divide bx by two so in the next operation after bx+2 [4 -> 4, -4 -> 0, ±160 -> something indivisible by 4]
	lea ax, [di+bx+0x2] ; di+bx+2 will find the minimum of previous di and current di plus 4 for horizontal movement and something not divisible by 4 for vertical
	div cl              ; for horizontal movement divide by the width of the screen to check if we moved a row, irrelevant for vertical movement as it's divisible by 4
	and ah, ah          ; and the remainder with itself to check if it's zero 
	jz start            ; if the result of the previous operation was zero (the snake hit a side wall) reset
	cmp [di], ch        ; compare the character at the new position of the snake to the snake character 
	je start            ; if the result of the previous comparison yielded an equal response reset the game (the snake hit itself)
	push di             ; push di to the stack to save the new position 
	cmp [di], cl        ; compare the character at the new position of the snake to the food character 
	mov [di], ch        ; move the snake character to the new position 
	je .food            ; if the result of the last comparison yielded an equal response (the snake ate the food) print new food and don't continue to delete the snake's tail
	es lodsw            ; use the fact si points to the stack to load the first  thing pushed to the stack (the end of the tail) and "pop" it into ax
	xchg ax, bx         ; exchange ax and bx to save one byte and to put the position in ax in bx and to move bh (which is invisible in cp437) into ah
	mov [bx], ah        ; move the invisible character instead of the snake character 
	jmp SHORT .input    ; loop back to process keyboard input
