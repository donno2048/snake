; register usage during main loop
; DS: 0xB800, segment of screen buffer
; BX: 0x7D0, screen size (40x25x2 bytes), used in food generation, edge checks, also used for screen accesses but constantly reinitialized
; SI: position of the snake head
; DI: pointer to memory location where the current position of the snake head is stored
; SP: pointer to memory location where the current position of the snake tail is stored
lds di, [bx+si]         ; SI=0x100 and BX=0x0 at program start, this initializes DS and DI (machine code at 0x100 is c5 38 00 b8)
db 0x0                  ; dummy byte for LDS. this with 'mov ax, 0x0' is actually 'add [bx+si+0x0], bh' but player dies immediately and loop returns to start
start:                  ; reset game
    mov ax, 0x0         ;   set video mode (AH=0x00) to mode 0 (AL=0x0), text mode 40x25 16 colors
    int 0x10            ;     using BIOS interrupt call, also clears the screen
    mov si, [bx]        ;   reset head position, BX always points to a valid screen position containing 0x720 after setting video mode
    mov sp, di          ;   set SP to current head pointer
.food:                  ; create new food item
    in ax, 0x40         ;   read 16 bit timer counter into AX for randomization
    and bx, ax          ;     mask with BX to make divisible by 4 and less than or equal to screen size
    xor [bx], cl        ;   place food item and check if position was empty by applying XOR with CL (assumed to be 0xFF)
.input:                 ; handle keyboard input
    mov bx, 0x7D0       ; initialize BX
    jp .food            ;     if position was occupied by snake or wall in food generation => try again, if we came from main loop PF=0
    in al, 0x60         ;   read scancode from keyboard controller - bit 7 is set in case key was released
    imul ax, BYTE 0xA   ;   we want to map scancodes for arrow up (0x48/0xC8), left (0x4B/0xCB), right (0x4D/0xCD), down (0x50/0xD0) to movement offsets
    aam 0x14            ;     IMUL (AH is irrelevant here), AAM and AAD with some magic constants maps up => -80, left => -2, right => 2, down => 80
    aad 0x44            ;     using arithmetic instructions is more compact than checks and conditional jumps
    cbw                 ;     but causes weird snake movements though with other keys
    add ax, si          ; set AX to new head position
    cmp ax, bx          ; check if head crossed vertical edge by comparing against BX
    stosw               ; store head position (SS=ES by default) and advance head pointer
    xchg ax, si         ; save new head position to SI
    xlatb               ; set AL to 0x20 as BX+AL will always be empty
    adc [si], al        ; ADC head position with 0x20 to set snake character
    jnp start           ;   if it already had snake or wall in it or if it crossed a vertical edge, PF=0 from ADC => game over
    jz .food            ; if food was consumed, ZF=1 from ADC => generate new food
.wall:                  ; draw an invisible wall on the left side
    sub bx, BYTE 0x50   ;   go one line backwards
    mov [bx], cl        ;   store wall character
    jns .wall           ; jump to draw the next wall
    pop bx              ; no food was consumed so pop tail position into BX
    mov [bx], al        ; clear old tail position on screen
    jnp .input          ; loop to keyboard input, PF=0 from SUB
