; register usage during main loop
; DS: 0xB800, segment of screen buffer
; CX: 0xFA0, size of the screen (80x25x16bit). CH (0xF) is also used as the snake character, CL (0xA0) as the food character and the screen width
; DI: position of the snake head (only every second horizontal position is ever used to compensate the speed difference between horizonal and vertical movements)
; SI: memory location on the stack where the current position of the snake tail is stored
std                        ; set direction flag so LODSW moves SI in the same direction as PUSH moves SP, creating a FIFO buffer of snake cells on the stack
lds cx, [si+0x4]           ; SI=0x100 at program start in most DOS versions, this loads DS and CX with 4 bytes located at the beginning of the next instruction (offset 0x104)
mov al, [0xF]              ; dummy instruction, machine code from here on is a0 0f 00 b8... which is what is needed in DS and CX. LDS saves 1 byte compared to conventional initialization
start:                     ; reset game
    mov ax, 0x3            ;   set video mode (AH=0x00) to mode 3 (AL=0x3), text mode 80x25 16 colors
    int 0x10               ;     using BIOS interrupt call, also clears the screen
    mov di, 0x7D0          ;   set head position to screen center
    mov si, sp             ;   set tail pointer to current stack pointer
.food:                     ; create new food item
    in ax, 0x40            ;   read 16 bit timer counter into AX for randomization
    and ax, cx             ;     mask with screen size (this causes food to appear off screen if the timer counter is exactly 0xFA0 but saves 1 byte compared to AND AX, 0xF9C)
    xchg bx, ax            ;     move into BX because indirect addressing is not possible with AX, using XCHG instead of MOV saves 1 byte
    cmp [bx], ch           ;   check if new food position is occupied by snake
    je .food               ;     if so => try again
    mov [bx], cl           ;   place new food item on screen
.input:                    ; handle keyboard input
    in al, 0x60            ;   read scancode from keyboard controller - bit 7 is set in case key was released
    inc ax                 ;   we want to map scancodes for arrow up (0x48/0xC8), left (0x4B/0xCB), right (0x4D/0xCD), down (0x50/0xD0) to movement offsets on screen
    aam 0x4                ;     INC, AAM, AAD, ADD with some magic constants map scancodes to intermediate result, up => -40, left => -1, right => 1, down => 40
    aad 0x28               ;     using arithmetic instructions is more compact than checks and conditional jumps to evaluate the keyboard input
    add al, 0x7            ;     this method causes weird snake movements though when other keys than the arrow keys are pressed
    cbw                    ;   sign extend intermediate result and multiply by -4 into BX to get the final offset (+-160 / +-4)
    imul bx, ax, BYTE -0x4 ;     negative 4 because it is subtracted from the head position
    sub di, bx             ; update head position with calculated offset, SUB with negative offset rather than ADD so LEA with based index addressing can be used below
    cmp di, cx             ; check if head crossed vertical edge by comparing against screen size in CX
    jae start              ;   if CF=0, which is the case when DI<0 or DI>=CX => game over
    sar bx, 0x1            ; check if head crossed horizontal edge, use SAR to divide movement offset by 2
    lea ax, [di+bx+0x2]    ;   AX=position+2+offset/2
    div cl                 ;   divide AX by 160 (width of a screen line)
    and ah, ah             ;   check if remainder in AH is 0, which is the case only when head is on the left edge and movement was right (-4) or head is on the right edge and movement was left (4)
    jz start               ;     if so => game over
    cmp [di], ch           ; check if head position already contains snake
    je start               ;   if so => game over
    push di                ; push new head position onto the stack
    cmp [di], cl           ; check if head position contains food item
    mov [di], ch           ;   and place snake character onto screen
    je .food               ; if food was consumed => generate new food
    es lodsw               ; no food was consumed so load old tail position into AX and update SI to point to new tail position
    xchg ax, bx            ; swap AX and BX, BX now contains old tail position and AX previous movement offset
    mov [bx], ah           ; high byte of movement offset is either 0x00 or 0xFF, which are invisible characters and can be used to clear old tail on screen saving 1 byte compared to immediate MOV
    jmp SHORT .input       ; loop to keyboard input
