; sprites.asm



AnimateDemo             proc

                        ld a, (FRAMES)                  ; Read the LSB of the ROM frame counter (0.255)
                        and %00000111                   ; Take the lowest 3 bits (effectively FRAMES modulus 8),
                        ret nz                          ;   and return 7 out of every 8 frames.

                        ld a, (MovePlayer.AnimOffset)   ; For every 8th frame, read player's tile offset,
                        xor %00000100                   ;       alternate between (0 => 4 => 0 => 4 => etc),
                        ld (MovePlayer.AnimOffset), a   ; SMC>  then save it back.
                        ret
pend



MovePlayer              proc
                        ld de, 0                        ; d (vertical) and e (horizontal) will hold -2/0/+2 movement offsets
                        ld bc, zeuskeyaddr("OP")        ; Get the I/O port address for O (left) and P (right)
                        in a, (c)                       ; Read keys
                        ld b, a                         ; Save value for Right check
                        and zeuskeymask("O")            ; Mask out everything but O
                        jp nz, Right                    ; If result is non-zero O was not pressed, so check Left key
                        ld e, -2                        ; otherwise set horizontal offset to -2
                        jp Up                           ; and skip Left key check
Right:
                        ld a, b                         ; Retrieve Left/Right keypress reading
                        and zeuskeymask("P")            ; Mask out everything but P
                        jp nz, Up                       ; If result is non-zero P was not pressed, so check Up key
                        ld e, +2                        ; otherwise set horizontal offset to +2
Up:
                        ld bc, zeuskeyaddr("Q")         ; Get the I/O port address for Q (up)
                        in a, (c)                       ; Read keys
                        and zeuskeymask("Q")            ; Mask out everything but Q
                        jp nz, Down                     ; If result is non-zero Q was not pressed, so check Down key,
                        ld d, -2                        ; otherwise set vetical offset to -2.
Down:
                        ld bc, zeuskeyaddr("A")         ; Get the I/O port address for A (down)
                        in a, (c)                       ; Read keys
                        and zeuskeymask("A")            ; Mask out everything but A
                        jp nz, Move                     ; If result is non-zero Q was not pressed, so go ahead
                        ld d, +2                        ; otherwise set vetical offset to +2
Move:
Y equ $+1:              ld a, SMC                       ; <SMC Read the previous player vertical position
                        ld (Sprites.ALine), a           ;      and set the blank sprite vertical position to this.
                        add d                           ; Then add the vertical offset (-2/0/+2)
                        cp -2                           ; Check if we went negative
                        jp nz, MaxY                     ; If not, carry on,
                        xor a                           ;   otherwise set vertical position to 0 (the minimum).
MaxY:
                        cp 200                          ; Check if we went below the bottom of the screen
                        jp c, SetY                      ; If not, carry on,
                        ld a, 200                       ;   otherwise set vertical position to 200 (the maximum).
SetY:
                        ld (Sprites.BLine), a           ; Set the player sprite to the new verified vertical position
                        ld (Y), a                       ;   and also save it for next time (for the blank sprite
                                                        ;   to be drawn underneath the player sprite)
X equ $+1:              ld a, SMC                       ; <SMC Read the previous player horizontal position
                        call CalculatePlayerX           ; Call the routine to calculate the column and tile offset
                        ex af, af'                      ; The column is returned in a'
                        ld (Sprites.AColumn), a         ; Set column for blank sprite (based on previous X position)

                        ld a, b                         ; CalculatePlayerX saved the previous X position in b, restore it
                        add a, e                        ;   then add the horizontal offset (-2/0/+2)
                        cp -2                           ; Check if we went negative
                        jp nz, MaxX                     ; If not, carry on,
                        xor a                           ;   otherwise set vertical position to 0 (the minimum).
MaxX:
                        cp 238                          ; Check if we went beyond the right of the screen
                        jp c, SetX                      ; If not, carry on,
                        ld a, 238                       ;   otherwise set vertical position to 238 (the maximum).
SetX:
                        ld (X), a                       ; Save it for next time (for the blank sprite underneath)
                        call CalculatePlayerX           ; Call the routine again for the new player X position
AnimOffset equ $+1:     add a, SMC                      ; The X offset is returned in a, add the animation offset from AnimateDemo
                        ld (Sprites.BIndex), a          ; Set tile index for player sprite (current position)
                        ex af, af'                      ; The column is returned in a'
                        ld (Sprites.BColumn), a         ; Set column for player sprite (current position)
                        ret
pend



CalculatePlayerX        proc                            ; X coordinate is passed in a (0.255)
                        ld b, a                         ; Save the X coordinate for later
                        and %11111000                   ; Round it to the nearest eight
                        rra                             ;   then
                        rra                             ;   divide
                        rra                             ;   by eight to get the column (0..31).
                        ex af, af'                      ; Column is returned in a'
                        ld a, b                         ; Get the X coordinate back
                        and %00000110                   ; Get the remainder after rounding it to the nearest eight
                        rra                             ;   then divide that by two to get the tile index (0/2/4/6)/
                        add a, WTile.Monster            ; Tile index is returned in a
                        ret
pend

