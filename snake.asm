push 0xb800
pop ds
mov cx, 0xfa0
start:
mov ax, 0x3
int 0x10
mov di, 0x7d0
lea si, [bp-4]
.food:
imul bx, bp
and bx, cx
cmp [bx], ch
je .food
mov [bx], cl
.input:
in al, 0x60
mov bx, 0x4
and al, 0x1e
jp $+4
mov bl, cl
and al, 0x14
jz $+4
neg bx
sub di, bx
cmp di, cx
ja start
sar bx, 1
lea ax, [di+bx+2]
div cl
and ah, ah
jz start
cmp [di], ch
je start
mov [bp], di
add bp, 2
cmp [di], cl
mov [di], ch
je .food
es lodsw
xchg ax, bx
mov [bx], ah
jmp .input
