org $9000


x1:	defw 0000
x2:	defw 0002
y1:	defw 0000
y2:	defw 0000


;case test
;bresenham (    00,     05,     05,     05);//case 1
gfx_x1:		defw 128
gfx_x2:		defw $0000
gfx_y1:		defw 96
gfx_y2:		defw $0000


;case 1  DX larger
;bresenham (    00,     05,     05,     05);//case 1
;gfx_x1:		defw $0000
;gfx_x2:		defw $0005
;gfx_y1:		defw $0005
;gfx_y2:		defw $0005


;case 2  DX larger
;bresenham (    05,     00,     05,     05);//case 2
;gfx_x1:	;defw $0005
;gfx_x2:	;defw $0000
;gfx_y1:	;defw $0005
;gfx_y2:	;defw $0005

;case 3  DY larger
;bresenham (    05,     05,     00,     05);//case 3
;gfx_x1:	;defw $0005
;gfx_x2:	;defw $0005
;gfx_y1:	;defw $0000
;gfx_y2:	;defw $0005

;case 4  DY larger
;bresenham (    05,     05,     05,     00);//case 4
;gfx_x1:	;defw $0005
;gfx_x2:	;defw $0005
;gfx_y1:	;defw $0005
;gfx_y2:	;defw $0000
 
;case 5  DY larger
;bresenham (    00,     05,     00,     05);//case 5
;gfx_x1:	;defw $0000
;gfx_x2:	;defw $0005
;gfx_y1:	;defw $0000
;gfx_y2:	;defw $0005

;case 6  DY larger
;bresenham (    00,     05,     05,     00);//case 6
;gfx_x1:	;defw $0000
;gfx_x2:	;defw $0005
;gfx_y1:	;defw $0005
;gfx_y2:	;defw $0000

;case 7
;bresenham (    05,     00,     00,     05);//case 7
;gfx_x1:	;defw $0005
;gfx_x2:	;defw $0000
;gfx_y1:	;defw $0000
;gfx_y2:	;defw $0005

;case 8
;/bresenham (    05,     00,     05,     00);//case 8
;gfx_x1:	;defw $0005
;gfx_x2:	;defw $0000
;gfx_y1:	;defw $0005
;gfx_y2:	;defw $0000



dy:			defw 0000
dx:			defw 0000

fraction:	defw 0000
stepy:		defb 00
stepx:		defb 00


PUBLIC X_PositionBits
X_PositionBits:
defb 128,64,32,16,8,4,2,1

