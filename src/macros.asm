; macros.asm



Border                  macro(Colour)                   ; Macro (makes the code more readable) to set border
                        ld a, Colour                    ; Set a to the colour desired
                        out (ULAPort), a                ;   and output it to the ULA Port (defined in constants)
mend                                                    ; No RET is needed - this code is inserted inline



Print                   macro(TextAddress, TextLength)  ; Macro to print text on the screen using ROM routines
                        ld a, ChannelUpper              ; Channel 2 (defined in constants) is the upper screen
                        call CHAN_OPEN                  ; Open this channel (ROM routine)
PrintLoop:              ld de, TextAddress              ; Address of string to print
                        ld bc, TextLength               ; Length of string to print
                        call PR_STRING                  ; Print string (ROM routine)

mend



PrintTextHL             macro()
PrintMenu:              ld a, (hl)                      ; for each character of this string...
                        cp 255
                        jp z, Next                      ; check string terminator
                        push hl                         ; preserve HL
                        call FZX_START                  ; print character
                        pop hl                          ; recover HL
                        inc hl
                        jp PrintMenu
Next:                                                   ; This will be whatever code follows the macro
mend



ClsAttrLine             macro(Line, Colour)
                        if Colour = DimBlackBlackP
                         xor a                          ; xor a is a fast way of doing ld a, 0
                        else
                          ld a, Colour                  ; Set the colour
                        endif
                        ld hl, AttributeAddress+(Line*32)
                        ld (hl), a
                        ld de, AttributeAddress+(Line*32)+1
                        ld bc, 32                       ; Set 32 attribute values
                        ldir                            ; using block copy
mend



ClsAttrColour           macro(Colour)
                        if Colour = DimBlackBlackP
                         xor a                          ; xor a is a fast way of doing ld a, 0
                        else
                          ld a, Colour                  ; Set the colour
                        endif
                        ld (ClsAttr.Colour), a
mend



NIRVANA_printC_Colour   macro(On)
                        if !On
                          ld a, $C9                       ; ret
                        else
                          ld a, $26
                        endif                             ; ld h, n
                        ld (NIRVANA_paintC), a            ; <SMC
mend



ScrollStar              macro()
                        ld a, d                         ; Retrieve the byte containing bits 0..2 of the Y coordinate.
                        and %00000111                   ; Calculate Y mod 8 (0..7).
                        cp %00000111                    ; If 7 then
                        jp z, CharScroll                ;   do a character scroll.
                        ld a, d                         ; Otherwise do
                        inc a                           ;   a pixel
                        ld d, a                         ;   scroll.
                        ld (SetupStars.Colour), a
                        inc (hl)                        ; Save px-scrolled offset back to StarField.Table.
                        jp Continue
CharScroll:
                        ld a, e                         ; Retrieve the byte containing bits 3..4 of the Y coordinate.
                        add 32                          ; Increment those two bits by one
                        ld e, a                         ;   and save back the byte. This moves into the next char row.
                        dec l                           ; Now retrieve the byte
                        ld (hl), a                      ;   containing bits 0..2 of the Y coordinate,
                        inc l                           ;   and
                        xor a                           ;   reset it to zero, ensuring we start at the top of that char row.
                        ld d, a                         ; Save that back to the byte, and also
                        ld (hl), a                      ;   save the px-scrolled offset back to StarField.Table.
Continue:
mend

