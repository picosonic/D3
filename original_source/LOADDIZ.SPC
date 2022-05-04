;;;loader.spc   this is the tape loader at &5cc6 len &100
;;will load screen,game  set mem128  and load music
;;assembles separately and saves itself to tape


	skip 10
	send computer2	

	org &5cc6

disc	equ 0
	
	di	
	ld sp,&5f00-2
	ei

	xor a
	ld (&fe),a
	ld hl,&4000
	ld bc,&1b00-1
loop	ld (hl),a
	inc hl
	dec bc
	bit 7,b
	jr z,loop

	ld de,&1b00
	ld ix,&4000
	ld a,255
	scf
	call &556
	call nc,0
	ld de,&ffff-&6000
	ld ix,&6000
	ld a,255
	scf
	call &556
	call nc,0
	ld bc,&7ffd
	ld a,(&c000)
	push af
	ld a,13
	ld (&c000),a
	ld a,&13
	out (c),a
	xor a
	ld (23627),a
	ld a,(&c000)
	cp 13
	jr z,only48
	ld a,1
	ld (23627),a
	ld ix,&c000
	ld de,&3fff		;;length ob 128k music
	ld a,255
	scf
	call &556
	call nc,0
	ld bc,&7ffd
	ld a,&10
	out (c),a
only48	pop af
	ld (&c000),a
	di	
	ld sp,&5ffe
	ei	
	jp &6100		;;call address of main code
endloader

exec	exec exec
savetodisc

	if disc=1
	call switchtodisc

 	ld hl,tapeloadermess
	call setheader
	ld de,&100
	ld hl,&5cc6
	call saveprog
	ret

saveprog	ld c,0
saveprog1	ld b,10
	ld (ix+0),3
	ld (ix+1),e
	ld (ix+2),d
	ld (ix+3),l
	ld (ix+4),h
	call &115	;;;dos write


	ld b,10
	jp &109	;;dos close

	endif

	if disc=0
saveprog	call switchtomem

	ld de,&100
	ld ix,&5cc6
	ld a,255
	scf
	call &4c2
	ret

	endif

switchtodisc
	di
	ld bc,&7ffd
	ld a,(&5b5c)
	res 4,a
	or 7
	ld (&5b5c),a
	out (c),a
	ei
	ret

switchtomem
	di
	ld bc,&7ffd
	ld a,(&5b5c)
	and 11111000b
	ld (&5b5c),a
	out (c),a
	ei
	ret

setheader	ld b,10
	ld c,00000011b
	ld d,1
	ld e,3
	call &106	;;;dos open
	
	ld b,10
	jp &10f	;;ref head  sets ix to header


tapeloadermess
	defb "tapeload.diz",255
	end



