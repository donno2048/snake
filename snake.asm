push 0xB800
pop ds
start:
	mov ax, 0x3
	int 0x10
	mov di, 0x7D0
	lea si, [bp-0x4]
.food:
	div bp
	and dx, 0xF9C
	mov bx, dx
	cmp BYTE [bx], 0x9
	je .food
	mov BYTE [bx], 0x7
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
	cmp BYTE [di], 0x7
	setne cl
	cmp BYTE [di], 0x9
	je start
	mov BYTE [di], 0x9
	mov [bp], di
	inc bp
	inc bp
	jcxz .food
	es lodsw
	xchg ax, bx
	mov BYTE [bx], 0x20
	jmp SHORT .input
