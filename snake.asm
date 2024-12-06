; register usage during main loop
; DS: 0xB800, segment of screen buffer
; BX: 0x7D0, screen size (40x25x2 bytes), used in food generation, edge checks, also used for screen accesses but constantly reinitialized
; DX: 0x200A, DH used for clearing old snake tiles, DL used for magic IMUL and DX used for wall building
; SI: position of the snake head
; DI: pointer to memory location where the current position of the snake head is stored
; SP: pointer to memory location where the current position of the snake tail is stored
db 0xC5, 0x78, 0x00     ; encodes `LDS DI, [BX+SI+0]` (hardcoded since nasm always drops the 0) SI=0x100 and BX=0x0 at program start, this initializes DS and DI and the 0 serves as a a dummy byte for the LDS
start:                  ; reset game
    mov ax, 0x200A      ;   first byte of the instruction is 0xB8 used for LDS, also sets AX to the initial value for DX to swap later: DH set to empty space, DL to 0xA, DX satisfies DX*8%0x10000=0x50 so good for the wall building
    cwd                 ;   set DX to 0x0 to swap later with AX to set video mode (AH=0x0) to mode 0 (AL=0x0), text mode 40x25 16 colors
    xchg ax, dx         ;   swap AX and DX
    int 0x10            ;   using BIOS interrupt call, also clears the screen
    mov si, [bx]        ;   reset head position, BX always points to a valid screen position containing 0x720 after setting video mode
    mov sp, di          ;   set SP to current head pointer
.food:                  ; create new food item
    in ax, 0x40         ;   read 16 bit timer counter into AX for randomization
    and bx, ax          ;     mask with BX to make divisible by 4 and less than or equal to screen size
    add [bx], cl        ;   place food item and check if position was empty by applying ADD with CL (assumed to be 0xFF)
.input:                 ; handle keyboard input
    mov bx, 0x7D0       ; initialize BX
    js .food            ;     if position was occupied by snake or wall in food generation => try again, if we came from main loop SF=0
    in al, 0x60         ;   read scancode from keyboard controller - bit 7 is set in case key was released
    imul dl             ;   we want to map scancodes for arrow up (0x48/0xC8), left (0x4B/0xCB), right (0x4D/0xCD), down (0x50/0xD0) to movement offsets
    aam 0x14            ;     IMUL (AH is irrelevant here), AAM and AAD with some magic constants maps up => -80, left => -2, right => 2, down => 80
    aad 0x44            ;     using arithmetic instructions is more compact than checks and conditional jumps
    cbw                 ;     but causes weird snake movements though with other keys
    add ax, si          ; set AX to new head position
    cmp ax, bx          ; check if head crossed vertical edge by comparing against BX
    stosw               ; store head position (SS=ES by default) and advance head pointer
    xchg ax, si         ; save new head position to SI
    rcr BYTE [si], 0x1  ; RCR head position to set snake character
    jno start           ;   if it already had snake or wall in it or if it crossed a vertical edge, OF=0 from RCR => game over
    jc .food            ; if food was consumed, CF=1 from RCR => generate new food
.wall:                  ; draw an invisible wall on the left side
    sub bx, dx          ;   go one line and 0x2000 bytes backwards (the added bytes wrap nicely as 0x10000%0x2000=0)
    mov [bx], cl        ;   store wall character
    jnz .wall           ; jump to draw the next wall
    pop bx              ; no food was consumed so pop tail position into BX
    mov [bx], dh        ; clear old tail position on screen
    jns .input          ; loop to keyboard input, SF=0 from SUB
