; register usage during main loop
; DS: 0xB800, segment of screen buffer
; SI: 0x7D0, screen size (40x25x2 bytes), used in food generation, edge checks, also used for screen accesses but constantly reinitialized
; DX: 0x200A, DH used for clearing old snake tiles, DL used for magic IMUL and DX used for wall building
; BX: position of the snake head
; DI: pointer to memory location where the current position of the snake head is stored
; SP: pointer to memory location where the current position of the snake tail is stored
lds di, [BYTE bx+si+0x0] ; SI=0x100 and BX=0x0 at program start, this initializes DS and DI and the 0 serves as a dummy byte for the LDS itself as machine code at 0x100 is 0xC5,0x78,0x00,0xB8
mov ax, 0x200A           ; first byte of the instruction is 0xB8 used for LDS, also sets AX to the initial value for DX to swap later: DH set to empty space, DL to 0xA, DX satisfies DX*8%0x10000=0x50 so good for the wall building
cwd                      ; set DX to 0x0 to swap later with AX to set video mode (AH=0x0) to mode 0 (AL=0x0), text mode 40x25 16 colors
xchg ax, dx              ; swap AX and DX
int 0x10                 ; set video mode using BIOS interrupt call, also clears the screen
mov sp, di               ; set SP to current head pointer, resets snake size
mov bx, [si]             ; reset head position, SI always points to a valid screen position containing 0x720 after setting video mode
.food:                   ; create new food item
add ah, cl               ; decreasing AH for randomization ensures SI is still divisble by 2 and if the snake isn't filling all the possible options, below 0x7D0 (so on screen)
xchg ax, si              ; alternate SI between the last head position and the end of the screen
xor [si], cl             ; place food item and check if position was empty by applying XOR with CL
jp .food                 ; if position was occupied by snake or wall in food generation => try again
.input:                  ; handle keyboard input
mov si, 0x7D0            ; initialize SI
in al, 0x60              ; read scancode from keyboard controller - bit 7 is set in case key was released
imul dl                  ;   we want to map scancodes for arrow up (0x48/0xC8), left (0x4B/0xCB), right (0x4D/0xCD), down (0x50/0xD0) to movement offsets
aam 0x14                 ;     IMUL (AH is irrelevant here), AAM and AAD with some magic constants maps up => -80, left => -2, right => 2, down => 80
aad 0x44                 ;     using arithmetic instructions is more compact than checks and conditional jumps
cbw                      ;     but causes weird snake movements though with other keys
add ax, bx               ; set AX to new head position
cmp si, ax               ; check if head crossed vertical edge by comparing against SI
stosw                    ; store head position (SS=ES by default) and advance head pointer
xchg ax, bx              ; save new head position to BX
adc BYTE [bx], 0x1F      ; set snake character
js .food                 ; if food was consumed, SF=1 from ADC => generate new food
jnp $$-1                 ; if it already had snake or wall in it or if it crossed a vertical edge, PF=0 from ADC => game over, going to $$-1 adds a null byte before the LDS thus changing it into `add ch,al` which doesn't matter as we don't use CH then `js $+2` which is practically a NOP, also after doing JNZ to .wall-1 we get here byte 0xD1
.wall:                   ; draw an invisible wall on the left side
sub al, 0x29             ; AL is the last position so it's even, hence this instruction will always set ZF=0
salc                     ; we don't care about AL at this point so this is a NOP, however, after `jnz .wall-1` we get the bytes 0xD1 (from the JNP), 0x2C,0x29 (from the SUB) and then 0xD6 (from this SALC) which encode the instruction `shr word [si], 1`, `sub si, dx`, the new SUB makes us go one line and 0x2000 bytes backwards (the added bytes wrap nicely as 0x10000%0x2000=0) [using DX like that - and not 0x50 - makes this loop a delay loop also] so the new SHR after enough iterations sets all wall positions to 0
jnz .wall-1              ; on first enrty to .wall this will always jump as ZF=0 from SUB, after the first loop it jumps to draw the next wall because we jump to .wall-1 and will stop at the last wall at DS:0
pop si                   ; no food was consumed so pop tail position into SI
mov [si], dh             ; clear old tail position on screen
jns .input               ; loop to keyboard input, SF=0 from SUB
