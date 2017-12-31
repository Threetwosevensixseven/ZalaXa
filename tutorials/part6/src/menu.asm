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
                        ld a, WTile.Monster             ; WTile.Monster is 0 - the index of the first tile in the set
                        ld (Sprites.BIndex), a          ; Set NIRVANA+ sprite B to this sprite index
                        ld a, WTile.Blank               ; WTile.Blank is 12 - the index of the blank tile
                        ld (Sprites.AIndex), a          ; Set NIRVANA+ sprite A to this sprite index
                        ld a, 120                       ; 120 is the dead center in the horizontal axis
                        ld (MovePlayer.X), a            ; Set the playing horizontal starting position
                        ld a, 96                        ; 96 is the dead center in the vertical axis
                        ld (MovePlayer.Y), a            ; Set the playing vertical starting position
                        call NIRVANA_start              ; Enable NIRVANA+
                        ret
pend

