; register usage during main loop
; DS: 0xB800, segment of screen buffer
; BX: position of the snake head
; DX: 0x200A, DH used for clearing old snake tiles, DL used for magic IMUL and DX used for wall building
; SI: 0x7D0, screen size (40x25x2 bytes), used in food generation, edge checks, also used for screen accesses but constantly reinitialized
; DI: pointer to memory location where the current position of the snake head is stored
; SP: pointer to memory location where the current position of the snake tail is stored
lds di, [BYTE bx+si+0x0]      ; SI=0x100 and BX=0x0 at program start, this initializes DS and DI and the 0 serves as a dummy byte for the LDS itself as machine code at 0x100 is 0xC5,0x78,0x00,0xB8
start:                        ; reset game
    mov ax, 0x200A            ;   first byte of the instruction is 0xB8 used for LDS, also sets AX to the initial value for DX to swap later: DH set to empty space, DL to 0xA, DX satisfies DX*8%0x10000=0x50 so good for the wall building
    cwd                       ;   set DX to 0x0 to swap later with AX to set video mode (AH=0x0) to mode 0 (AL=0x0), text mode 40x25 16 colors
    xchg ax, dx               ;   swap AX and DX
    int 0x10                  ;   set video mode using BIOS interrupt call, also clears the screen
    mov sp, di                ;   set SP to current head pointer
    lodsw                     ;   set AX to 0x720 and advance SI so that after `SUB SI, AX` the SI register will contain a valid food position
    mov bx, [BYTE bx+si+0x50] ;   reset head position, the address always points to a valid screen position containing 0x720 after setting video mode, also `POP AX`, `PUSH AX` when jumping to .food-2
.food:                        ; create new food item, always jumping to .food-2 for doing the `POP & PUSH`
    sub si, ax                ;     make the food position a little more random
    add [si], cl              ;   place food item by applying ADD with CL
.input:                       ; handle keyboard input
    mov si, 0x7D0             ; initialize SI
    in al, 0x60               ;   read scancode from keyboard controller - bit 7 is set in case key was released
    imul dl                   ;   we want to map scancodes for arrow up (0x48/0xC8), left (0x4B/0xCB), right (0x4D/0xCD), down (0x50/0xD0) to movement offsets
    aam 0x14                  ;     IMUL (AH is irrelevant here), AAM and AAD with some magic constants maps up => -80, left => -2, right => 2, down => 80
    aad 0x44                  ;     using arithmetic instructions is more compact than checks and conditional jumps
    cbw                       ;     but causes weird snake movements though with other keys
    add ax, bx                ; set AX to new head position
    cmp ax, si                ; check if head crossed vertical edge by comparing against SI
    stosw                     ; store head position (SS=ES by default) and advance head pointer
    xchg ax, bx               ; save new head position to BX
    rcr BYTE [bx], 0x1        ; RCR head position to set snake character
    jno start                 ;   if it already had snake or wall in it or if it crossed a vertical edge, OF=0 from RCR => game over
    jc .food-2                ; if food was consumed, CF=1 from RCR => generate new food
.wall:                        ; draw an invisible wall on the left side
    sub si, dx                ;   go one line and 0x2000 bytes backwards (the added bytes wrap nicely as 0x10000%0x2000=0)
    mov [si], cl              ;   store wall character
    jnz .wall                 ; jump to draw the next wall
    pop si                    ; no food was consumed so pop tail position into SI
    mov [si], dh              ; clear old tail position on screen
    jns .input                ; loop to keyboard input, SF=0 from SUB
