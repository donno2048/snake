push 0xB800             ; Push the offset to video memory for DMA (Direct Memory Access)
pop ds                  ; Load the value into the data segment register to access video memory
mov cx, 0xFA0           ; Store the screen size (80x25 characters) in text mode 3 into cx, also hold cp437 values for food and snake body, and the screen width in cl
std                     ; Set the direction flag to reverse the operation of lodsw for FIFO processing
start:                  ; Start new game setup
mov ax, 0x3             ; Set ah=0 (change video mode) and al=3 (80x25 16 color text mode)
int 0x10                ; Initiate Video BIOS interrupt
mov di, 0x7D0           ; Set the initial position of the snake's head at the middle of the screen (0xFA0/2)
mov si, sp              ; Setting si to the stack pointer for loading stack data using lodsw
.food:                  ; Position new food
imul bx, sp             ; Multiply bx by sp to pseudo-randomize bx, which points to the food position
and bx, cx              ; Make bx divisible by 4 to fit on the screen (align with character positions). After anding, we now know that bx < cx (size of the screen) therefore it fits inside
cmp [bx], ch            ; Compare character at memory location indicated by bx with snake body character
; Check if the calculated position (bx) is already occupied by the snake body
; If true generate a new random position for placing food by jumping to the .food label
je .food                ; If the comparison is true, jump to .food label to generate new food position
mov [bx], cl            ; Place a food character at the calculated position
; Now that we've ensured the calculated position (bx) is valid and not occupied,
; we can place a food character at that location on the display to indicate the new position for the snake's food
.input:                 ; Process keyboard input
in al, 0x60             ; Read keyboard input from port 0x60
mov bx, 0x4             ; Set default distance for snake movement to 4 (leftwards)
and al, 0x1E            ; Mask out non-arrow key bits (up, down, left, right)
jp $+0x4                ; Jump if the parity flag is set (skip the next instruction if input is an arrow key)
mov bl, cl              ; Set distance for horizontal movement based on screen width (cl)
and al, 0x14            ; Extract only the left and right arrow key bits
jz $+0x4                ; Jump if the zero flag is set (skip the next instruction if input is left or right)
neg bx                  ; Invert direction for left or right movement
sub di, bx              ; Update snake's head position based on movement
cmp di, cx              ; Check if snake's head position is beyond screen boundaries
ja start                ; If out of bounds, restart the game
; The comparison is unsigned (ja) to determine if snake's head has moved beyond screen boundaries
; In unsigned comparisons, only the magnitude of the values is considered, rather their signs
; this is crucial, because memory addresses like di are treated as unsigned, so the comparison
; ensures that if di > cx (screen size) or di < 0, the jump will happen, preventing the snake from
; moving outside the screen area.
sar bx, 0x1             ; Shift the value in bx right by 1 bit (right arithmetic shift)
lea ax, [di+bx+0x2]     ; Calculate the new position after movement, considering screen boundaries
div cl                  ; Divide by screen width (cl) to check if a row was crossed
and ah, ah              ; Check if the remainder is zero (horizontal movement check)
jz start                ; If it is, reset the game
cmp [di], ch            ; Compare the character at the new snake position with the snake body character
je start                ; If equal, reset the game (snake hits itself)
push di                 ; Save the new snake head position on the stack
cmp [di], cl            ; Compare the character at the new position with the food character
mov [di], ch            ; Move the snake body character to the new position
je .food                ; If it's food, place new food and skip tail removal
es lodsw                ; Load the previous position (tail) from the stack into ax
; The instruction above retrieves the last position of the snake's tail from the stack,
; using the fact that si was set to point to the stack (mov si, sp)
; After loading the value with lodsw, the stack pointer (sp) needs manual adjustment
; to "pop" the read value, ensuring proper stack management
xchg ax, bx             ; Swap the values of ax and bx for tail removal
; The values of ax and bx are exchanged to facilitate tail removal
; Now bx holds the stack pointer, effectively "popping" the read position from the stack,
; and ax contains the loaded tail position that will be used to remove the tail
mov [bx], ah            ; Erase the tail character at the memory location indicated by bx
; This line updates the display by replacing the tail character at its previous position
; with an invisible character. This process is vital for simulating the snake's movement;
; as the snake advances, its tail is effectively removed from its previous location,
; creating the illusion of continuous motion, (just like in original snake game)
jmp SHORT .input        ; Loop back to process more keyboard input
