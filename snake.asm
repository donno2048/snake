org 0x7C00
start:
	mov ds, ax
	mov ss, ax
	mov ax, 0xB800
	mov es, ax
	xor di, di
	mov cx, 0x7D0
	mov ax, 0xE20
	pusha
	rep stosw
	mov ax, 0x2FE
	mov cx, 0x26
	mov di, 0x2A8
	mov ah, 0x77
	rep stosw
	mov cx, 0x11
.draw_block:
	stosw
	pusha
	mov cx, 0x29
	xor ah, ah
	rep stosw
	mov ah, 0x77
	stosw
	popa
	add di, 0x9E
	loop .draw_block
	mov cx, 0x26
	mov di, 0xD4A
	rep stosw
	popa
	mov di, cx
	mov bp, 0x6
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
	push ds
	pop es
	mov cx, bp
	inc cx
	mov si, snake
	add si, bp
	mov di, si
	inc di
	inc di
	std
	rep movsb
	cld
	pop es
	popa
	push di
	mov [snake], di
	cmp ah, 0x1
	je .food
	mov di, [snake+bp]
	mov al, ' '
	stosb
	jmp .done
.food:
	inc bp
	inc bp
	mov di, 0x230
	add word [score], 0x1
	mov ax, [score]
	mov bl, 0xA
.print_score:
	div bl
	xchg al, ah
	add al, '0'
	stosb
	sub di, 0x3
	mov al, ah
	xor ah, ah
	or al, al
	jnz .print_score
	call print_food
.done:
	pop di
	jmp .input
print_food:
	pusha
.rand:
	mov di, 0xAB ; FIXME: not random
	; cannot use clock cycles because it's 1 so it doesn't change dramatically
	; cannot use drivers because there aren't any
	; cannot use rdrand, rdseed etc. because it's too slow and we're on 1 cycle
	; cannot use garbage memory because it's all set to zero on dosbox
	cmp di, 0x0 ; overflow protection - we won't remove the add on line 133 even though we use that because then the mod calculation will be too long
	jl .rand
	cmp di, 0x280
	jge .rand
	mov dx, di
	add dx, 0x28
.mod:
	sub dx, 0x28
	cmp dx, 0x28
	jge .mod
	cmp dx, 0x12
	jge .rand
	add di, 0xD3
	shl di, 0x2
	mov al, 0x7
	stosb
	popa
	ret
section .bss
score: resd 1
snake: