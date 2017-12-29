; sprites.asm



AnimateDemo             proc

                        ld a, (FRAMES)
                        ld b, a
                        and %00000111
                        ret nz

                        ld a, (Sprites.AIndex)
                        xor %00000001
                        ld (Sprites.AIndex), a
                        ret
pend

