	;;spectrum version

dospeech
	ld hl,fwdizzytlk
	ld de,fwdizzytlkend-fwdizzytlk
	call sayit

	call pausegap

	ld a,(bytotcnt)
	inc a
	and 3
	ld (bytotcnt),a
	ret nz

	ld hl,bytottlk
	ld de,bytottlkend-bytottlk
	call sayit

	ld a,100
pausegap1	ld b,0
pausegap	djnz pausegap
	dec a
	jr nz,pausegap1
	ret 

bytotcnt	defb 0

	;;hl points to speech data
	;;de length
 
sayit
sayitlp3	push de

	ld b,8
sayitlp4
	nop
	xor a
	rlc (hl)
	rla
	rla
	rla
	rla
	rla
	out (254),a

	ld a,18
sayitdelay	dec a
	jr nz,sayitdelay

	djnz sayitlp4
	inc hl
	pop de
	dec de
	ld a,d
	cp 255
	jr nz,sayitlp3
	ret


