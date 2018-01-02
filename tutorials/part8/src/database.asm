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



MenuText                proc                            ; Named procedure to keep our print data tidy
                        db At, 7, 13                    ; These codes are the same as you would use
                        db Paper, Black, PrBright, 1    ;   with Sinclair BASIC's PRINT command
                        db Ink, Red, "Z"
                        db Ink, Yellow, "A"
                        db Ink, Cyan, "L"
                        db Ink, Magenta, "A"
                        db Ink, White, "X"
                        db Ink, Green, "A"
                        db At, 21, 6
                        db Ink, Yellow, "PRESS "
                        db Ink, White, "SPACE"
                        db Ink, Yellow, " TO START"
Length                  equ $-MenuText                  ; Let Zeus do the work of calculating the length
pend                                                    ; ($ means the current address Zeus is assembling to)



ClsNirvanaGame          proc
                        db 128, BrightWhiteBlackP
                        loop 11
                          db 255, BrightYellowBlackP
                        lend
                        db 11, BrightYellowBlackP
                        db 0
pend

