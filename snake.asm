; register usage during main loop
; DS: 0xB800, segment of screen buffer
; BX: 0x7D0, screen size (40x25x2 bytes), used in food generation, edge checks, also used for screen accesses but constantly reinitialized
; DX: 0x200A, DH used for creating and clearing snake tiles, DL used for magic IMUL and DX used for wall building
; SI: snake head offset from the end of the screen
; DI: pointer to memory location where the current position of the snake head is stored
; SP: pointer to memory location where the current position of the snake tail is stored
lds di, [BYTE bx+si]     ; SI=0x100 and BX=0x0 at program start, this initializes DS and DI, using the BYTE prefix adds a 0 byte that serves as a dummy byte for the LDS itself as machine code at 0x100 will be 0xC5,0x78,0x00,0xB8
start:                   ; used for game reset
    mov ax, 0x200A       ; first byte of the instruction is 0xB8 used for LDS, also sets AX to the initial value for DX to swap later: DH set to empty space, DL to 0xA, DX satisfies DX*8%0x10000=0x50 so good for the wall building
    cwd                  ; set DX to 0x0 to swap later with AX to set video mode (AH=0x0) to mode 0 (AL=0x0), text mode 40x25 16 colors
    xchg ax, dx          ; swap AX and DX
    int 0x10             ; set video mode using BIOS interrupt call, also clears the screen
    pop si               ; reset head position offset, we can use POP as even if the POPed position is deadly it is not a problem because we address the head as SI+BX, then STOSW puts it in the stack, so the next head position is essentially randomized by repeated addition with BX
    mov sp, di           ; set SP to current head pointer
.food:                   ; create new food item
    daa                  ; using DAA here makes it so POP BX won't override initial food, using DAA and not AAA or something ensures AX won't go to 0
    xchg ax, bx          ; AX now holds the last position we tried putting food at, also, alternating BX between the last head position (not to iterate over the same food locations) and the end of the screen
    dec bh               ; decreasing BH for randomization ensures BX is still divisble by 2 and if the snake isn't filling all the possible options, below 0x7D0
.input:                  ; handle keyboard input
    stosw                ; using STOSW here enlarges snake when looping into .food otherwise makes it stay the same size (because we later POP BX), also, because AX contains last unsuccessful food position this will push that position into the stack essentially clearing it (at `mov [bx], dh`), even though it's not necessary, also, sets new value for the POP BX at initialization, but the main purpose is to store old head position and advance head pointer when coming from .wall
    xor [bx], cl         ; place food item and check if position was empty by applying XOR with CL
    jp .food             ; if position was occupied by snake or wall in food generation => try again
    pop bx               ; pop tail or unsuccesful food item position into SI
    mov [bx], dh         ; clear old tail or unsucceful food on screen
    mov bx, 0x7D0        ; initialize BX
    in al, 0x60          ; read scancode from keyboard controller - bit 7 is set in case key was released
    imul dl              ;   we want to map scancodes for arrow up (0x48/0xC8), left (0x4B/0xCB), right (0x4D/0xCD), down (0x50/0xD0) to movement offsets
    aam 0x14             ;     IMUL (AH is irrelevant here), AAM and AAD with some magic constants maps up => -80, left => -2, right => 2, down => 80
    aad 0x44             ;     using arithmetic instructions is more compact than checks and conditional jumps
    cbw                  ;     but causes weird snake movements though with other keys
    xadd si, ax          ; set AX to offset of old head position and SI to new offset
    add ax, bx           ; set AX to old head position, also, checks if head crossed vertical edge, since AX is between -0x7D0 and 0 if inside the screen so after the ADD we get CF=1 iff head is in the screen
    adc [bx+si], dh      ; ADC head position (0x7D0 + offset) to set snake character
    jnp start            ; if it already had snake or wall in it or if it crossed a vertical edge, PF=0 from ADC => game over
.wall:                   ; draw an invisible wall on the left side
    jz .input            ; if we got ZF=1 from ADC (food item taken) we jump to .input with BX=0x7D0 so the XOR will set PF=1 and we will enter food generation loop, if we got ZF=1 from the SUB, we jump with BX=0 so we won't add a new food item
    mov [bx], cl         ; set all wall position characters to 0
    sub bx, dx           ; makes us go an eighth of a row and 0x2000 bytes backwards (the added bytes wrap nicely as 0x10000=0x2000*8) [using DX like that - and not 0x50 - makes this loop a delay loop also]
    jmp SHORT .wall      ; jump to draw next wall
