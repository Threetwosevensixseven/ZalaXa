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
                        call ClsAttr                    ; Clear the screen to prove we pressed space
                        ld a, BTile.NirvanaDemo
                        ld (Sprites.AIndex), a
                        ld hl, $1000
                        ld (Sprites.AColumn), hl
                        call NIRVANA_start
                        ret
pend

