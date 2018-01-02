; constants.asm



; Game
Stack                   equ Start-1                     ; Put our stack right below the program
BinPath                 equ "..\bin"                    ; Relative to main.asm
TapFile                 equ BinPath+"\ZalaXa.tap"       ; Filename of tap file
SMC                     equ 0                           ; Semantic placeholder for operands that wil be self-modified



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



; ROM
CHAN_OPEN               equ $1601                       ; ROM routine to select which channel to print to
ChannelUpper            equ 2                           ; Channel 2 is the upper screen
PR_STRING               equ $203C                       ; ROM routine to print a string of characters
ULAPort                 equ $FE                         ; ULA port for setting the border and reading keys
FRAMES                  equ $5C78                       ; Spectrum ROM Frame counter



; Screen
AttributeAddress        equ $5800                       ; Start of the attributes in the Spectrum display file
AttributeLength         equ $300                        ; There are 768 bytes of attributes
NAttrVOffset            equ 82                          ; NIRVANA+ attribute offset between lines
BS                      equ 8
CR                      equ 13
Ink                     equ 16
Paper                   equ 17
Flash                   equ 18
Dim                     equ %00000000
Bright                  equ %01000000
PrBright                equ 19
Inverse                 equ 20
Over                    equ 21
At                      equ 22
Tab                     equ 23
Black                   equ 0
Blue                    equ 1
Red                     equ 2
Magenta                 equ 3
Green                   equ 4
Cyan                    equ 5
Yellow                  equ 6
White                   equ 7
BlackP                  equ 8*Black
BlueP                   equ 8*Blue
RedP                    equ 8*Red
MagentaP                equ 8*Magenta
GreenP                  equ 8*Green
CyanP                   equ 8*Cyan
YellowP                 equ 8*Yellow
WhiteP                  equ 8*White
DimBlack                equ Black
DimBlue                 equ Blue
DimRed                  equ Red
DimMagenta              equ Magenta
DimGreen                equ Green
DimCyan                 equ Cyan
DimYellow               equ Yellow
DimWhite                equ White
BrightBlack             equ Black+Bright
BrightBlue              equ Blue+Bright
BrightRed               equ Red+Bright
BrightMagenta           equ Magenta+Bright
BrightGreen             equ Green+Bright
BrightCyan              equ Cyan+Bright
BrightYellow            equ Yellow+Bright
BrightWhite             equ White+Bright
DimBlackBlackP          equ DimBlack+BlackP
DimBlueBlackP           equ DimBlue+BlackP
DimRedBlackP            equ DimRed+BlackP
DimMagentaBlackP        equ DimMagenta+BlackP
DimGreenBlackP          equ DimGreen+BlackP
DimCyanBlackP           equ DimCyan+BlackP
DimYellowBlackP         equ DimYellow+BlackP
DimWhiteBlackP          equ DimWhite+BlackP
BrightBlackBlackP       equ BrightBlack+BlackP
BrightBlueBlackP        equ BrightBlue+BlackP
BrightRedBlackP         equ BrightRed+BlackP
BrightMagentaBlackP     equ BrightMagenta+BlackP
BrightGreenBlackP       equ BrightGreen+BlackP
BrightCyanBlackP        equ BrightCyan+BlackP
BrightYellowBlackP      equ BrightYellow+BlackP
BrightWhiteBlackP       equ BrightWhite+BlackP
DimBlackBlueP           equ DimBlack+BlueP
DimBlueBlueP            equ DimBlue+BlueP
DimRedBlueP             equ DimRed+BlueP
DimMagentaBlueP         equ DimMagenta+BlueP
DimGreenBlueP           equ DimGreen+BlueP
DimCyanBlueP            equ DimCyan+BlueP
DimYellowBlueP          equ DimYellow+BlueP
DimWhiteBlueP           equ DimWhite+BlueP
BrightBlackBlueP        equ BrightBlack+BlueP
BrightBlueBlueP         equ BrightBlue+BlueP
BrightRedBlueP          equ BrightRed+BlueP
BrightMagentaBlueP      equ BrightMagenta+BlueP
BrightGreenBlueP        equ BrightGreen+BlueP
BrightCyanBlueP         equ BrightCyan+BlueP
BrightYellowBlueP       equ BrightYellow+BlueP
BrightWhiteBlueP        equ BrightWhite+BlueP
DimBlackRedP            equ DimBlack+RedP
DimBlueRedP             equ DimBlue+RedP
DimRedRedP              equ DimRed+RedP
DimMagentaRedP          equ DimMagenta+RedP
DimGreenRedP            equ DimGreen+RedP
DimCyanRedP             equ DimCyan+RedP
DimYellowRedP           equ DimYellow+RedP
DimWhiteRedP            equ DimWhite+RedP
BrightBlackRedP         equ BrightBlack+RedP
BrightBlueRedP          equ BrightBlue+RedP
BrightRedRedP           equ BrightRed+RedP
BrightMagentaRedP       equ BrightMagenta+RedP
BrightGreenRedP         equ BrightGreen+RedP
BrightCyanRedP          equ BrightCyan+RedP
BrightYellowRedP        equ BrightYellow+RedP
BrightWhiteRedP         equ BrightWhite+RedP
DimBlackMagentaP        equ DimBlack+MagentaP
DimBlueMagentaP         equ DimBlue+MagentaP
DimRedMagentaP          equ DimRed+MagentaP
DimMagentaMagentaP      equ DimMagenta+MagentaP
DimGreenMagentaP        equ DimGreen+MagentaP
DimCyanMagentaP         equ DimCyan+MagentaP
DimYellowMagentaP       equ DimYellow+MagentaP
DimWhiteMagentaP        equ DimWhite+MagentaP
BrightBlackMagentaP     equ BrightBlack+MagentaP
BrightBlueMagentaP      equ BrightBlue+MagentaP
BrightRedMagentaP       equ BrightRed+MagentaP
BrightMagentaMagentaP   equ BrightMagenta+MagentaP
BrightGreenMagentaP     equ BrightGreen+MagentaP
BrightCyanMagentaP      equ BrightCyan+MagentaP
BrightYellowMagentaP    equ BrightYellow+MagentaP
BrightWhiteMagentaP     equ BrightWhite+MagentaP
DimBlackGreenP          equ DimBlack+GreenP
DimBlueGreenP           equ DimBlue+GreenP
DimRedGreenP            equ DimRed+GreenP
DimMagentaGreenP        equ DimMagenta+GreenP
DimGreenGreenP          equ DimGreen+GreenP
DimCyanGreenP           equ DimCyan+GreenP
DimYellowGreenP         equ DimYellow+GreenP
DimWhiteGreenP          equ DimWhite+GreenP
BrightBlackGreenP       equ BrightBlack+GreenP
BrightBlueGreenP        equ BrightBlue+GreenP
BrightRedGreenP         equ BrightRed+GreenP
BrightMagentaGreenP     equ BrightMagenta+GreenP
BrightGreenGreenP       equ BrightGreen+GreenP
BrightCyanGreenP        equ BrightCyan+GreenP
BrightYellowGreenP      equ BrightYellow+GreenP
BrightWhiteGreenP       equ BrightWhite+GreenP
DimBlackCyanP           equ DimBlack+CyanP
DimBlueCyanP            equ DimBlue+CyanP
DimRedCyanP             equ DimRed+CyanP
DimMagentaCyanP         equ DimMagenta+CyanP
DimGreenCyanP           equ DimGreen+CyanP
DimCyanCyanP            equ DimCyan+CyanP
DimYellowCyanP          equ DimYellow+CyanP
DimWhiteCyanP           equ DimWhite+CyanP
BrightBlackCyanP        equ BrightBlack+CyanP
BrightBlueCyanP         equ BrightBlue+CyanP
BrightRedCyanP          equ BrightRed+CyanP
BrightMagentaCyanP      equ BrightMagenta+CyanP
BrightGreenCyanP        equ BrightGreen+CyanP
BrightCyanCyanP         equ BrightCyan+CyanP
BrightYellowCyanP       equ BrightYellow+CyanP
BrightWhiteCyanP        equ BrightWhite+CyanP
DimBlackYellowP         equ DimBlack+YellowP
DimBlueYellowP          equ DimBlue+YellowP
DimRedYellowP           equ DimRed+YellowP
DimMagentaYellowP       equ DimMagenta+YellowP
DimGreenYellowP         equ DimGreen+YellowP
DimCyanYellowP          equ DimCyan+YellowP
DimYellowYellowP        equ DimYellow+YellowP
DimWhiteYellowP         equ DimWhite+YellowP
BrightBlackYellowP      equ BrightBlack+YellowP
BrightBlueYellowP       equ BrightBlue+YellowP
BrightRedYellowP        equ BrightRed+YellowP
BrightMagentaYellowP    equ BrightMagenta+YellowP
BrightGreenYellowP      equ BrightGreen+YellowP
BrightCyanYellowP       equ BrightCyan+YellowP
BrightYellowYellowP     equ BrightYellow+YellowP
BrightWhiteYellowP      equ BrightWhite+YellowP
DimBlackWhiteP          equ DimBlack+WhiteP
DimBlueWhiteP           equ DimBlue+WhiteP
DimRedWhiteP            equ DimRed+WhiteP
DimMagentaWhiteP        equ DimMagenta+WhiteP
DimGreenWhiteP          equ DimGreen+WhiteP
DimCyanWhiteP           equ DimCyan+WhiteP
DimYellowWhiteP         equ DimYellow+WhiteP
DimWhiteWhiteP          equ DimWhite+WhiteP
BrightBlackWhiteP       equ BrightBlack+WhiteP
BrightBlueWhiteP        equ BrightBlue+WhiteP
BrightRedWhiteP         equ BrightRed+WhiteP
BrightMagentaWhiteP     equ BrightMagenta+WhiteP
BrightGreenWhiteP       equ BrightGreen+WhiteP
BrightCyanWhiteP        equ BrightCyan+WhiteP
BrightYellowWhiteP      equ BrightYellow+WhiteP
BrightWhiteWhiteP       equ BrightWhite+WhiteP

