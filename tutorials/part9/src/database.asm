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
                        db At, 9, 0, "0"
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

