; menu.asm



SetupMenu               proc
                        call ClsAttr                    ; Call another named procedure to do a fast CLS (like GOSUB)
                        Print(MenuText, MenuText.Length); Print text on the screen using ROM routines
WaitForSpace:                                           ; All labels inside procedures are local to that procedure
                        halt                            ; Wait for the next 1/50th second interrupt (like PAUSE 1)
                        ld bc, zeuskeyaddr(" ")         ; Get the IO address to input
                        in a, (c)                       ; Read those 5 keys
                        and zeuskeymask(" ")            ; AND with the bit for SPACE
                        jp nz, WaitForSpace             ; If it's zero the key is pressed
                        ret                             ; Otherwise return
pend



SetupGame               proc
                        call ClsAttr                    ; Clear the 8x2 attributes for a fast CLS before setup
                        ld a, BTile.NirvanaDemo         ; BTile.NirvanaDemo is 0 - the index of the first tile in the set
                        ld (Sprites.AIndex), a          ; Set NIRVANA+ sprite A to this sprite index
                        ld hl, $1000                    ; LSB is $00 (the column), MSB is $10 (the line, decimal 16)
                        ld (Sprites.AColumn), hl        ; Set NIRVANA+ sprite A coords to 0, 16
                        call NIRVANA_start              ; Enable NIRVANA+
                        ret
pend

