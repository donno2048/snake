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
	and al, 0xF
	mov bx, 0xA0
	cmp al, 0x8
	jle .up_down
	mov bl, 0x4
.up_down:
	shr al, 0x2
	cmp al, 0x2
	je .minus
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
	push di
	mov bx, bp
.next_byte:
	mov al, [bx]
	mov [bx + 0x2], al
	dec bx
	jns .next_byte
	mov [0], di
	test ah, ah
	jnz .food
	mov di, [ds:bp]
	mov al, 0x20
	stosb
	jmp SHORT .done
.food:
	inc bp
	inc bp
	call print_food
.done:
	pop di
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
