; database.asm



BTile proc
::TILE_IMAGES:
::TileImages:
;                                                           BTile         Best
;          FileName                                       Indices    Viewed As     Notes
NirvanaDemo equ ($-TileImages)/Sprites.BTileLen
import_bin "..\tiles\nirvana+.btile"                    ; 000-005        1 x 6     Menu Play

pend



MenuText                proc                            ; Named procedure to keep our print data tidy
                        db At, 7, 13                    ; These codes are the same as you would use
                        db Paper, Black, Bright, 1      ;   with Sinclair BASIC's PRINT command
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

