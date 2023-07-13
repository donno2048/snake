push 0xB800
pop es
start:
	mov al, 0x3
	int 0x10
	mov di, 0x7D0
	mov bp, 0x4
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
	mov cl, 0xA0
	div cl
	test ah, ah
	jz start
	mov ax, 0x9
	scasb
	je start
	dec di
	cmp BYTE [es:di], 0x7
	sete ah
	stosb
	dec di
	mov bx, bp
.next_byte:
	mov al, [bx]
	mov [bx+0x2], al
	dec bx
	jns .next_byte
	mov [bx+0x1], di
	test ah, ah
	jnz .food
	mov si, [bp]
	mov [es:si], BYTE 0x20
	jmp SHORT .input
.food:
	inc bp
	inc bp
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
