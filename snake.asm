push 0xB800                 ; Push the offset to video memory for DMA (Direct Memory Access)
pop ds                      ; Load the value into the data segment register to access video memory
mov cx, 0xFA0               ; Store the size of the screen in text mode 3 into cx (80x25 characters), also store cp437 values for food and snake body, and the screen width in cl
std                         ; Set the direction flag to reverse for FIFO processing

start:                      ; Start new game setup
    mov ax, 0x3             ; Set ah=0 (change video mode) and al=3 (80x25 16 color text mode)
    int 0x10                ; Trigger Video BIOS interrupt
    mov di, 0x7D0           ; Set the middle of the screen (0xFA0/2) into di as the initial snake position
    mov si, sp              ; Point si to the stack (using the stack pointer) to access user input

.food:                      ; Place new food
    imul bx, sp             ; Multiply bx by sp to pseudo-randomize bx, which points to the food position
    and bx, cx              ; Make bx divisible by 4 to fit on the screen (align with character positions)
    cmp [bx], ch            ; Check if bx points to a position with a snake body character
    je .food                ; If it does, find another random bx
    mov [bx], cl            ; Otherwise, place a food character at that position

.input:                     ; Process keyboard input
    in al, 0x60             ; Read from keyboard input port
    mov bx, 0x4             ; Set default distance for snake movement to 4 (leftwards)
    and al, 0x1E            ; Extract arrow key inputs (up, down, left, right)
    jp $+0x4                ; Skip next instruction if input is an arrow key
    mov bl, cl              ; Use width of screen (cl) as distance for horizontal movement
    and al, 0x14            ; Extract only left and right arrow key inputs
    jz $+0x4                ; Skip next instruction if input is left or right
    neg bx                  ; Invert direction for left or right movement
    sub di, bx              ; Update snake's head position based on movement

    cmp di, cx              ; Check if snake's head position is beyond screen boundaries
    ja start                ; If out of bounds, restart the game
    sar bx, 0x1             ; Divide bx by 2 to prepare for next calculation
    lea ax, [di+bx+0x2]     ; Calculate new position after move (considering screen boundaries)
    div cl                  ; Divide by screen width (cl) to check if a row was crossed
    and ah, ah              ; Check if remainder is zero (horizontal movement check)
    jz start                ; If it is, reset the game

    cmp [di], ch            ; Compare character at new snake position with snake body character
    je start                ; If equal, reset the game (snake hits itself)
    push di                 ; Save new snake head position on the stack
    cmp [di], cl            ; Compare character at new position with food character
    mov [di], ch            ; Move the snake body character to the new position
    je .food                ; If it's food, place new food and skip tail removal

    es lodsw                ; Load the last position (tail) from the stack and pop it into ax
    xchg ax, bx             ; Exchange ax and bx to prepare for tail removal
    mov [bx], ah            ; Move an invisible character instead of the snake body
    jmp SHORT .input        ; Loop back to process more keyboard input
