push 0xB800
pop es ; I could use `les` but I want it to be "cross-platform"
start:
	mov al, 0x3
	int 0x10
	mov di, 0x7D0
	lea si, [bp-0x4]
	call print_food
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
	sete ah
	mov al, 0x9
	scasb
	je start
	dec di
	stosb
	dec di
	mov [bp], di
	inc bp
	inc bp
	sahf
	jc .food
	lodsw
	xchg ax, bx
	mov [es:bx], BYTE 0x20
	jmp SHORT .input
.food:
	call print_food
	jmp SHORT .input
print_food:
	pusha
.rand:
	add di, dx
	div di
	and dx, 0xF9C
	mov di, dx
	mov al, 0x9
	scasb
	je .rand
	dec di
	mov al, 0x7
	stosb
	popa
	ret
