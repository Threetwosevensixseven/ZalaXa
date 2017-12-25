; main.asm

zeusemulate             "48K"                           ; Tell the Zeus emulator to be a 48K Spectrum
zoLogicOperatorsHighPri = false                         ; Zeus assembler options
zoSupportStringEscapes  = false                         ;   (see Config tab
zoAllowFloatingLabels   = false                         ;   for details)
Zeus_PC                 = Start                         ; Tell the Zeus emulator where to start running code at
org                     $8000                           ; Tell the Zeus assembler where to place the code



Start                   proc                            ; A named PROCedure (also our start point)
                        jp Start                         ; Go into an endless loop!
pend

