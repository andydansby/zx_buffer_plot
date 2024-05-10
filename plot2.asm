
org $9400

_gfx_xy:
defw 0000

;;;;;;;;;;;;;;;;;;
;uses DE/HL/BC
PUBLIC _hellaPlot2
_hellaPlot2:          ; plot d = x-axis, e = y-axis

    ld DE, (_gfx_xy)

    ld A,E
    rra
    scf
    rra
    or A
    rra

    ld H,A
    xor D
    and 11111000b
    xor D
    ld H, A
;;H calculated

    ld A,D
    xor L
    and 00000111b
    xor D
    rrca
    rrca
    rrca

    ld L,A
;;L calculated
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LD A, D
    AND 7

    LD DE, X_PositionBits
    ADD A,E
    LD E,A
    LD A,(DE)

    ;output to screen
    or (HL)
    ld (HL),A


ret














