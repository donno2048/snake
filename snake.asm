start:
	push ax
	push ax
	push 0xB800
	pop es
	pop ds
	pop ss
	xor di, di
	mov cx, 0x7D0
	mov ax, 0x220
	push cx
	rep stosw
	pop di
	push 0x6
	pop bp
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
.move:
	cmp BYTE [es:di], 0x9
	je start
	cmp di, 0xF9C
	jg start
	cmp di, 0x0
	jl start
.alive:
	cmp BYTE [es:di], 0x7
	sete ah
	mov al, 0x9
	stosb
	dec di
	pusha
	push es
	push bp
	push ds
	pop es
	pop cx
	inc cx
	lea si, [snake+bp]
	lea di, [si+0x2]
	std
	rep movsb
	cld
	pop es
	popa
	push di
	mov [snake], di
	or ah, ah
	jnz .food
	mov di, [snake+bp]
	mov al, 0x20
	stosb
	jmp .done
.food:
	inc bp
	inc bp
	call print_food
.done:
	pop di
	jmp .input
print_food:
	pusha
.rand:
	mov cx, 0xFFFF
	div cx
	and dx, 0xFFC
	cmp dx, 0xF9C
	jg .rand
	push dx
	pop di
	cmp BYTE [es:di], 0x9
	je .rand
	mov al, 0x7
	stosb
	popa
	ret
section .bss
snake:
