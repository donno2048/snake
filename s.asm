; register usage during main loop
; DS: 0xB800, segment of screen buffer
; CX: 0xF9C, screen size (80x25x16bit) - 4, used in food generation and the edge checks. CH (0xF) is also the food character
; DX: 0x20A0, DH (0x20) is the empty character, DL (0xA0) is the screen width and also used for the snake character
; DI: position of the snake head (only every second horizontal position is ever used to compensate the speed difference between horizonal and vertical movements)
; SI: memory location on the stack where the current position of the snake tail is stored
std                  ; set direction flag so LODSW moves SI in the same direction as PUSH moves SP, creating a FIFO buffer of snake cells on the stack
mov cx, 0xF9C        ; initialize CX
lds dx, [si+0x7]     ; SI=0x100 at program start in most DOS versions, this loads DS and CX with 4 bytes located at the beginning of the next instruction (offset 0x107)
mov al, [0x20]       ; dummy instruction, machine code from here on is a0 20 00 b8... which is what is needed in DS and DX. LDS saves 1 byte compared to conventional initialization
start:               ; reset game
    mov ax, 0x3      ;   set video mode (AH=0x00) to mode 3 (AL=0x3), text mode 80x25 16 colors
    int 0x10         ;     using BIOS interrupt call, also clears the screen
    mov di, 0x7D0    ;   set head position to screen center
    mov si, sp       ;   set tail pointer to current stack pointer
.food:               ; create new food item
    in ax, 0x40      ;   read 16 bit timer counter into AX for randomization
    and ax, cx       ;     mask with 0xF9C to make AX divisible by 4 and less than CX
    xchg bx, ax      ;     move into BX because indirect addressing is not possible with AX, using XCHG instead of MOV saves 1 byte
    cmp [bx], dh     ;   check if new food position is empty
    jne .food        ;     if not => try again
    mov [bx], ch     ;   place new food item on screen
.input:              ; handle keyboard input
    in al, 0x60      ;   read scancode from keyboard controller - bit 7 is set in case key was released
    imul ax, 0xA     ;   we want to map scancodes for arrow up (0x48/0xC8), left (0x4B/0xCB), right (0x4D/0xCD), down (0x50/0xD0) to movement offsets
    aam 0x6          ;     IMUL, AAM and AAD with some magic constants maps up => -80, left => -2, right => 2, down => 80
    aad 0x76         ;     which is only half the screen offset, but we can use it for the horizontal edge check
    cbw              ;     using arithmetic instructions is more compact than checks and conditional jumps but causes weird snake movements though with other keys
    add di, ax       ; add sign extended offset to head position
    xchg ax, di      ; swap AX and DI, now DI=offset and AX=position+offset
    add di, ax       ; update head position all the way, now DI=position+2*offset
    cmp di, cx       ; check if head crossed vertical edge by comparing against screen size in CX, needs to be done before DIV to avoid exception when DI<0
    ja start         ;   if DI<0 or DI>CX => game over
    div dl           ; divide AX by 160 (width of a screen line)
    cmp ah, cl       ;   check if remainder in AH is > 0x9C, which is the case only when head is on the left edge and movement was right or head is on the right edge and movement was left
    ja start         ;     if so => game over
    xor [di], dl     ; XOR head position with snake character
    jns start        ;   if it already had snake in it, SF=0 from XOR => game over
    push di          ; push new head position onto the stack
    jp .food         ; if food was consumed, PF=1 from XOR => generate new food
    es lodsw         ; no food was consumed so load old tail position into AX and update SI to point to new tail position
    xchg bx, ax      ; move into BX because indirect addressing is not possible with AX, using XCHG instead of MOV saves 1 byte
    mov [bx], dh     ; clear old tail position on screen
    jmp SHORT .input ; loop to keyboard input
