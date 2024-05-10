org $9200

    ;   if (dx > dy)
    ;   {
dxLarger:


;;;;;;;;;;;;;;;;;; 
;        fraction = dy - (dx >> 1);

    ld DE, (dx)
    
    ;shift dx to the right 1 bit
    SRL D
    RR E

    ld HL, (dy)
    sbc HL, DE
    ld (fraction), HL
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;   do
;   {
DX_loop:
;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;PLOT PIXEL
    ;gfx_x = x1
    ;gfx_y = y1;
    ;rtunes_pixel();
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;
;if (fraction >= 0)
    ld HL, (fraction)
    ld A, 0
    cp (HL)
    jr C, lessThan_HL_1   ; A was less than the operand.
    jr Z, equalTo_HL_1   ; A was exactly equal to the operand
;;        checks to see if FRACTION is less than 0
;;        jump if it is less than 0
;;        otherwise fall through


;;        if we get here then FRACTION is greater than 0
greaterThanHL_1:
    ; A was not less than the operand, and was not
    ; equal to the operand. Therefore it must have
    ; been greater than the operand.
    
    
    
;;;;;;;;;;;;;;;;;;
;            x1 += stepx;
    ld HL, (x1)
    ld DE, (stepx)
    add HL, DE
    ld (x1), HL
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;            fraction += dy;
    ld HL, (fraction)
    ld DE, (dy)
    add HL, DE
    ld (fraction), HL
;;;;;;;;;;;;;;;;;;


jp loop_again  ;; check to see if we need another iteration


;;        if we get here then FRACTION is less than 0
lessThan_HL_1:
;;        if we get here then FRACTION is equal to  0
equalTo_HL_1:

;;;;;;;;;;;;;;;;;;
;                y1 += stepy;
    ld HL, (y1)
    ld DE, (stepy)
    add HL, DE
    ld (y1), HL
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;
;                fraction -= dx;
    ld HL, (fraction)
    ld DE, (dx)
    sbc HL, DE
    ld (fraction), HL
;;;;;;;;;;;;;;;;;;


loop_again:
    ;check to see if x1 and x2 are equal
    cp A ;reset zero flags
    ld HL, (x1)
    ld DE, (x2)
    sbc HL, DE
	
	
    ;check to see if x1 and x2 are equal
    ;if they are not equal loop
    ;jr nz, DX_loop  ;jp nz, DX_loop 
;   } while (x1 != x2)
;working on



forever_loop:
    jp forever_loop
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;