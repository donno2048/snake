std
lds cx, [si+0x4]
mov al, [0xF]
start:
	mov ax, 0x3
	int 0x10
	mov di, 0x7D0
	mov si, sp
.food:
	in ax, 0x40
	xchg bx, ax
	and bx, cx
	cmp [bx], ch
	je .food
	mov [bx], cl
.input:
	in al, 0x60
	inc ax
	aam 0x4
	aad 0x28
	add al, 0x7
	cbw
	imul bx, ax, -4
	sub di, bx
	cmp di, cx
	ja start
	sar bx, 0x1
	lea ax, [di+bx+0x2]
	div cl
	and ah, ah
	jz start
	cmp [di], ch
	je start
	push di
	cmp [di], cl
	mov [di], ch
	je .food
	es lodsw
	xchg ax, bx
	mov [bx], ah
	jmp SHORT .input
