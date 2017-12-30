; main.asm

zeusemulate             "48K"                           ; Tell the Zeus emulator to be a 48K Spectrum
zoLogicOperatorsHighPri = false                         ; Zeus assembler options
zoSupportStringEscapes  = false                         ;   (see Config tab
zoAllowFloatingLabels   = false                         ;   for details)
Zeus_PC                 = Start                         ; Tell the Zeus emulator where to start running code at
org                     $8000                           ; Tell the Zeus assembler where to place the code



Main                    proc                            ; A named PROCedure (also our start point)
::Start:
                        ld sp, Start                    ; Put our stack right below the program
                        Border(Black)                   ; Set the border to black using a helper macro
                        ei
                        call SetupMenu
                        call SetupGame
Loop:
                        halt                            ; Wait until the next 50th second frame
                        call AnimateDemo                ; Animate our monster
                        jp Loop                         ; Go into an endless loop (for now...)
pend



include                 "menu.asm"
include                 "sprites.asm"
include                 "utilities.asm"
include                 "database.asm"
include                 "constants.asm"
include                 "macros.asm"
include                 "nirvana+.asm"







; Make tape file
End                     equ $                           ; Calculate the last byte of our program
Size                    equ End-Start                   ; Count the bytes to save to tape
output_tap              TapFile, "ZalaXa", "seven-fff.com/zalaxa", Start, Size, 2, Start
                                                        ; Make a .TAP file. Parameters:
                                                        ;   1) the file name
                                                        ;   2) the name of the BASIC loader program
                                                        ;   3) a comment that goes in the TAP header
                                                        ;   4) Start of machine code program
                                                        ;   5) Length of machine code program
                                                        ;   6) Zeus mode 2 files use the standard ROM loader
                                                        ;   7) Tell the BASIC loader what to run with RANDOMIZE
                                                        ;       USR (like Zeus_PC tells the Zeus emulator)

