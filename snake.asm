		org 100h
	start:
		mov ax, 0
		mov word [score], ax
		mov byte [is_game_over], al
		mov al, 8
		mov byte [snake_direction], al
		mov al, 40
		mov byte [snake_head_x], al
		mov byte [snake_head_previous_x], al
		mov byte [snake_tail_previous_x], al
		mov byte [snake_tail_x], al
		mov al, 15
		mov byte [snake_head_y], al
		mov byte [snake_head_previous_y], al
		mov byte [snake_tail_y], al
		mov byte [snake_tail_previous_y], al
		mov bx, 0
	.next:	
		mov byte [buffer + bx], ' '
		inc bx
		cmp bx, 2000
		jnz .next
		mov di, 0
	.next_x:
		mov byte [buffer + di], 255
		mov byte [buffer + 80 + di], 196
		mov byte [buffer + 1920 + di], 196
		inc di
		cmp di, 80
		jnz .next_x
		mov di, 0
	.next_y:
		mov byte [buffer + 80 + di], 179
		mov byte [buffer + 159 + di], 179
		add di,80
		cmp di, 2000
		jnz .next_y
	.corners:
		mov byte [buffer + 80], 218
		mov byte [buffer + 159], 191
		mov byte [buffer + 1920], 192
		mov byte [buffer + 1999], 217
		mov cx, 10
	.again:
		push cx
		call create_food
		pop cx
		loop .again
	.main_loop:
		mov si, 2
		call sleep
		call update_snake_direction
		mov al, [snake_head_y]
		mov byte [snake_head_previous_y], al
		mov al, [snake_head_x]
		mov byte [snake_head_previous_x], al
		mov ah, [snake_direction]
		cmp ah, 8
		jz .up
		cmp ah, 4
		jz .down
		cmp ah, 2
		jz .left
		cmp ah, 1
		jz .right
	.up:
		dec word [snake_head_y]
		jmp .end
	.down:
		inc word [snake_head_y]
		jmp .end
	.left:
		dec word [snake_head_x]
		jmp .end
	.right:
		inc word [snake_head_x]
	.end:
		mov bl, [snake_direction]
		mov ch, 0
		mov cl, [snake_head_previous_x]
		mov dl, [snake_head_previous_y]
		call buffer_write
		call check_snake_new_position
		call print_score
		call buffer_render
		mov al, [is_game_over]
		cmp al, 0
		jz .main_loop
		jmp start
	sleep:
			mov ah, 0
			int 1ah
			mov bx, dx
		.wait:
			mov ah, 0
			int 1ah
			sub dx, bx
			cmp dx, si
			jl .wait
			ret
	clear_keyboard_buffer:
			mov ah, 1
			int 16h
			jz .end
			mov ah, 0h
			int 16h
			jmp clear_keyboard_buffer
		.end:
			ret
	exit_process:
			mov ah, 4ch
			int 21h
			ret
	buffer_write:
		mov di, buffer
		mov al, 80
		mul dl
		add ax, cx
		add di, ax
		mov byte [di], bl
		ret
	buffer_read:
		mov di, buffer
		mov al, 80
		mul dl
		add ax, cx
		add di, ax
		mov bl, [di]
		ret
	buffer_print_string:
		.next:
			mov al, [si]
			cmp al, 0
			jz .end
			inc si
			jmp .next
		.end:
			ret
	buffer_render:
			mov ax, 0b800h
			mov es, ax
			mov di, buffer
			mov si, 0
		.next:
			mov bl, [di]
			cmp bl, 8
			jz .is_snake
			cmp bl, 4
			jz .is_snake
			cmp bl, 2
			jz .is_snake
			cmp bl, 1
			jz .is_snake
			jmp .write
		.is_snake:
			mov bl, 219
		.write:
			mov byte [es:si], bl
			inc di
			add si, 2
			cmp si, 4000
			jnz .next
			ret
	print_score:
			mov di, 0
			call buffer_print_string
			mov ax, [score]
			mov di, 13
		.next_digit:
			xor dx, dx
			mov bx, 10
			div bx
			push ax
			mov al, dl
			add al, 48
			mov byte [buffer + di], al
			pop ax
			dec di
			cmp ax, 0
			jnz .next_digit
			ret
	update_snake_direction:
			mov ah, 1
			int 16h
			jz .end
			mov ah, 0h
			int 16h
			cmp ah, 48h
			jz .up
			cmp ah, 50h
			jz .down
			cmp ah, 4bh
			jz .left
			cmp ah, 4dh
			jz .right
			jmp update_snake_direction
		.up:
			mov byte [snake_direction], 8
			jmp update_snake_direction
		.down:
			mov byte [snake_direction], 4
			jmp update_snake_direction
		.left:
			mov byte [snake_direction], 2
			jmp update_snake_direction
		.right:
			mov byte [snake_direction], 1
			jmp update_snake_direction
		.end:
			ret
	check_snake_new_position:
			mov ch, 0
			mov cl, [snake_head_x]
			mov dh, 0
			mov dl, [snake_head_y]
			call buffer_read
			cmp bl, 8
			jle .set_game_over
			cmp bl, '*'
			je .food
			cmp bl, ' '
			je .empty_space
		.set_game_over:
			cmp al, 1
			mov byte [is_game_over], al 
		.write_new_head:
			mov bl, 1
			mov ch, 0
			mov cl, [snake_head_x]
			mov ch, 0
			mov dl, [snake_head_y]
			call buffer_write
			ret
		.food:
			inc dword [score]
			call .write_new_head
			call create_food
			jmp .end
		.empty_space:
			call update_snake_tail
			call .write_new_head
		.end:
			ret
	update_snake_tail:
			mov al, [snake_tail_y]
			mov byte [snake_tail_previous_y], al
			mov al, [snake_tail_x]
			mov byte [snake_tail_previous_x], al
			mov ch, 0
			mov cl, [snake_tail_x]
			mov dh, 0
			mov dl, [snake_tail_y]
			call buffer_read
			cmp bl, 8
			jz .up
			cmp bl, 4
			jz .down
			cmp bl, 2
			jz .left
			cmp bl, 1
			jz .right
			jmp exit_process
		.up:
			dec word [snake_tail_y]
			jmp .end
		.down:
			inc word [snake_tail_y]
			jmp .end
		.left:
			dec word [snake_tail_x]
			jmp .end
		.right:
			inc word [snake_tail_x]
		.end:
			mov bl, ' '
			mov ch, 0
			mov cl, [snake_tail_previous_x]
			mov ch, 0
			mov dl, [snake_tail_previous_y]
			call buffer_write
		ret
	create_food:
		.try_again:
			mov ah, 0
			int 1ah
			mov ax, dx
			and ax, 0fffh
			mul dx
			mov dx, ax
			mov ax, dx
			mov cx, 2000
			xor dx, dx
			div cx
			mov bx, dx
			mov di, buffer
			mov al, [di + bx]
			cmp al, ' '
			jnz .try_again
			mov byte [di + bx], '*'
			ret
section .bss
		score resw 1
		is_game_over resb 1
		snake_direction resb 1
		snake_head_x resb 1
		snake_head_y resb 1
		snake_head_previous_x resb 1
		snake_head_previous_y resb 1
		snake_tail_x resb 1
		snake_tail_y resb 1
		snake_tail_previous_x resb 1
		snake_tail_previous_y resb 1
		buffer resb 2000
