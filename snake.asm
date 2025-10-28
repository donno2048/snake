; register usage during main loop
; DS: 0xB800, segment of screen buffer
; SI: 0x7D0, screen size (40x25x2 bytes), used in food generation, edge checks, also used for screen accesses but constantly reinitialized
; DX: 0x200A, DH used for creating and clearing snake tiles, DL used for magic IMUL and DX used for wall building
; BX: snake head offset from the end of the screen
; DI: pointer to memory location where the current position of the snake head is stored
; SP: pointer to memory location where the current position of the snake tail is stored
start:                   ; used for game reset
    lds di, [BYTE bx+si] ; SI=0x100 and BX=0x0 at program start, this initializes DS and DI, using the BYTE prefix adds a 0 byte that serves as a dummy byte for the LDS itself as machine code at 0x100 will be 0xC5,0x78,0x00,0xB8
    mov ax, 0x200A       ; first byte of the instruction is 0xB8 used for LDS, also sets AX to the initial value for DX to swap later: DH set to empty space, DL to 0xA, DX satisfies DX*8%0x10000=0x50 so good for the wall building
    cwd                  ; set DX to 0x0 to swap later with AX to set video mode (AH=0x0) to mode 0 (AL=0x0), text mode 40x25 16 colors
    xchg ax, dx          ; swap AX and DX
    int 0x10             ; set video mode using BIOS interrupt call, also clears the screen
    pop bx               ; reset head position offset, we can use POP as even if the POPed position is deadly it is not a problem because we address the head as SI+BX, so the next head position is essentially randomized by repeated addition with SI
    mov sp, di           ; set SP to current head pointer
.food:                   ; create new food item
    add ah, cl           ; decreasing AH for randomization ensures SI is still divisble by 2 and if the snake isn't filling all the possible options, below 0x7D0
    xchg ax, si          ; alternate SI between the last head position (not to iterate over the same food locations) and the end of the screen
    xor [si], cl         ; place food item and check if position was empty by applying XOR with CL
    jp .food             ; if position was occupied by snake or wall in food generation => try again
.input:                  ; handle keyboard input
    mov si, 0x7D0        ; initialize SI
    in al, 0x60          ; read scancode from keyboard controller - bit 7 is set in case key was released
    imul dl              ;   we want to map scancodes for arrow up (0x48/0xC8), left (0x4B/0xCB), right (0x4D/0xCD), down (0x50/0xD0) to movement offsets
    aam 0x14             ;     IMUL (AH is irrelevant here), AAM and AAD with some magic constants maps up => -80, left => -2, right => 2, down => 80
    aad 0x44             ;     using arithmetic instructions is more compact than checks and conditional jumps
    cbw                  ;     but causes weird snake movements though with other keys
    xadd bx, ax          ; set AX to offset of old head position and BX to new offset
    add ax, si           ; set AX to old head position, also, checks if head crossed vertical edge, since AX is between -0x7D0 and 0 if inside the screen so after the ADD we get CF=1 iff head is in the screen
    stosw                ; store old head position (SS=ES by default) and advance head pointer
    adc [bx+si], dh      ; ADC head position (0x7D0 + offset) to set snake character
    jz .food             ; if food was consumed, ZF=1 from ADC => generate new food
    jnp start-0x4B       ; if it already had snake or wall in it or if it crossed a vertical edge, PF=0 from ADC => game over, going to `start-0x4B` adds 0x4B null bytes before the LDS thus changing it into 0x25 (=(0x4b-1)/2) repetitions of `add [bx+si],al` which we don't care for as there's an `int 0x10` afterwards to clear the screen, then, `add ch,al` which also doesn't matter as CH's only affect is the wall color (as we'll soon show) which we don't care for, then `js $+2` which is practically a NOP, then we continue at `start`, also after doing JNZ to .wall-1 we get here byte 0x89
.wall:                   ; draw an invisible wall on the left side
    or al, 0x29          ; it's obvious this instruction will always set ZF=0
    salc                 ; we don't care about AL at this point so this is practically a NOP, however, after `jnz .wall-1` we get the bytes 0x89 (from the JNP), 0x0C,0x29 (from the OR) and then 0xD6 (from this SALC) which encode the instruction `mov [si], cx`, `sub si, dx`, the new SUB makes us go one line and 0x2000 bytes backwards (the added bytes wrap nicely as 0x10000%0x2000=0) [using DX like that - and not 0x50 - makes this loop a delay loop also] and the new MOV sets all wall position characters to 0
    jnz .wall-0x1        ; on first enrty to .wall this will always jump as ZF=0 from OR, after the first loop it jumps to draw the next wall because we jump to .wall-1 and will stop at the last wall at DS:0
    pop si               ; no food was consumed so pop tail position into SI
    mov [si], dh         ; clear old tail position on screen
    jns .input           ; loop to keyboard input, SF=0 from SUB
