lda #$00	; set a pointer at $40 to point to $0200
	sta $40
	lda #$02
	sta $41

	lda #$05	; colour
	ldy #$00	; set index to 0

loop:	sta ($40),y	; set pixel
	iny		; increment index
	cpy #$20
	bne loop	; continue until done the page

	ldy #$E0	; last line of 5
	lda #$05	; set page to 5
	sta $41		; set page to 5
	lda #$06
loop2:

	sta ($40),y
	iny
	cpy #$00
	bne loop2

	ldy #$00
	lda #$00	; set a pointer at $40 to point to $0200
	sta $40
	lda #$02
	sta $41

loop3: 
	clc
	lda #$07
	sta ($40),y
	tya		;move y value to a for adding command
	adc #$1f	;add 32 to accumulator (display is 32 pixels wide)
	tay		;transfer new value back to y 
	lda #$04	;load purple
	sta ($40),y
	iny		;increment to start of next line
	cpy #$00	;check if finished page
	bne loop3
	inc $41		;increment page
	ldx $41		;load value of page
	cpx #$06	;check if passed end of display
	bne loop3
