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
                        call SetupMenu                  ; Display the menu and don't return until we press SPACE
                        call SetupGame                  ; Everything that might need resetting between the end
Loop:                                                   ;   of a game and the start of the next one
                        halt                            ; Wait until the next 50th second frame
                        call AnimateDemo                ; Animate our monster
                        call MovePlayer                 ; Move up/down/left/right
                        jp Loop                         ; Go into an endless loop (for now...)
pend



include                 "menu.asm"                      ; Routines for displaying the menu and setup the game
include                 "sprites.asm"                   ; Routines for displaying the player and NPCs
include                 "utilities.asm"                 ; General purpose routines
include                 "database.asm"                  ; Data tables and graphics tiles
include                 "constants.asm"                 ; EQUates to make the code more readable
include                 "macros.asm"                    ; Macro definitions to make the code more readable
include                 "FZXdriver.asm"                 ; FZX proportional font routine
include                 "nirvana+.asm"                  ; The NIRVANA+ multicolour graphics engine



if zeusver < 66                                         ; Make sure we have a new enough version for bleeding-edge features!
  zeuserror "Upgrade to Zeus v3.80 or above, available at http://www.desdes.com/products/oldfiles/zeus.htm."
endif



; Make tape file
End                     equ NIRVANA_org+9054            ; Calculate the last byte of our program
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

