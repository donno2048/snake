;org 0x7C00
start:
	times 2 push ax
	pop ds
	pop ss
	mov ax, 0xB800
	push ax
	pop es
	xor di, di
	mov cx, 0x7D0
	mov ax, 0x220
	pusha
	rep stosw
	mov ax, 0xFFFF
	mov cl, 0x26
	mov di, 0x2A8
	rep stosw
	mov cl, 0x11
.draw_block:
	stosw
	pusha
	mov cl, 0x29
	xor ax, ax
	rep stosw
	mov ax, 0xFFFF
	stosw
	popa
	add di, 0x9E
	loop .draw_block
	mov cl, 0x26
	mov di, 0xD4A
	rep stosw
	popa
	push 0x6
	push cx
	pop di
	pop bp
	call print_food
.input:
	in al, 0x60
	and al, 0xF
	mov bx, 0xA0
	cmp al, 0x8
	jle .up_down
	mov bx, 0x4
.up_down:
	shr al, 0x2
	cmp al, 0x2
	je .minus
	not bx
	inc bx
.minus:
	sub di, bx
.move:
	mov al, 0x9
	cmp BYTE [es:di], 0x7
	sete ah
	je .alive
	cmp BYTE [es:di], 0x20
	jne start
.alive:
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
;	mov di, 0x230
;	inc word [score]
;	mov ax, [score]
;	mov bl, 0xA
;.print_score:
;	div bl
;	xchg al, ah
;	add al, '0'
;	stosb
;	sub di, 0x3
;	mov al, ah
;	xor ah, ah
;	or al, al
;	jnz .print_score
	call print_food
.done:
	pop di
	jmp .input
print_food:
	pusha
.rand:
	mov cx, 0xFFFF
	div ecx
	and dx, 0xFFF
	cmp dx, 0x280
	jge .rand
	push 0x28
	push dx
	push dx
	pop di
	pop ax
	pop cx
	xor dx, dx
	div cx
	cmp dx, 0x12
	jge .rand
	add di, 0xD3
	shl di, 0x2
	cmp BYTE [es:di], 0x9
	je .rand
	mov al, 0x7
	stosb
	popa
	ret
section .bss
;score: resd 1
snake:
