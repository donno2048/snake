push 0xB800
pop ds
mov cx, 0xFA0
start:
	mov ax, 0x3
	int 0x10
	mov di, 0x7D0
	lea si, [bp-0x4]
.food:
	div bp
	and dx, cx
	mov bx, dx
	cmp [bx], ch
	je .food
	mov [bx], cl
.input:
	in al, 0x60
	mov bx, 0x4
	test al, 0x1
	jnz $+0x4
	mov bl, cl
	test al, 0x14
	jz $+0x4
	neg bx
	sub di, bx
	cmp di, cx
	ja start
	sar bx, 0x1
	lea ax, [di+bx+0x2]
	div cl
	test ah, ah
	jz start
	cmp [di], ch
	je start
	mov [bp], di
	inc bp
	inc bp
	cmp [di], cl
	mov [di], ch
	je .food
	es lodsw
	xchg ax, bx
	mov [bx], ah
	jmp SHORT .input
