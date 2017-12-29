; main.asm

zeusemulate             "48K"                           ; Tell the Zeus emulator to be a 48K Spectrum
zoLogicOperatorsHighPri = false                         ; Zeus assembler options
zoSupportStringEscapes  = false                         ;   (see Config tab
zoAllowFloatingLabels   = false                         ;   for details)
Zeus_PC                 = Start                         ; Tell the Zeus emulator where to start running code at
org                     $8000                           ; Tell the Zeus assembler where to place the code



Start                   proc                            ; A named PROCedure (also our start point)
                        ld sp, Start                    ; Put our stack right below the program
                        Border(Black)                   ; Set the border to black using a helper macro
                        call ClsAttr                    ; Call another named procedure to do a fast CLS (like GOSUB)
                        Print(MenuText, MenuText.Length); Print text on the screen using ROM routines
WaitForSpace:                                           ; All labels inside procedures are local to that procedure
                        halt                            ; Wait for the next 1/50th second interrupt (like PAUSE 1)
                        ld bc, zeuskeyaddr(" ")         ; Get the IO address to input
                        in a, (c)                       ; Read those 5 keys
                        and zeuskeymask(" ")            ; AND with the bit for SPACE
                        jr z SetupGame                  ; If it's zero the key is pressed
                        jp WaitForSpace                 ; Otherwise check keys again
SetupGame:
                        call ClsAttr                    ; Clear the screen to prove we pressed space
EndlessLoop:
                        halt
                        jp EndlessLoop                  ; Go into an endless loop (for now...)
pend



ClsAttr                 proc                            ; Do an attribute CLS using LDIR block copy
                        xor a                           ; Set a to 0 (blank ink, black paper)
                        ld hl, AttributeAddress         ; Address to start copying from (start of attributes)
                        ld de, AttributeAddress+1       ; Address to start copying to (next byte)
                        ld bc, AttributeLength-1        ; Number of bytes to copy (767, all the attirbutes)
                        ld (hl), a                      ; Set first byte to attribute value
                        ldir                            ; Block copy bytes
                        ret                             ; Return from the procedure (like RETURN)
pend



Border                  macro(Colour)                   ; Macro (makes the code more readable) to set border
                        ld a, Colour                    ; Set a to the colour desired
                        out (ULAPort), a                ;   and output it to the ULA Port (defined in constants)
mend                                                    ; No RET is needed - this code is inserted inline



Print                   macro(TextAddress, TextLength)  ; Macro to print text on the screen using ROM routines
                        ld a, ChannelUpper              ; Channel 2 (defined in constants) is the upper screen
                        call CHAN_OPEN                  ; Open this channel (ROM routine)
PrintLoop:              ld de, TextAddress              ; Address of string to print
                        ld bc, TextLength               ; Length of string to print
                        call PR_STRING                  ; Print string (ROM routine)

mend



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
Length                  equ $-MenuText                 ; Let Zeus do the work of calculating the length
pend                                                   ; ($ means the current address Zeus is assembling to)



; Constants
Stack                   equ Start-1                     ; Put our stack right below the program
AttributeAddress        equ $5800                       ; Start of the attributes in the Spectrum display file
AttributeLength         equ $300                        ; There are 768 bytes of attributes
Ink                     equ 16                          ; These codes are the same
Paper                   equ 17                          ;   as Sinclair Basic's
At                      equ 22                          ;   PRINT statement uses.
Bright                  equ 19
Black                   equ 0
Blue                    equ 1
Red                     equ 2
Magenta                 equ 3
Green                   equ 4
Cyan                    equ 5
Yellow                  equ 6
White                   equ 7
CHAN_OPEN               equ $1601                       ; ROM routine to select which channel to print to
ChannelUpper            equ 2                           ; Channel 2 is the upper screen
PR_STRING               equ $203C                       ; ROM routine to print a string of characters
ULAPort                 equ $FE                         ; ULA port for setting the border and reading keys
BinPath                 equ "..\bin"                    ; Relative to main.asm
TapFile                 equ BinPath+"\ZalaXa.tap"       ; Filename of tap file



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

