; menu.asm



SetupMenu               proc
                        call ClsAttr
                        ei
                        halt
                        di
Randomize:
                        call ClsPixels                  ; Clear all the pixels.

                        ld hl, ZalaXaLogo.ZChar
                        ld bc, ZalaXaLogo.Count
LogoLoop:               dec bc                          ; Loop bc times
                        call LevelChar8                 ; Draw a character with 8x8 attributes
                        ld a, b                         ; Set a=0 if bc=0
                        or c
                        jr nz, LogoLoop                 ; end loop

                        Print(MenuText, MenuText.Length); Print attributes on the screen using ROM routines

                        ld hl, Font.Namco               ; Set FZX font
                        ld (FZX_FONT), hl
                        ld hl, MenuText.FZX             ; Start of menu ASCII data
                        PrintTextHL()                   ; Macro to print FZX proportional text with FZX

StarSeed equ $+1:       ld hl, $26B1
                        ld de, StarField.Table
                        ld bc, StarField.Length
                        ldir
WaitForSpace:
                        ei
                        halt                            ; Wait for the next 1/50th second interrupt (like PAUSE 1)
                        di
                        ld bc, zeuskeyaddr(" ")         ; Get the IO address to input
                        in a, (c)                       ; Read those 5 keys
                        and zeuskeymask(" ")            ; AND with the bit for SPACE
                        ret z                             ; Otherwise return
                        jp AnimateStars
AnimateStarsRet:
                        call HighlightLogo

                        jp WaitForSpace
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



HighlightLogo           proc
                        ld a, (FRAMES)
                        and %1
                        ret nz
Colour equ $+1:         ld a, BrightBlackBlackP
Direction:              inc a
                        cp BrightWhiteBlackP+1
                        jp nz, Low
                        ld a, (Direction)
                        xor 1
                        ld (Direction), a
                        ld a, BrightYellowBlackP
Low:
                        cp BrightBlackBlackP
                        jp nz, SaveColour
                        ld a, (Direction)
                        xor 1
                        ld (Direction), a
                        ld a, BrightRedBlackP
SaveColour:
                        ld (Colour), a

                        ld hl, zxattraddr(14*8, 4*8)
                        ld de, zxattraddr(15*8, 4*8)
                        ld bc, 4
                        ld (hl), a
                        ldir
                        inc l
                        inc l
                        ld (hl), a
                        inc l
                        ld (hl), a

                        ld hl, zxattraddr(10*8, 5*8)
                        ld de, zxattraddr(11*8, 5*8)
                        ld bc, 5
                        ld (hl), a
                        ldir
                        inc l
                        inc l
                        inc l
                        ld (hl), a
                        inc l
                        ld (hl), a
                        inc l
                        ld (hl), a
                        inc l
                        ld (hl), a

                        ld hl, zxattraddr(10*8, 6*8)
                        ld de, zxattraddr(11*8, 6*8)
                        ld bc, 10
                        ld (hl), a
                        ldir

                        ld hl, zxattraddr(10*8, 7*8)
                        ld de, zxattraddr(11*8, 7*8)
                        ld bc, 11
                        ld (hl), a
                        ldir

                        ld hl, zxattraddr(10*8, 8*8)
                        ld (hl), a

                        ld hl, zxattraddr(17*8, 8*8)
                        ld (hl), a

                        ret
pend

