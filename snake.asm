push 0xB800
pop es
start:
	mov al, 0x3
	int 0x10
	mov di, 0x7D0
	mov bp, 0x4
	xor cx, cx
	call print_food
.input:
	in al, 0x60
	mov bx, 0xA0
	test al, 0x1
	jz .up_down
	mov bl, 0x4
.up_down:
	and al, 0x7F
	cmp al, 0x4D
	jl .minus
	neg bx
.minus:
	sub di, bx
	cmp di, 0xF9C
	ja start
	sar bx, 0x1
	lea ax, [di+bx+0x2]
	push cx
	mov cl, 0xA0
	div cl
	pop cx
	test ah, ah
	jz start
	cmp BYTE [es:di], 0x7
	sete ah
	mov al, 0x9
	scasb
	je start
	dec di
	stosb
	dec di
	mov [bp], di
	inc bp
	test ah, ah
	jnz .food
	mov bx, cx
	mov bx, [bx]
	mov [es:bx], BYTE 0x20
	inc cx
	jmp SHORT .input
.food:
	call print_food
	jmp SHORT .input
print_food:
	pusha
.rand:
	add di, dx
	div di
	and dx, 0xFFC
	cmp dx, 0xF9C
	jg .rand
	mov di, dx
	mov al, 0x9
	scasb
	je .rand
	dec di
	mov al, 0x7
	stosb
	popa
	ret
