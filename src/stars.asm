; stars.asm



AnimateStars            proc

                        ld a, (ColourFlip)
                        xor 3
                        ld (ColourFlip), a

                        ld hl, StarField.Table          ; Starting point of ROM "psuedo-random" table (2 bytes per star). Try $03F3!
                        ld a, StarField.StarCount       ; Loop through this many times, once for each star.
                        ld c, 0
ResetLoop:
                        ex af, af'                      ; Save number of stars (loop counter).
                        //ld a, (hl)                      ; Read the byte represnting the star pixel,
                        //or %10000111                    ;      turn it into a "res n, a" instruction ($80 10nnn111) by setting
                        //and %10111111                   ;      and clearing bits,
                        //ld (ResetBit1), a                ; SMC> then write this into the pixel-drawing code.
                        //ld (ResetBit2), a                ; SMC> then write this into the pixel-drawing code.
                        //ld (ResetBit3), a                ; SMC> then write this into the pixel-drawing code.
                        inc l                           ; Read two
                        ld e, (hl)                      ;   coordinate bytes,
                        inc l                           ;   for this star,
                        ld a, (hl)                      ;   into de.
                        and %00000111                   ; Constrain de between 0..2047
                        ld d, a                         ;   (size of top screen third).
                        ex de, hl                       ; Sawp the reading addr into de, and the writing addr into hl.
                        ld b, high(PixelAddress)        ; c stays 0, so this is a fast way of doing ld bc, $4000.
                        add hl, bc                      ; Calculate a pixel address in the top screen third.

                        push hl
                        ld h, %01011000
                        ld a, (hl)
                        pop hl
                        and %0100 0000
                        jp nz, Unset2

                        xor a                           ; Undraw a single pixel star,
//ResetBit1 equ $+1:      res SMC, a                      ; <SMC  by resetting that pseudo-random
                        ld (hl), a                      ;       bit (0..7) from earlier.
Unset2:
                        ld b, 8                         ; Fast way of doing ld bc, $0800 (size of a screen third).
                        add hl, bc                      ; hl is now a pixel address in the middle screen third.

                        push hl
                        ld h, %01011001
                        ld a, (hl)
                        pop hl
                        and %0100 0000
                        jp nz, Unset3

                        xor a
//ResetBit2 equ $+1:      res SMC, a
                        ld (hl), a                      ; Draw the same single pixel star here, too.
Unset3:
                        add hl, bc                      ; hl is now a pixel address in the bottom screen third.

                        push hl
                        ld h, %01011010
                        ld a, (hl)
                        pop hl
                        and %0100 0000
                        jp nz, Unset4

                        xor a
//ResetBit3 equ $+1:      res SMC, a
                        ld (hl), a                      ; Draw the same single pixel star here, too.
Unset4:
                        ex de, hl                       ; Swap the writing addr back into de, and reading addr into hl.
                        inc l
                        ex af, af'                      ; Retrieve the number of stars (loop counter),
                        dec a                           ;   decrease it,
                        jp nz, ResetLoop                ;   and do all over again if there are any stars left.

                        ld hl, StarField.Table          ; Starting point of ROM "psuedo-random" table (2 bytes per star). Try $03F3!
                        ld a, StarField.StarCount       ; Loop through this many times, once for each star.
SetLoop:
                        ex af, af'                      ; Save number of stars (loop counter).
                        ld a, (hl)                      ; Read the byte represnting the star pixel,
                        or %11000111                    ;      turn it into a "set n, a" instruction ($CB 11nnn111),
                        ld (SetBit1), a                 ; SMC> then write this into the pixel-drawing code.
                        ld (SetBit2), a                 ; SMC> then write this into the pixel-drawing code.
                        ld (SetBit3), a                 ; SMC> then write this into the pixel-drawing code.
                        inc l                           ; Read two
                        ld e, (hl)                      ;   coordinate bytes,
                        inc l                           ;   for this star,
                        ld a, (hl)                      ;   into de.
                        and %00000111                   ; Constrain de between 0..2047
                        ld d, a                         ;   (size of top screen third).
                        ScrollStar()                    ; Macro to manipulate the Y coordinate.
                        ex de, hl                       ; Sawp the reading addr into de, and the writing addr into hl.
                        ld b, high(PixelAddress)        ; c stays 0, so this is a fast way of doing ld bc, $4000.
                        add hl, bc                      ; Calculate a pixel address in the top screen third.

                        push hl
                        ld h, %01011000
                        ld a, (hl)
                        pop hl
                        and %0100 0000
                        jp nz, Set2

                        xor a                           ; Draw a single pixel star,
SetBit1 equ $+1:        set SMC, a                      ; <SMC  by setting that pseudo-random
                        ld (hl), a                      ;       bit (0..7) from earlier.
Set2:
                        ld b, 8                         ; Fast way of doing ld bc, $0800 (size of a screen third).
                        add hl, bc                      ; hl is now a pixel address in the middle screen third.

                        push hl
                        ld h, %01011001
                        ld a, (hl)
                        pop hl
                        and %0100 0000
                        jp nz, Set3

                        xor a                           ; Draw a single pixel star,
SetBit2 equ $+1:        set SMC, a                      ; <SMC  by setting that pseudo-random
                        ld (hl), a                      ; Draw the same single pixel star here, too.
Set3:
                        add hl, bc                      ; hl is now a pixel address in the bottom screen third.

                        push hl
                        ld h, %01011010
                        ld a, (hl)
                        pop hl
                        and %0100 0000
                        jp nz, Set4

                        xor a                           ; Draw a single pixel star,
SetBit3 equ $+1:        set SMC, a                      ; <SMC  by setting that pseudo-random
                        ld (hl), a                      ; Draw the same single pixel star here, too.
Set4:
                        ld h, %01011000
Colour equ $+1:         ld a, SMC
ColourFlip equ $+1:     jr SameColour
                        dec a
                        and %111
SameColour:
                        push bc
                        ld c, a
                        ld a, (hl)
                        and %01000000
                        ld a, c
                        pop bc
                        jp nz, SetCol2

                        ld (hl), a

SetCol2:
                        ld h, %01011001

                        push bc
                        ld c, a
                        ld a, (hl)
                        and %01000000
                        ld a, c
                        pop bc
                        jp nz, SetCol3

                        ld (hl), a

SetCol3:
                        ld h, %01011010

                        push bc
                        ld c, a
                        ld a, (hl)
                        and %01000000
                        ld a, c
                        pop bc
                        jp nz, SetCol4

                        ld (hl), a
SetCol4:
                        ld c, 0
                        ex de, hl                       ; Swap the writing addr back into de, and reading addr into hl.
                        inc l
                        ex af, af'                      ; Retrieve the number of stars (loop counter),
                        dec a                           ;   decrease it,
                        jp nz, SetLoop                  ;   and do all over again if there are any stars left.

                        jp SetupMenu.AnimateStarsRet
pend



align 256
StarField               proc
  StarCount             equ 32
  Table:                ds StarCount*3
  Length                equ $-StarField
pend



; 8-bit Complementary-Multiply-With-Carry (CMWC) random number generator.
; Created by Patrik Rak in 2012, and revised in 2014/2015,
; with optimization contribution from Einar Saukas and Alan Albrecht.
; See http://www.worldofspectrum.org/forums/showthread.php?t=39632
; and https://gist.github.com/raxoft/2275716fea577b48f7f0
RndCMWC                 proc
                        ld hl, Seed

                        ld a, (hl)                      ; i = ( i & 7 ) + 1
                        and 7
                        inc a
                        ld (hl), a

                        inc l                           ; hl = &cy

                        ld b, h                         ; bc = &q[i]
                        add a, l
                        ld c, a

                        ld a, (bc)                      ; y = q[i]
                        ld d, a
                        ld e, a
                        ld a, (hl)                      ; da = 256 * y + cy

                        sub e                           ; da = 255 * y + cy
                        jr nc, $+3
                        dec d
                        sub e                           ; da = 254 * y + cy
                        jr nc, $+3
                        dec d
                        sub e                           ; da = 253 * y + cy
                        jr nc ,$+3
                        dec d

                        ld (hl), d                      ; cy = da >> 8, x = da & 255
                        cpl                             ; x = (b-1) - x = -x - 1 = ~x + 1 - 1 = ~x
                        ld (bc), a                      ; q[i] = x

                        ret
ds 12
Seed:                   db 0,0,82,97,120,111,102,116,20,15

                        if (Seed/256)-((Seed+17)/256)
                          zeuserror "Seed table must be within single 256 byte block";
                        endif
pend

