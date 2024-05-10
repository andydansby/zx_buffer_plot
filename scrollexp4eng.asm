
;	176 wide X
;	256 tall Y

org	32768

altura:			defb	0;0				;Height
spstore:		defw	0				;Original SP value
lastsp:			defw	0				;Last SP value during the dump
buffer:			;INCBIN "tall_img.bin"


startofGraph:	defb $00	;082E8H
compgraph:		INCBIN "table7.bin"
;size #2371 / 9073

;full image runs from $82e9 to $a659
;half image runs from $82e9 to $94A0
endofGraph:		defb 0	;0A659H


tiles_Y:		defb 24
tiles_X:		defb 24


;0 no scroll

;1 slow scroll down
;2 standard scroll down
;8 fast scroll down game limit

;255 slow scroll up
;254 standard scroll up
;253 faster up
;252 faster up
;251 faster up
;250 faster up
;249 faster up
;248 fast scroll game limit

;256 crash
;SPEED:	defb 0
SPEED	EQU	1

SPEED2: defb 1


	
clear_screen:
	xor	a
	ld	de,16385
	ld	hl,16384
	ld	bc,6144
	ld	(hl),a
	ldir
	ld	a,7			;7
	ld	bc,767
	ld	(hl),a
	ldir			;INK 7:PAPER 0: CLS

;ld hl, compgraph
;ld de, buffer
;	ld	hl,compgraph
;	ld	de,buffer
;	call	deexo	;Uncompress graphic in buffer

;192 y
;382 x

init:
	ld a,0
	;ld	de,buffer	;Initial values
	ld de,compgraph	;Initial values grab value for gfx start

loophere:
	ld	(altura), a	;altura = height	write value to altura
	;since this is on the A register image can only be 256

	;cp 80
	cp 215	;what is this for?
	
	push de			;First store buffer pointer
	jr c,easy		;So if C<=80, we can use the just one dump version

	push de			;Store buffer pointer again

	;ld hl,compgraph+24*256	;Buffer end
	ld hl, compgraph + 24 * 334;	Buffer end
	
	;ld hl, endofGraph
	
	sbc	hl,de			;Calculate remaining length between buffer end and current position
	ld	(firstlenght+1),hl	;Store it for the first dump
	
	
	;;;;;;;;;;;;;;;;;;;
	ex	de,hl

	;ld	hl,24*176
	ld hl, 24 * 176
	
	sbc	hl,de			;Calculate remaining length to be moved
	ld	(secondlenght+1),hl	;Store it for the second dump
	pop	hl			;Restore buffer pointer

firstlenght:
	ld	bc,0
	call volcado1		;Dump upper part of the screen / down in buffer
	ld hl, compgraph	;Upper part of the buffer

secondlenght:
	ld bc,0
	ld ix,(lastsp)		;Recover the screen pointer last position
	call volcado2		;Dump the lower screen part / up in buffer

endeasy:
	pop hl				;Recover buffer pointer
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;ld bc, -24 * (SPEED2)
	ld bc, -24 * SPEED;;works

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	add	hl,bc			;Update buffer pointer
	ex de,hl			;To DE
	
	ld a, (altura)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

sub SPEED

;testing
;push hl
;	ld l, (SPEED2)
	;sbc a,(hl)
;	sub l
;pop hl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	jp nc, loophere		;If there's no jump, go back to loop

	;ld hl,24*256		;ld hl,24*256
	ld hl, 24 * 256
	
	add hl,de			;Adjust buffer pointer
	ex de,hl			;To DE
	jp loophere			;Back to loop

easy:
	ex de,hl			;Buffer pointer to HL
	call volcado0		;Dump all
	jr endeasy			;Go to end of routine


volcado0:
	;ld bc,24*176		;Total length
	ld bc, 24 * 176

volcado1:
	ld ix,screentable+16	;Screen start

	halt				;Synchronize
	ld de,800			;Pause counter
waitfor_raster:
	dec	de
	ld a,d
	or e
	jr nz,waitfor_raster	;Wait for raster to pass the start of screen

volcado2:
	ld (spstore),sp		;Store stack pointer
	di					;Disable interrupts
	ld	sp,ix			;SP points to line address table

doit:
	pop	de				;Destination address in DE, taken from the table
	;dec	bc				;Adjust extra byte in BC
	ldi					;Start dumping the line
	ldi
	ldi
	ldi				; 4
	ldi
	ldi
	ldi
	ldi				; 8
	ldi
	ldi
	ldi
	ldi				;12
	ldi
	ldi
	ldi
	ldi				;16
	ldi
	ldi
	ldi
	ldi				;20
	ldi
	ldi
	ldi				;23
	;inc hl	;Extra byte for horizontal clipping
	ldi				;24
	
	jp pe,doit	;Loop, continue until BC = 0
			
	ld (lastsp),sp		;Store SP value in case we're doing two dumps
	ld sp,(spstore)		;Restore SP
	ei					;Enable interrupt

;	halt				;Uncomment to simulate a bigger pause
;	halt

ret				;Back

	;INCLUDE	"deexo.asm"		;Decompression routine

screentable:
;Address table, changing the "+8" we can set the active area in another place
	dw	16384+0*256+0*32+4	;1
	dw	16384+1*256+0*32+4	;2
	dw	16384+2*256+0*32+4	;3
	dw	16384+3*256+0*32+4	;4
	dw	16384+4*256+0*32+4	;5
	dw	16384+5*256+0*32+4	;6
	dw	16384+6*256+0*32+4	;7
	dw	16384+7*256+0*32+4	;8
	dw	16384+0*256+1*32+4	;9
	dw	16384+1*256+1*32+4	;10
	dw	16384+2*256+1*32+4	;11
	dw	16384+3*256+1*32+4	;12
	dw	16384+4*256+1*32+4	;13
	dw	16384+5*256+1*32+4	;14
	dw	16384+6*256+1*32+4	;15
	dw	16384+7*256+1*32+4	;16
	dw	16384+0*256+2*32+4	;17
	dw	16384+1*256+2*32+4	;18
	dw	16384+2*256+2*32+4	;19
	dw	16384+3*256+2*32+4	;20
	dw	16384+4*256+2*32+4	;21
	dw	16384+5*256+2*32+4	;22
	dw	16384+6*256+2*32+4	;23
	dw	16384+7*256+2*32+4	;24
	dw	16384+0*256+3*32+4	;25
	dw	16384+1*256+3*32+4	;26
	dw	16384+2*256+3*32+4	;27
	dw	16384+3*256+3*32+4	;28
	dw	16384+4*256+3*32+4	;29
	dw	16384+5*256+3*32+4	;30
	dw	16384+6*256+3*32+4	;31
	dw	16384+7*256+3*32+4	;32
	dw	16384+0*256+4*32+4	;33
	dw	16384+1*256+4*32+4	;34
	dw	16384+2*256+4*32+4	;35
	dw	16384+3*256+4*32+4	;36
	dw	16384+4*256+4*32+4	;37
	dw	16384+5*256+4*32+4	;38
	dw	16384+6*256+4*32+4	;39
	dw	16384+7*256+4*32+4	;40
	dw	16384+0*256+5*32+4	;41
	dw	16384+1*256+5*32+4	;42
	dw	16384+2*256+5*32+4	;43
	dw	16384+3*256+5*32+4	;44
	dw	16384+4*256+5*32+4	;45
	dw	16384+5*256+5*32+4	;46
	dw	16384+6*256+5*32+4	;47
	dw	16384+7*256+5*32+4	;48
	dw	16384+0*256+6*32+4	;49
	dw	16384+1*256+6*32+4	;50
	dw	16384+2*256+6*32+4	;51
	dw	16384+3*256+6*32+4	;52
	dw	16384+4*256+6*32+4	;53
	dw	16384+5*256+6*32+4	;54
	dw	16384+6*256+6*32+4	;55
	dw	16384+7*256+6*32+4	;56
	dw	16384+0*256+7*32+4	;57
	dw	16384+1*256+7*32+4	;58
	dw	16384+2*256+7*32+4	;59
	dw	16384+3*256+7*32+4	;60
	dw	16384+4*256+7*32+4	;61
	dw	16384+5*256+7*32+4	;62
	dw	16384+6*256+7*32+4	;63
	dw	16384+7*256+7*32+4	;64

	dw	16384+0*256+0*32+4+2048	;65
	dw	16384+1*256+0*32+4+2048	;66
	dw	16384+2*256+0*32+4+2048	;67
	dw	16384+3*256+0*32+4+2048	;68
	dw	16384+4*256+0*32+4+2048	;69
	dw	16384+5*256+0*32+4+2048	;70
	dw	16384+6*256+0*32+4+2048	;71
	dw	16384+7*256+0*32+4+2048	;72
	dw	16384+0*256+1*32+4+2048	;73
	dw	16384+1*256+1*32+4+2048	;74
	dw	16384+2*256+1*32+4+2048	;75
	dw	16384+3*256+1*32+4+2048	;76
	dw	16384+4*256+1*32+4+2048	;77
	dw	16384+5*256+1*32+4+2048	;78
	dw	16384+6*256+1*32+4+2048	;79
	dw	16384+7*256+1*32+4+2048	;80
	dw	16384+0*256+2*32+4+2048	;81
	dw	16384+1*256+2*32+4+2048	;82
	dw	16384+2*256+2*32+4+2048	;83
	dw	16384+3*256+2*32+4+2048	;84
	dw	16384+4*256+2*32+4+2048	;85
	dw	16384+5*256+2*32+4+2048	;86
	dw	16384+6*256+2*32+4+2048	;87
	dw	16384+7*256+2*32+4+2048	;88
	dw	16384+0*256+3*32+4+2048	;89
	dw	16384+1*256+3*32+4+2048	;90
	dw	16384+2*256+3*32+4+2048	;91
	dw	16384+3*256+3*32+4+2048	;92
	dw	16384+4*256+3*32+4+2048	;93
	dw	16384+5*256+3*32+4+2048	;94
	dw	16384+6*256+3*32+4+2048	;95
	dw	16384+7*256+3*32+4+2048	;96
	dw	16384+0*256+4*32+4+2048	;97
	dw	16384+1*256+4*32+4+2048	;98
	dw	16384+2*256+4*32+4+2048	;99
	dw	16384+3*256+4*32+4+2048	;100
	dw	16384+4*256+4*32+4+2048	;101
	dw	16384+5*256+4*32+4+2048	;102
	dw	16384+6*256+4*32+4+2048	;103
	dw	16384+7*256+4*32+4+2048	;104
	dw	16384+0*256+5*32+4+2048	;105
	dw	16384+1*256+5*32+4+2048	;106
	dw	16384+2*256+5*32+4+2048	;107
	dw	16384+3*256+5*32+4+2048	;108
	dw	16384+4*256+5*32+4+2048	;109
	dw	16384+5*256+5*32+4+2048	;110
	dw	16384+6*256+5*32+4+2048	;111
	dw	16384+7*256+5*32+4+2048	;112
	dw	16384+0*256+6*32+4+2048	;113
	dw	16384+1*256+6*32+4+2048	;114
	dw	16384+2*256+6*32+4+2048	;115
	dw	16384+3*256+6*32+4+2048	;116
	dw	16384+4*256+6*32+4+2048	;117
	dw	16384+5*256+6*32+4+2048	;118
	dw	16384+6*256+6*32+4+2048	;119
	dw	16384+7*256+6*32+4+2048	;120
	dw	16384+0*256+7*32+4+2048	;121
	dw	16384+1*256+7*32+4+2048	;122
	dw	16384+2*256+7*32+4+2048	;123
	dw	16384+3*256+7*32+4+2048	;124
	dw	16384+4*256+7*32+4+2048	;125
	dw	16384+5*256+7*32+4+2048	;126
	dw	16384+6*256+7*32+4+2048	;127
	dw	16384+7*256+7*32+4+2048	;128

	dw	16384+0*256+0*32+4+4096	;129
	dw	16384+1*256+0*32+4+4096	;130
	dw	16384+2*256+0*32+4+4096	;131
	dw	16384+3*256+0*32+4+4096	;132
	dw	16384+4*256+0*32+4+4096	;133
	dw	16384+5*256+0*32+4+4096	;134
	dw	16384+6*256+0*32+4+4096	;135
	dw	16384+7*256+0*32+4+4096	;136
	dw	16384+0*256+1*32+4+4096	;137
	dw	16384+1*256+1*32+4+4096	;138
	dw	16384+2*256+1*32+4+4096	;139
	dw	16384+3*256+1*32+4+4096	;140
	dw	16384+4*256+1*32+4+4096	;141
	dw	16384+5*256+1*32+4+4096	;142
	dw	16384+6*256+1*32+4+4096	;143
	dw	16384+7*256+1*32+4+4096	;144
	dw	16384+0*256+2*32+4+4096	;145
	dw	16384+1*256+2*32+4+4096	;146
	dw	16384+2*256+2*32+4+4096	;147
	dw	16384+3*256+2*32+4+4096	;148
	dw	16384+4*256+2*32+4+4096	;149
	dw	16384+5*256+2*32+4+4096	;150
	dw	16384+6*256+2*32+4+4096	;151
	dw	16384+7*256+2*32+4+4096	;152
	dw	16384+0*256+3*32+4+4096	;153
	dw	16384+1*256+3*32+4+4096	;154
	dw	16384+2*256+3*32+4+4096	;155
	dw	16384+3*256+3*32+4+4096	;156
	dw	16384+4*256+3*32+4+4096	;157
	dw	16384+5*256+3*32+4+4096	;158
	dw	16384+6*256+3*32+4+4096	;159
	dw	16384+7*256+3*32+4+4096	;160
	dw	16384+0*256+4*32+4+4096	;161
	dw	16384+1*256+4*32+4+4096	;162
	dw	16384+2*256+4*32+4+4096	;163
	dw	16384+3*256+4*32+4+4096	;164
	dw	16384+4*256+4*32+4+4096	;165
	dw	16384+5*256+4*32+4+4096	;166
	dw	16384+6*256+4*32+4+4096	;167
	dw	16384+7*256+4*32+4+4096	;168
	dw	16384+0*256+5*32+4+4096	;169
	dw	16384+1*256+5*32+4+4096	;170
	dw	16384+2*256+5*32+4+4096	;171
	dw	16384+3*256+5*32+4+4096	;172
	dw	16384+4*256+5*32+4+4096	;173
	dw	16384+5*256+5*32+4+4096	;174
	dw	16384+6*256+5*32+4+4096	;175
	dw	16384+7*256+5*32+4+4096	;176
	dw	16384+0*256+6*32+4+4096	;177
	dw	16384+1*256+6*32+4+4096	;178
	dw	16384+2*256+6*32+4+4096	;179
	dw	16384+3*256+6*32+4+4096	;180
	dw	16384+4*256+6*32+4+4096	;181
	dw	16384+5*256+6*32+4+4096	;182
	dw	16384+6*256+6*32+4+4096	;183
	dw	16384+7*256+6*32+4+4096	;184
	dw	16384+0*256+7*32+4+4096	;185
	dw	16384+1*256+7*32+4+4096	;186
	dw	16384+2*256+7*32+4+4096	;187
	dw	16384+3*256+7*32+4+4096	;188
	dw	16384+4*256+7*32+4+4096	;189
	dw	16384+5*256+7*32+4+4096	;190
	dw	16384+6*256+7*32+4+4096	;191
	dw	16384+7*256+7*32+4+4096	;192





