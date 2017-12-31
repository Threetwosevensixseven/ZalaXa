; utilities.asm



ClsAttr                 proc                            ; Do an attribute CLS using LDIR block copy
                        xor a                           ; Set a to 0 (blank ink, black paper)
                        ld hl, AttributeAddress         ; Address to start copying from (start of attributes)
                        ld de, AttributeAddress+1       ; Address to start copying to (next byte)
                        ld bc, AttributeLength-1        ; Number of bytes to copy (767, all the attirbutes)
                        ld (hl), a                      ; Set first byte to attribute value
                        ldir                            ; Block copy bytes
                        ret                             ; Return from the procedure (like RETURN)
pend

