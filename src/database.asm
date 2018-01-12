; database.asm




WTile proc
::WIDE_IMAGES:
;                                                           BTile         Best
;          FileName                                       Indices    Viewed As     Notes
Ship equ ($-WTile)/Sprites.WTileLen
import_bin "..\tiles\ship.wtile"                        ; 000-016        4 x 2     Ship

Blank equ ($-WTile)/Sprites.WTileLen
import_bin "..\tiles\blank.wtile"                       ; 008-008        1 x 1     Blank

pend



Font                    proc
  Namco:                import_bin "..\fonts\Namco.fzx"
pend



MenuText                proc                            ; Named procedure to keep our print data tidy
                        db Paper, Black, PrBright, 1    ; These codes are the same as you would use
                        db At, 21, 6                    ;   with Sinclair BASIC's PRINT command
                        db Ink, Yellow, "      "        ; Set the attributes here, with spaces,
                        db Ink, White, "      "         ;   because FZX only prints pixels
                        db Ink, Yellow, "        "
Length                  equ $-MenuText                  ; Let Zeus do the work of calculating the length
                                                        ; ($ means the current address Zeus is assembling to)
FZX:                    db At, 168, 55                  ; FXX coordinates are (Y, X) in pixels
                        db "PRESS SPACE TO START"
                        db 255                          ; Terminator byte
pend


GameText                proc                            ; FXX coordinates are (Y, X) in pixels
                        db At, 0, 0, "&UP"
                        db At, 0, 94, "HIGH SCORE"
                        db At, 9, 0, "00"
                        db At, 9, 112, "20000"
                        db 255                          ; Terminator byte
pend



ClsNirvanaGame          proc
                        db 128, BrightWhiteBlackP       ; One row of white
                        rept 11
                          db 255, BrightYellowBlackP    ; and the remainder yellow
                        endm
                        db 11, BrightYellowBlackP
                        db 0
pend



Score                   proc Table:
  D5:                   db 0                            ; Score 6th digit (0-9)
  D4:                   db 0                            ; Score 5th digit (0-9)
  D3:                   db 0                            ; Score 4th digit (0-9)
  D2:                   db 0                            ; Score 3rd digit (0-9)
  D1:                   db 0                            ; Score 2nd digit (0-9)
  D0:                   db 0                            ; Score 1st digit (0-9)
  Value:                db 0
pend



; ASM data file from a ZX-Paintbrush picture with 8 x 8 pixels (= 1 x 1 characters)
Char proc Table:
::CHAR_TABLE:
                                                            No equ 0
    ;  R0   R1   R2   R3   R4   R5   R6   R7      CharID    Notes
    db $00, $38, $4C, $C6, $C6, $C6, $64, $38    ; 00       Score digit 0
    db $00, $18, $38, $18, $18, $18, $18, $7E    ; 01       Score digit 1
    db $00, $7C, $C6, $0E, $3C, $78, $E0, $FE    ; 02       Score digit 2
    db $00, $7E, $0C, $18, $3C, $06, $C6, $7C    ; 03       Score digit 3
    db $00, $1C, $3C, $6C, $CC, $FE, $0C, $0C    ; 04       Score digit 4
    db $00, $FC, $C0, $FC, $06, $06, $C6, $7C    ; 05       Score digit 5
    db $00, $3C, $60, $C0, $FC, $C6, $C6, $7C    ; 06       Score digit 6
    db $00, $FE, $C6, $0C, $18, $30, $30, $30    ; 07       Score digit 7
    db $00, $78, $C4, $E4, $78, $9E, $86, $7C    ; 08       Score digit 8
    db $00, $7C, $C6, $C6, $7E, $06, $0C, $78    ; 09       Score digit 9

                                                            LG equ ($-Table)/8
    db $00, $00, $00, $00, $01, $07, $3F, $FF    ; 00       Logo row 1
    db $00, $00, $01, $3F, $FF, $FF, $FE, $80    ; 01       Logo row 1
    db $00, $00, $F8, $FF, $FF, $FF, $00, $00    ; 02       Logo row 1
    db $00, $00, $00, $F0, $FF, $FF, $1F, $00    ; 03       Logo row 1
    db $00, $00, $00, $00, $80, $E0, $FC, $FF    ; 04       Logo row 1
    db $00, $00, $00, $00, $00, $00, $01, $0F    ; 05       Logo row 1
    db $00, $00, $00, $00, $00, $00, $F0, $F8    ; 06       Logo row 1

    db $00, $00, $01, $03, $07, $0F, $1F, $1F    ; 07       Logo row 2
    db $00, $07, $FF, $FF, $FF, $FF, $FF, $80    ; 08       Logo row 2
    db $00, $FF, $FF, $FF, $FF, $FF, $FF, $FE    ; 09       Logo row 2
    db $07, $9F, $BE, $F8, $E0, $80, $00, $00    ; 10       Logo row 2
    db $F8, $C0, $01, $07, $08, $00, $00, $00    ; 11       Logo row 2
    db $3C, $7C, $FC, $FC, $FC, $FC, $FC, $FC    ; 12       Logo row 2
    db $1F, $01, $00, $00, $00, $00, $00, $00    ; 13       Logo row 2
    db $E0, $F8, $3F, $07, $0F, $1E, $78, $F0    ; 14       Logo row 2
    db $3F, $FE, $F8, $E1, $F3, $3F, $1F, $0F    ; 15       Logo row 2
    db $F8, $F0, $F0, $E0, $C0, $80, $80, $00    ; 16       Logo row 2

    db $18, $10, $00, $00, $00, $00, $00, $00    ; 17       Logo row 3
    db $01, $03, $07, $0F, $1F, $3F, $7F, $FF    ; 18       Logo row 3
    db $FC, $F8, $F0, $E0, $C0, $C0, $80, $80    ; 19       Logo row 3
    db $00, $01, $0F, $1F, $3F, $47, $0F, $0F    ; 20       Logo row 3
    db $00, $F8, $FC, $FC, $FC, $FC, $FC, $FC    ; 21       Logo row 3
    db $FC, $FC, $FC, $FD, $FF, $FC, $FC, $FC    ; 22       Logo row 3
    db $00, $0F, $FF, $FF, $FF, $7F, $FF, $FF    ; 23       Logo row 3
    db $03, $C7, $EF, $FF, $F9, $F0, $E0, $E0    ; 24       Logo row 3
    db $81, $E3, $F7, $FF, $FE, $FE, $7F, $7F    ; 25       Logo row 3
    db $E0, $C0, $87, $0F, $1F, $21, $03, $87    ; 26       Logo row 3
    db $1E, $FE, $FE, $FF, $FF, $FF, $FF, $FF    ; 27       Logo row 3

    db $01, $03, $07, $07, $0F, $0F, $1F, $1F    ; 28       Logo row 4
    db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF    ; 29       Logo row 4
    db $00, $01, $FF, $FF, $FE, $FC, $F8, $80    ; 30       Logo row 4
    db $1F, $BF, $FF, $7F, $7F, $3F, $3F, $1C    ; 31       Logo row 4
    db $7C, $7D, $FF, $FF, $FE, $FC, $78, $30    ; 32       Logo row 4
    db $FD, $FD, $FD, $FD, $FD, $F1, $C1, $80    ; 33       Logo row 4
    db $F7, $F7, $FF, $FF, $FF, $FF, $F7, $E3    ; 34       Logo row 4
    db $E0, $ED, $F9, $F3, $E3, $C7, $87, $0F    ; 35       Logo row 4
    db $FF, $FF, $F7, $E3, $C1, $80, $80, $00    ; 36       Logo row 4
    db $C7, $C7, $E7, $EF, $FF, $EF, $67, $43    ; 37       Logo row 4
    db $DF, $DF, $FF, $FF, $FF, $FF, $DE, $8C    ; 38       Logo row 4
    db $78, $F0, $E0, $C0, $80, $00, $00, $00    ; 39       Logo row 4

    db $1F, $18, $10, $00, $00, $00, $00, $00    ; 40       Logo row 5
    db $0F, $0E, $06, $04, $04, $00, $00, $00    ; 41       Logo row 5

    Count equ ($-Table)/8
    if Count > 255
      zeuserror "Character table has grown larger than 255 entries."
    endif

pend


/*
; ASM data file from a ZX-Paintbrush picture with 8 x 2 attributes (= 1 x 1 characters)
Attr proc Table:
                                        LG equ 0
    ;  R01  R23  R45  R67     AttrID    Notes
    db $47, $47, $47, $47   ; 00        Bright white

    Count equ ($-Table)/4
    if Count > 255
      zeuserror "Attribute table has grown larger than 255 entries."
    endif

pend
*/


ZalaXaLogo proc ZChar:
                                                                       Row=4
  ;         CharID  PixelAddr         AttrAddr           AttrVal       Notes
  Char8(Char.LG+ 0,        14, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 1
  Char8(Char.LG+ 1,        15, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 1
  Char8(Char.LG+ 2,        16, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 1
  Char8(Char.LG+ 3,        17, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 1
  Char8(Char.LG+ 4,        18, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 1
  Char8(Char.LG+ 5,        20, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 1
  Char8(Char.LG+ 6,        21, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 1
                                                                       Row=Row+1
  Char8(Char.LG+ 7,        10, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+ 8,        11, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+ 9,        12, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+10,        13, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+11,        14, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+12,        15, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+13,        18, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+14,        19, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+15,        20, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
  Char8(Char.LG+16,        21, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 2
                                                                       Row=Row+1
  Char8(Char.LG+17,        10, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+18,        11, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+19,        12, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+20,        13, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+21,        14, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+22,        15, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+23,        16, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+24,        17, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+25,        18, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+26,        19, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
  Char8(Char.LG+27,        20, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 3
                                                                       Row=Row+1
  Char8(Char.LG+28,        10, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+29,        11, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+30,        12, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+31,        13, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+32,        14, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+33,        15, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+34,        16, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+35,        17, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+36,        18, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+37,        19, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+38,        20, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
  Char8(Char.LG+39,        21, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 4
                                                                       Row=Row+1
  Char8(Char.LG+40,        10, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 5
  Char8(Char.LG+41,        17, ZalaXaLogo.Row,  BrightCyanBlackP)    ; Logo row 5

  struct
    CharID        ds 1
    PixelAddr     ds 2
    AttrAddr      ds 2
    AttrVal       ds 1
  Size send

  Count equ ($-ZChar)/Size ; Can be > 255
pend

