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
                        db At, 7, 13                    ; These codes are the same as you would use
                        db Paper, Black, PrBright, 1    ;   with Sinclair BASIC's PRINT command
                        db Ink, Red, " "                ; Set the attributes here, with spaces,
                        db Ink, Yellow, " "             ;   because FZX only prints pixels
                        db Ink, Cyan, " "
                        db Ink, Magenta, " "
                        db Ink, White, " "
                        db Ink, Green, " "
                        db At, 21, 6
                        db Ink, Yellow, "      "
                        db Ink, White, "      "
                        db Ink, Yellow, "        "
Length                  equ $-MenuText                  ; Let Zeus do the work of calculating the length
                                                        ; ($ means the current address Zeus is assembling to)
FZX:                    db At, 56, 104                  ; FXX coordinates are (Y, X) in pixels
                        db "ZA%AXA"
                        db At, 168, 55
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
    db $00, $38, $4C, $C6, $C6, $C6, $64, $38    ; 00        Score digit 0
    db $00, $18, $38, $18, $18, $18, $18, $7E    ; 01        Score digit 1
    db $00, $7C, $C6, $0E, $3C, $78, $E0, $FE    ; 02        Score digit 2
    db $00, $7E, $0C, $18, $3C, $06, $C6, $7C    ; 03        Score digit 3
    db $00, $1C, $3C, $6C, $CC, $FE, $0C, $0C    ; 04        Score digit 4
    db $00, $FC, $C0, $FC, $06, $06, $C6, $7C    ; 05        Score digit 5
    db $00, $3C, $60, $C0, $FC, $C6, $C6, $7C    ; 06        Score digit 6
    db $00, $FE, $C6, $0C, $18, $30, $30, $30    ; 07        Score digit 7
    db $00, $78, $C4, $E4, $78, $9E, $86, $7C    ; 08        Score digit 8
    db $00, $7C, $C6, $C6, $7E, $06, $0C, $78    ; 09        Score digit 9

    Count equ ($-Table)/8
    if Count > 255
      zeuserror "Character table has grown larger than 255 entries."
    endif

pend

