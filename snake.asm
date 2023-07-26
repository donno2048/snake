push 0xB800
pop es
start:
	mov ax, 0x3
	int 0x10
	mov di, 0x7D0
	lea si, [bp-0x4]
.food:
	div bp
	and dx, 0xF9C
	mov bx, dx
	cmp BYTE [es:bx], 0x9
	je .food
	mov BYTE [es:bx], 0x7
.input:
	in al, 0x60
	mov bx, 0xA0
	test al, 0x1
	jz .up_down
	mov bl, 0x4
.up_down:
	test al, 0x14
	jz .minus
	neg bx
.minus:
	sub di, bx
	cmp di, 0xF9C
	ja start
	sar bx, 0x1
	lea ax, [di+bx+0x2]
	mov bl, 0xA0
	div bl
	test ah, ah
	jz start
	cmp BYTE [es:di], 0x7
	setne cl
	mov al, 0x9
	scasb
	je start
	dec di
	stosb
	dec di
	mov [bp], di
	inc bp
	inc bp
	jcxz .food
	lodsw
	xchg ax, bx
	mov BYTE [es:bx], 0x20
	jmp SHORT .input
