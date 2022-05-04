
beforesaver
	org &5cc6
savememhere
loader
	ld hl,&8000
	ld de,&5cc6
	ld bc,endloader-loader
	ldir
	jp &5cc6+jmploader-loader
jmploader	di
	im 1
	ld sp,&5ffe
	XOR A
	OUT (&FE),A
	ei
	call loadswitchtodisc
	ld hl,loadscreenmess
	call loadsetheader
	ld hl,&4000
	ld de,&1b00
	call loadprog

 	ld hl,loadcodemess
	call loadsetheader

	ld de,&ffff-&6000
	ld hl,&6000
	call loadprog
	
	ld hl,loadmusicmess
	call loadsetheader
	ld de,&3fff
	ld hl,&c000
	ld c,3
	call loadprog1

vvv	ld a,1 
	ld (ifmem128),a

	call loadswitchtomem
	di
	jp entercodehere


loadsetheader
	ld b,10
	ld c,00000011b
	ld d,0
	ld e,1
	call &106	;;;dos open
	ret
	
	ld b,10
	jp &10f	;;ref head  sets ix to header


loadprog	ld c,0
loadprog1	ld b,10
	call &112	;;;dos read

;	ld bc,&8000
;motordelay	dec bc
;	bit 7,b
;	jr z,motordelay


	ld b,10
	call &109	;;dos close
	jp &19c	;;motor off


loadswitchtodisc
	di
	ld bc,&7ffd
	ld a,(&5b5c)
	res 4,a
	or 7
	ld (&5b5c),a
	out (c),a
	ei
	ret

loadswitchtomem
	di
	ld bc,&7ffd
	ld a,(&5b5c)
	and 11111000b
	ld (&5b5c),a
	out (c),a
	ei
	ret

loadmusicmess	defb "MUSIC.DIZ",255
loadscreenmess	defb "SCREEN.DIZ",255	
loadcodemess	defb "GAME.DIZ",255

endloader


	if save=1
saver	exec saver
	endif
savetodisc
	if disc=0
	call switchtomem
	endif


	if disc=1
	call switchtodisc
 	ld hl,loadermess
	call setheader
	ld de,&100
	ld hl,&5cc6
	call saveprog

	endif

 	ld hl,screenmess
	call setheader
	ld de,&5b00-&4000
	ld hl,&4000
	call saveprog

 	ld hl,codemess
	call setheader
	ld de,&ffff-&6000
	ld hl,&6000
	call saveprog

	ld hl,musicmess
	call setheader
	ld de,&3fff
	ld hl,&c000
	ld c,3
	call saveprog1

	call switchtomem
	
	di
	jp entercodehere

	if disc=1

setheader	ld b,10
	ld c,00000011b
	ld d,1
	ld e,3
	call &106	;;;dos open
	
	ld b,10
	jp &10f	;;ref head  sets ix to header


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
setheader	ret
saveprog1	di
	call ramon
	ei
saveprog	push hl
	pop ix
	ld a,255
	scf
	call &4c2
	di
	call ramoff
	ei	
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

loadermess	defb "loader.diz",255
screenmess	defb "screen.diz",255
musicmess	defb "music.diz",255
codemess	defb "game.diz",255

;endsaver	
;	org beforesaver
;

	org beforesaver,beforesaver


