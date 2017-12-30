; database.asm



BTile proc
::TILE_IMAGES:
;                                                           BTile         Best
;          FileName                                       Indices    Viewed As     Notes
NirvanaDemo equ ($-BTile)/Sprites.BTileLen
import_bin "..\tiles\nirvana+.btile"                    ; 000-016       17 x 1     NIRVANA+ demo sprites

pend



WTile proc
::WIDE_IMAGES:
;                                                           BTile         Best
;          FileName                                       Indices    Viewed As     Notes
Monster equ ($-WTile)/Sprites.BTileLen
import_bin "..\tiles\monster.wtile"                     ; 000-007        4 x 2     Preshifted monster

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

