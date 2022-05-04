;;;;use usual dl1    ;;;below &6000 one
;master.spc           creates MASTER MAKER TAPE
;this assembles and sends down at &5cc6 len &200
;it automatically saves itself to tape and a basic
;loader is needed which loads a headerless file at &8000
;and calls &8000   it relocates before running

	skip 10
	send computer2
	org &5CC6

disc	equ 0

master	ld hl,&8000
	ld de,&5cc6
	ld bc,&200
	ldir
	jp &5cc6+jmpmaster-master
jmpmaster	di
	ld sp,&5ffe
	IM 1
	ei

	ld hl,loadermess
	call setheader
	ld hl,&6000
	ld de,&100		;;length of loader
	call loadprogandsave

	ld hl,screenmess
	call setheader
	ld hl,&6000
	ld de,&1b00			;;length of screen	
	call loadprogandsave

	ld hl,codemess
	call setheader
	ld hl,&6000
	ld de,&ffff-&6000			;;length of code
	call loadprogandsave

	ld hl,musicmess
	call setheader
	ld hl,&6000
	ld de,&3fff		;;length of 128k music file
	call loadprogandsave

done1	ld a,255
	ld (23692),a		;;;scroll forever
	ld ix,done
	call prtmessage
	jr done1

	
printchr	ld ix,(23633)
	ld l,(ix+0)
	ld h,(ix+1)
	jp (hl)
	
prtmessage 
	ld a,(ix+0)
	cp 255
	ret z
	push ix
	call printchr
	pop ix
	inc ix
	jr prtmessage 

waitforkey	call &28e
	ld a,e
	cp 255
	jr z,waitforkey
	ret

save	call switchtomem
	ld a,255
	scf
	call &4c2
	ret c
	call 0

switchtodisc
	di
	ld bc,port1
	ld a,(bankm)
	res 4,a
	or 7
	ld (bankm),a
	out (c),a
	ei
	ret

switchtomem
	di
	ld bc,port1
	ld a,(bankm)
	set 4,a
	and &f8
	ld (bankm),a
	out (c),a
	ei
	ret


setheader	equ switchtomem

loadprogandsave

	push hl
	push de
	ld ix,keytoloadmess
	call prtmessage
	call waitforkey
	pop de
	pop hl

	push hl
	push hl
	pop ix
	push de
	ld a,255
	scf
	call &556	;;;load

	call nc,0

	ld ix,keytosavemess
	call prtmessage
	call waitforkey
	pop de
	pop ix
	jp save

port1	equ &7ffd
bankm	equ &5b5c

keytosavemess
	defb 13,"PRESS ANY KEY TO SAVE",255
keytoloadmess
	defb 13,"PRESS ANY KEY TO LOAD",255
done	defb 13,"done",255
loadermess	defb "tapeload.diz",255
screenmess	defb "screen.diz",255
musicmess	defb "music.diz",255
codemess	defb "game.diz",255
mastermess	defb "save2.cod",255

saveit
	di
	im 1
	ld sp,&5ffe

	call switchtomem

	ld de,&200
	ld ix,&5cc6
	ld a,255
	scf
	call &4c2

	jp &5cc6+jmpmaster-master
endhere
	end saveit



