mov ds, ax
mov ss, ax
start:
	push 0xB800
	pop es
	mov al, 0x3
	int 0x10
	mov di, 0x7D0
	mov bp, 0x6
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
	cmp BYTE [es:di], 0x9
	je start
	cmp di, 0xF9C
	jg start
	cmp di, 0x0
	jl start
	sar bx, 0x1
	lea ax, [di+bx+0x2]
	mov cl, 0xA0
	div cl
	cmp ah, 0x0
	je start
	cmp BYTE [es:di], 0x7
	sete ah
	mov al, 0x9
	stosb
	dec di
	pusha
	push es
	push ds
	pop es
	mov si, bp
	lea cx, [bp+0x1]
	lea di, [bp+0x2]
	std
	rep movsb
	cld
	pop es
	popa
	push di
	mov [0], di
	or ah, ah
	jnz .food
	mov di, [bp]
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
	mov di, dx
	cmp BYTE [es:di], 0x9
	je .rand
	mov al, 0x7
	stosb
	popa
	ret
