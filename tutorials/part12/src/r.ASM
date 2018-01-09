zeusemulate             "48K"                           ; Tell the Zeus emulator to be a 48K Spectrum
Zeus_PC                 = $8000                         ; Tell the Zeus emulator where to start running code at
org                     $8000                           ; Tell the Zeus assembler where to place the code
                        ei
Loop:
                        zeusdatabreakpoint 1, "zeusprint(1, r), r=127", $
                        jp Loop

