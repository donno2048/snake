org 0x7C00
start:
	push ax
	push ax
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
	push 0x11
	push 0x26
	pop cx
	mov di, 0x2A8
	rep stosw
	pop cx
.draw_block:
	stosw
	pusha
	push 0x29
	pop cx
	xor ax, ax
	rep stosw
	mov ax, 0xFFFF
	stosw
	popa
	add di, 0x9E
	loop .draw_block
	push 0x26
	pop cx
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
	and al, 0x7F
	cmp al, 0x48
	je .up
	cmp al, 0x4B
	je .left
	cmp al, 0x4D
	je .right
	cmp al, 0x50
	jne .input
.down:
	add di, 0xA0
	jmp .move
.right:
	add di, 0x4
	jmp .move
.left:
	sub di, 0x4
	jmp .move
.up:
	sub di, 0xA0
.move:
	mov al, 0x9
	cmp byte [es:di], 0x7
	sete ah
	je .alive
	cmp byte [es:di], ' '
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
	mov si, snake
	add si, bp
	push si
	pop di
	inc di
	inc di
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
	mov al, ' '
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
	push dx
	pop di
	add dx, 0x28
.mod:
	sub dx, 0x28
	cmp dx, 0x28
	jge .mod
	cmp dx, 0x12
	jge .rand
	add di, 0xD3
	shl di, 0x2
	cmp byte [es:di], 0x9
	je .rand
	mov al, 0x7
	stosb
	popa
	ret
section .bss
;score: resd 1
snake:
