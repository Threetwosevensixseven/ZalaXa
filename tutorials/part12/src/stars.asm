; stars.asm



SetupStars              proc
                        ld a, DimWhiteBlackP            ; Custom colour for ClsAttr.
                        call ClsAttr.WithCustomColour   ; Alternate entry point without setting colour.
RandomLoop:
                        call ClsPixels                  ; Clear all the pixels.
Seed equ $+1:           ld hl, $0000                    ; Starting point of ROM "psuedo-random" table (2 bytes per star). Try $03F3!
                        zeusdatabreakpoint 1, "zeusprinthex(1, hl)", $ ; Log current value of ROM table to debug window.
                        ld a, NumberOfStars             ; Loop through this many times, once for each star.
DrawLoop:
                        ex af, af'                      ; Save number of stars (loop counter).
                        ld e, (hl)                      ; Read 2 bytes,
                        inc hl                          ;   for this star,
                        ld a, (hl)                      ;   into de.
                        and %00000111                   ; Constrain de between 0..2047
                        ld d, a                         ;   (size of top screen third).
                        ld a, e                         ; Mask out a bit number (0..7) from the X coordinate,
                        or %11000111                    ;      turn it into a "set n, a" instruction ($CB 11nnn111),
                        ld (SetBit), a                  ; SMC> then write this into the pixel-drawing code.
                        ex de, hl                       ; Sawp the reading addr into de, and the writing addr into hl.
                        ld b, high(PixelAddress)        ; c stays 0, so this is a fast way of doing ld bc, $4000.
                        add hl, bc                      ; Calculate a pixel address in the top screen third.
                        xor a                           ; Draw a single pixel star,
SetBit equ $+1:         set SMC, a                      ; <SMC  by setting that pseudo-random
                        ld (hl), a                      ;       bit (0..7) from earlier.
                        ld b, 8                         ; Fast way of doing ld bc, $0800 (size of a screen third).
                        add hl, bc                      ; hl is now a pixel address in the middle screen third.
                        ld (hl), a                      ; Draw the same single pixel star here, too.
                        add hl, bc                      ; hl is now a pixel address in the bottom screen third.
                        ld (hl), a                      ; Draw the same single pixel star here, too.
                        ex de, hl                       ; Swap the writing addr back into de, and reading addr into hl.
                        ex af, af'                      ; Retrieve the number of stars (loop counter),
                        dec a                           ;   decrease it,
                        jp nz, DrawLoop                 ;   and do all over again if there are any stars left.

                        call WaitForAnyKeyPress         ; Spin until any key is pressed

                        ld hl, (Seed)                   ; Increase starting point of ROM "psuedo-random" table
                        inc hl                          ;      by one byte,
                        ld (Seed), hl                   ; SMC> save it into the routine,
                        jp RandomLoop                   ;      and rerun the routine again.

NumberOfStars           equ 32                          ; Constant declared locally to keep it handy.
pend



WaitForAnyKeyPress      proc
                        halt                            ; Wait to ensure screen is drawn.
                        //jp WaitForAnyKeyPress         ; (Comment this back in if you want to freeze permanently.)
                        xor a                           ; Read all eight
                        in a, ($FE)                     ;   keyboard I/O ports,
                        cpl                             ;   mask out all
                        and 15                          ;   five key columns, and
                        jr z, WaitForAnyKeyPress        ;   loop endlessly until at least one key pressed.
                        halt:halt:halt:halt             ; Wait a bit longer to smooth out flickering (belt and braces).
                        ret
pend

