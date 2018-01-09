; menu.asm



SetupMenu               proc
                        call ClsAttr                    ; Call another named procedure to do a fast CLS (like GOSUB)
                        Print(MenuText, MenuText.Length); Print attributes on the screen using ROM routines

                        ld hl, Font.Namco               ; Set FZX font
                        ld (FZX_FONT), hl
                        ld hl, MenuText.FZX             ; Start of menu ASCII data
                        PrintTextHL()                   ; Macro to print FZX proportional text with FZX

WaitForSpace:                                           ; All labels inside procedures are local to that procedure
                        halt                            ; Wait for the next 1/50th second interrupt (like PAUSE 1)
                        ld bc, zeuskeyaddr(" ")         ; Get the IO address to input
                        in a, (c)                       ; Read those 5 keys
                        and zeuskeymask(" ")            ; AND with the bit for SPACE
                        jp nz, WaitForSpace             ; If it's zero the key is pressed
                        ret                             ; Otherwise return
pend



SetupGame               proc
                        call ClsAttr                    ; Clear the 8x8 attributes first (fast)
                        call ClsNirvana                 ;   the set 8x2 attributes from colour table (slower)
                        NIRVANA_printC_Colour(false)

                        ld a, WTile.Ship                ; WTile.Monster is 0 - the index of the first tile in the set
                        ld (Sprites.BIndex), a          ; Set NIRVANA+ sprite B to this sprite index
                        ld a, WTile.Blank               ; WTile.Blank is 12 - the index of the blank tile
                        ld (Sprites.AIndex), a          ; Set NIRVANA+ sprite A to this sprite index
                        ld a, 120                       ; 120 is the dead center in the horizontal axis
                        ld (MovePlayer.X), a            ; Set the playing horizontal starting position
                        ld a, 184                       ; 96 is the dead center in the vertical axis
                        ld (MovePlayer.Y), a            ; Set the playing vertical starting position

                        ld hl, GameText                 ; Start of menu ASCII data
                        PrintTextHL()                   ; Macro to print FZX proportional text with FZX

                        call NIRVANA_start              ; Enable NIRVANA+
                        ret
pend

