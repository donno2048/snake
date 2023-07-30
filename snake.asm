push 0xB800
pop ds
mov cx, 0xF9C
start:
	mov ax, 0x3
	int 0x10
	mov di, 0x7D0
	lea si, [bp-0x4]
.food:
	div bp
	and dx, cx
	mov bx, dx
	cmp [bx], cl
	je .food
	mov [bx], ch
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
	cmp di, cx
	ja start
	sar bx, 0x1
	lea ax, [di+bx+0x2]
	mov bl, 0xA0
	div bl
	test ah, ah
	jz start
	cmp [di], cl
	je start
	mov [bp], di
	inc bp
	inc bp
	cmp [di], ch
	mov [di], cl
	je .food
	es lodsw
	xchg ax, bx
	mov BYTE [bx], 0x20
	jmp SHORT .input
