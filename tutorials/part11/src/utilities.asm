; utilities.asm



ClsAttr                 proc                            ; Do an attribute CLS using LDIR block copy
                        xor a                           ; Set a to 0 (blank ink, black paper)
                        ld hl, AttributeAddress         ; Address to start copying from (start of attributes)
                        ld de, AttributeAddress+1       ; Address to start copying to (next byte)
                        ld bc, AttributeLength-1        ; Number of bytes to copy (767, all the attirbutes)
                        ld (hl), a                      ; Set first byte to attribute value
                        ldir                            ; Block copy bytes
                        ret                             ; Return from the procedure (like RETURN)
pend



ClsNirvana              proc
                        di                              ; 1) Clear all pixels
                        ld (RestoreStack), sp           ; SMC> Save the stack
                        ld sp, AttributeAddress         ; Set stack to end of screen
                        ld de, $0000                    ; All pixels unset
                        ld b, 0                         ; Loop 256 times: 12 words * 256 = 6144 bytes
LoopPixels:
                        loop 12
                          push de
                        lend
                        djnz LoopPixels
RestoreStack equ $+1:   ld sp, SMC                      ; <SMC Restore the stack

                        ld hl, ClsNirvanaGame           ; 2) Clear 8x2 attributes
                        ld ix, race_raster
                        ld de, NAttrVOffset
                        xor a
                        ld (Col+1), a
LoopAttr:               ld b, (hl)
                        xor a
                        cp b
                        jp z, TopRow
                        inc hl
                        ld c, (hl)
                        inc hl
Times:                  ld a, (Col+1)
                        cp 32
                        jp nz, Skip
                        xor a
                        add ix, de
Skip:                   inc a
                        ld (Col+1), a
Col:                    ld a, (deltas-1)                ; NIRVANA_org+8957 (65280, $FF00)
                        ld (Delta+2), a
Delta:                  ld (ix+0), c
                        djnz Times
                        jp LoopAttr
TopRow:
                        ClsAttrLine(0, BrightRedBlackP) ; 3) Clear top row of 8x8 attributes
                        ret
endp



UpdateScore             proc
                        ld a, (hl)                      ; Current value of digit
                        add a, b                        ; Add points to this digit
                        ld (hl), a                      ; Place new digit back in score
                        cp 10                           ; More than nine?
                        jp c, Redraw                    ; No - relax.
                        sub 10                          ; Subtract 10
                        ld (hl), a                      ; Put new digit back in score
Digit:                  dec hl                          ; Previous digit in score
                        inc (hl)                        ; Up this by one
                        ld a, (hl)                      ; What's the new value?
                        cp 10                           ; Gone past nine?
                        jp c, Redraw                    ; No, scoring done
                        sub 10                          ; Down by ten
                        ld (hl), a                      ; Put it back
                        jp Digit                        ; Go round again
Redraw:
                        ld de, $1000                    ; $1000 is 0, 16 in NIRVANA+ coordinates
                        ld b, 6                         ; Process 6 digits,
                        ld hl, Score.D5                 ;   starting with the leftmost digit.
RedrawLoop:
                        ld a, (hl)                      ; Read value of score digit (0..9, not ASCII)
                        or a                            ; Fast way to compare with zero
SkipSMC equ $+1:        jr z, SkipDraw                  ; <SMC If leading zero, skip this digit
                        push hl                         ; Otherwise, save digit address
                        call NIRVANA_printC             ; Print character (a=index, d=pxline, e=column)
                        pop hl                          ; Restore digit address
                        inc e                           ; Increase column
                        xor a                           ; Set the skip to never skip any zeroes
                        ld (SkipSMC), a                 ;   SMC> by changing it to jp +0
SkipDraw:
                        inc hl                          ; Set next digit for processing
                        djnz RedrawLoop                 ; Reduce the digit count and repeat until zero
                        ld a, $0A                       ; Set the skip to skip leading zeroes again
                        ld (SkipSMC), a                 ;   SMC> by changing it to jp +$0A
                        ret
pend

