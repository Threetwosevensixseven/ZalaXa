; constants.asm



; Game
Stack                   equ Start-1                     ; Put our stack right below the program
BinPath                 equ "..\bin"                    ; Relative to main.asm
TapFile                 equ BinPath+"\ZalaXa.tap"       ; Filename of tap file



; Sprites
Sprites proc
  ALine                 equ NIRVANA_org+147+0*8         ; Line address (NIRVANA_org+147 is 56470, $DC96)
  AColumn               equ ALine-1                     ; Column address
  AIndex                equ ALine+2                     ; Index address

  BLine                 equ NIRVANA_org+147+1*8         ; Line address (NIRVANA_org+147 is 56470, $DC96)
  BColumn               equ BLine-1                     ; Column address
  BIndex                equ BLine+2                     ; Index address

  CLine                 equ NIRVANA_org+147+2*8         ; Line address (NIRVANA_org+147 is 56470, $DC96)
  CColumn               equ CLine-1                     ; Column address
  CIndex                equ CLine+2                     ; Index address

  DLine                 equ NIRVANA_org+147+3*8         ; Line address (NIRVANA_org+147 is 56470, $DC96)
  DColumn               equ DLine-1                     ; Column address
  DIndex                equ DLine+2                     ; Index address

  ELine                 equ NIRVANA_org+147+4*8         ; Line address (NIRVANA_org+147 is 56470, $DC96)
  EColumn               equ ELine-1                     ; Column address
  EIndex                equ ELine+2                     ; Index address

  FLine                 equ NIRVANA_org+147+5*8         ; Line address (NIRVANA_org+147 is 56470, $DC96)
  FColumn               equ FLine-1                     ; Column address
  FIndex                equ FLine+2                     ; Index address

  BTileLen              equ 48                          ; 16x16 pixels (32) + 16x8 attributes (16)
  WTileLen              equ 72                          ; 24x16 pixels (48) + 24x8 attributes (24)
pend
NIRVANA_org             equ 56323
ENABLE_WIDE_SPRITE      equ true
ENABLE_WIDE_DRAW        equ true


; Screen
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



; ROM
CHAN_OPEN               equ $1601                       ; ROM routine to select which channel to print to
ChannelUpper            equ 2                           ; Channel 2 is the upper screen
PR_STRING               equ $203C                       ; ROM routine to print a string of characters
ULAPort                 equ $FE                         ; ULA port for setting the border and reading keys
FRAMES                  equ $5C78                       ; Spectrum ROM Frame counter

