; Debug settings
seecoins = 0
liquidkills = 0
firekills = 0

; OS defines
INCLUDE "os.asm"
INCLUDE "inkey.asm"
INCLUDE "internal.asm"

; Variable and constant defines
INCLUDE "consts.asm"
INCLUDE "vars.asm"

ORG &00
CLEAR &00, &FF
.plingboot
EQUS "*BASIC", &0D ; Reset to BASIC
EQUS "PAGE=&1200", &0D ; Set PAGE to first file buffer (as we don't open any files from BASIC)
EQUS "*FX21", &0D ; Flush buffer
EQUS "CLOSE#0:CH.", '"', "LOADER", '"', &0D ; Close "!BOOT" and run the main code
EQUS "REM https://github.com/picosonic/D3/", &0D ; Repo URL
EQUS "REM D3 build ", TIME$ ; Add a build date
.plingend
SAVE "!BOOT", plingboot, plingend

INCLUDE "loader2.asm"
SAVE "LOADER", basicstart, basicend, &FF8023, &FF1900

ORG MAIN_LOAD_ADDR
CLEAR MAIN_LOAD_ADDR, MAIN_LOAD_ADDR+&2000
GUARD MODE8BASE

.start
INCLUDE "rooms.asm"

.datastart

; Level tiles, object sprites, font
.frametable
INCBIN "frametable.bin"
.framedefs
INCBIN "framedefs.bin"

; Dizzy sprite offsets
.dizzytable
INCBIN "XTABLE"
.dataend

.codestart
; Import modules
INCLUDE "input.asm"
INCLUDE "rand.asm"
INCLUDE "gfx.asm"

.titlescreen
{
  ; Page in roomdata sideways RAM
  PAGE_ROOMDATA

  LDA #&01:STA dontupdatedizzy ; Stop Dizzy being drawn

  LDA #TITLEROOM:STA roomno
  JSR roomsetup

  ; Print all the title screen text
  LDA #STR_startmess:JSR findroomstr
  JSR prtmessage

  ; Dizzy logo
  LDA #SPR_DIZZYLOGO:STA frmno
  LDA #58:STA frmx
  LDA #57:STA frmy
  LDA #7:STA frmattri
  JSR frame

.keeptesting
  ; Wait until "START" pressed
  LDA #INKEY_SPACE:JSR scankey
  BEQ keeptesting

  ; Don't reset moving data on first load (as it's already loaded)
.checkmoving
  LDA #&01:BNE movingdone
  JSR resetmoving ; Put all the objects back to their starting positions
.movingdone
  LDA #&00:STA checkmoving+1

  ; Reset coin positions
  JSR resetcoins

  ; Reset what is being carried
  JSR resetcarrying

.resetlives
  LDA #3:STA lives ; Set the number of lives to start with
  LDA #46:STA startx
  LDA #168:STA starty
  LDA #STARTROOM:STA startroom ; THE CASTLE'S DUNGEON

  LDA #&00:STA completedgame

.^nextlife
  JSR subfromlives

  JSR starteggres

  LDA #&00
  STA bag
  STA oldclock
  STA clock ; Init clock
  STA dontupdatedizzy ; Allow Dizzy to be drawn

  ; Fall through into main game loop
}  

.maingamelp
{
  JSR process_inputs ;;; TODO - move this

.notpickup
  LDA #&00:STA pickup ; Disable pickup
  LDA usepickup:BEQ oktopickup
  SEC:SBC #&01:STA usepickup
  JMP notfacing

.oktopickup
  LDA sequence:BNE notfacing
  LDA keys:AND #PAD_FIRE:BEQ notfacing ; Check for FIRE / RETURN being pressed
  LDA #&FF:STA pickup ; Enable pickup

.notfacing
  JSR domoving
  LDA killed
  CMP #&01
  BEQ wantaquickkill

.afterdomoving
  JSR pickupcoins
  JSR tryputtingdown

  JSR updatewater
  JSR updateflames

  ; JSR checkholdinghole
  ; JSR checkifdrunk
  ; JSR shopkeeperrou

.wantaquickkill

  ; See if room changed
  LDA roomno:CMP loadedroomno:BEQ notanewroom

  JSR roomsetup

.notanewroom

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LDA dontupdatedizzy
  BNE nodraw

  JSR updatedizzy
.nodraw
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Check for ESCAPE being pressed
  LDA #INKEY_ESCAPE:JSR scankey ; Scan for ESCAPE
  BNE quitted

  ; Check for game being completed
  LDA completedgame:BNE quitted

.notdonegame
  LDA killed:BEQ maingamelp
  DEC killed:LDA killed:BNE maingamelp

  LDA #&01:STA dontupdatedizzy ; Stop Dizzy being drawn

  LDA roomno:PHA ; Cache room number
  LDA #ROOM_STRINGS:STA roomno
  LDA #STR_deadwindow:JSR findroomstr
  JSR prtmessage
  PLA:STA roomno ; Restore room number

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This is here just to set killedmess
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LDA roomno:PHA ; Cache room number
  LDA #ROOM_STRINGS:STA roomno
  LDA deathmsg:JSR findroomstr
  PLA:STA roomno ; Restore room number

  LDA zptr5:STA killedmess
  LDA zptr5+1:STA killedmess+1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  LDA killedmess:STA zptr5
  LDA killedmess+1:STA zptr5+1

  JSR printandwait

  LDA lives:BEQ toast ; Check for all lives used up

  JMP nextlife

.toast

  ; Fall through into game end
}

; Go back to title screen
.quitted
{
  ; acknowledge ESC
  LDA #&7E:JSR OSBYTE

  JMP titlescreen
}

.updatedizzy
{
  ; Should be called from vsync, so wait for one
  JSR waitvsync

  ; See if we are allowed to run yet
  DEC eggcount:LDA eggcount
  BEQ timetoupdate
  RTS

  .timetoupdate
  LDA #4:STA eggcount ; Schedule next update in 4 frames time

  ; Rub out
  LDA dizzyfrm:STA frmno
  LDA oldx:STA frmx
  LDA oldy:STA frmy
  LDA #PAL_WHITE:STA frmattri
  JSR drawdizzy
  
;  LDA killed:BEQ notdeadyet
;
;  LDA sequence:CMP #6:BEQ cantstop
;  CMP #7:BNE notkeelingover
;
;  LDA animation:CMP #7:BEQ cantstop
;
;  LDA #6:STA animation:BNE cantstop
;
;.notkeelingover
;  BNE notdeadyet
;
;  STA animation
;
;  LDA #7:STA sequence:BNE cantstop
;
;.notdeadyet
;  LDA sequence:CMP #3:BCS jumping
;
;.checkfloor
;  LDA floor
;  BEQ cantstop
;
;  LDX keys
;  TXA:AND #PAD_LEFT:BNE tryright
;  LDA #1:BNE tryjump
;
;.tryright
;  TXA:AND #PAD_RIGHT:BNE trynone
;  LDA #2:BNE tryjump
;
;.trynone
;  LDA #0
;.tryjump
;  STA ztmp1
;  TXA:AND #PAD_JUMP:BEQ setsequnce ; No jump
;
;  LDA #0:STA animation
;  LDA #256-8:STA dy
;  LDA #3
;
;.setsequnce
;  CLC:ADC ztmp1
;
;.cantstop
;  ; Don't check keys
;  LDA sequence
;  ROL A:ROL A
;  CLC:ADC animation:TAY
;  LDA seq0, Y:STA ff
;
;  LDY animation:INY:TYA
;  AND #7:STA animation
;
;  LDA roomno:STA oldroomno
;
;  LDA x:STA ztmp1
;
;.sidereturn
;
;.jumping ;;;;;
;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; Draw new
  INC dizzyfrm
  LDA dizzyfrm:AND #&1F:STA dizzyfrm:STA frmno
  LDA dizzyx:STA frmx:STA oldx
  LDA dizzyy:STA frmy:STA oldy
  JSR drawdizzy
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  RTS
}

; Y = slot (input)
; A = object (output)
.whatinslot
{
  LDA #hi(objectscarried):STA zptr6+1
  LDA #lo(objectscarried):STA zptr6

  LDA (zptr6), Y

  RTS
}

; Y = number down menu list
.printcarryingline
{
  ; Position cursor
  TYA:ASL A:ASL A:ASL A ; YPOS = (8*Y)+80
  CLC:ADC #88:STA messy
  LDA #12:STA messx ; XPOS = 12

  ; See what's in slot inventory[y]
  LDA #hi(nothingheremess):STA zptr5+1
  LDA #lo(nothingheremess):STA zptr5
  JSR whatinslot:TAX
  BEQ justprint

  ; It's not empty, so look up object name
  LDA #hi(movingdata+oldmovex):STA zptr4+1
  LDA #lo(movingdata+oldmovex):STA zptr4

.findslot
  ; Advance to next object
  LDA zptr4:CLC:ADC #movingsize:STA zptr4
  BCC samepage
  INC zptr4+1
.samepage
  DEX:BNE findslot

  ; Copy string pointer from object[n][oldmovex]
  LDY #&00
  LDA (zptr4), Y:STA zptr5:INY
  LDA (zptr4), Y:STA zptr5+1

.justprint
  JMP prtmessage
}

; zptr6 = proximitydata
;
; 0 = room
; 1 = x
; 2 = y
; 3 = w
; 4 = h
; 5 = start of routine if overlap
.checkproximity1
{
  LDY #&00
  LDA (zptr6), Y ; Room
  CMP roomno:BNE done:INY

  LDA (zptr6), Y:STA cx:INY ; X
  LDA (zptr6), Y:STA cy:INY ; Y
  LDA (zptr6), Y:STA cw:INY ; Width
  LDA (zptr6), Y:STA ch:INY ; Height

  ; Do collision detect
  JSR collidewithdizzy3:BEQ done

  ; Jump to a routine immediately following proximity data
  LDA zptr6:CLC:ADC #&04:STA zptr6
  BCC samepage
  INC zptr6+1
.samepage
  LDA zptr6+1:PHA
  LDA zptr6:PHA

.done
  RTS
}

.proxpicture
  EQUB 52      ;; room
  EQUB 62, 104 ;; x, y
  EQUB 5, 16   ;; w, h
.proxpicturerou
  PLA:PLA ; Prevent inventory appearing
  JMP dotreasurepic

.tryputtingdown
{
  ; Do nothing if we're not allowed to pickup
  LDA pickup:BEQ done

  ; Check proximity box for painting
  LDA #hi(proxpicture):STA zptr6+1
  LDA #lo(proxpicture):STA zptr6
  JSR checkproximity1

.tryputtingdown1
  LDA #&01:STA tryputdownvar
.inventoryrou
  LDA #&01:STA dontupdatedizzy ; Stop Dizzy being drawn

  ; Resize inventory box depending on bag size
  LDA #hi(inventory):STA zptr5+1
  LDA #lo(inventory):STA zptr5
  LDA bag:BEQ nobaginvent
  LDA #hi(inventorywithbag):STA zptr5+1
  LDA #lo(inventorywithbag):STA zptr5
.nobaginvent
  JSR prtmessage

  ; Change loop count depending on bag size
  LDA bag:AND #SPR_BAG
  ASL A:CLC:ADC #&02
  STA distdownmenu1+1

  LDY #&00
.printwhatcarrying
  TYA:PHA
  JSR printcarryingline
  PLA:TAY
  INY
.distdownmenu1
  CPY #1 ; 2+bag*2
  BNE printwhatcarrying

  ; If first item is empty, then nothing being carried
  LDA objectscarried
  BNE something

  LDA #hi(nothingatallmess):STA zptr5+1
  LDA #lo(nothingatallmess):STA zptr5
  JSR prtmessage

.something
  ; Check if carrying too much
  LDA #hi(carryingtoomuchmess):STA zptr5+1
  LDA #lo(carryingtoomuchmess):STA zptr5

  LDA toomuchtohold:BNE gottoomuchpointer

  ; Display prompt
  LDA #hi(selectitemmess):STA zptr5+1
  LDA #lo(selectitemmess):STA zptr5
.gottoomuchpointer
  JSR prtmessage

  ;;;;;;;;;;;;;;;;;;;;
  JSR handoffandwait ; Wait for new key press  
  ;;;;;;;;;;;;;;;;;;;;

.justexitinvent
  JSR resetuproom ; Draw the room again

  LDA #&00
  STA tryputdownvar
  STA dontupdatedizzy ; Allow Dizzy to be drawn
  STA toomuchtohold

.done
  RTS
}

.pickupcoins
{
  ; Do nothing if we're not allowed to pickup
  LDA pickup:BEQ done

  ; Scan through coins list to see if we are over an "active" coin
  LDX #&00
.testpickupcoin
  STX ztmp6:TXA:ASL A:CLC:ADC ztmp6:TAY ; Y = X*3

  ; Is current coin in current room
  LDA cointable+2, Y:CMP roomno:BNE nocoinhere

  ; Test collision
  LDA cointable, Y:STA cx
  LDA cointable+1, Y:STA cy
  LDA #16:LSR A:LSR A:STA cw
  LDA #16:STA ch
  JSR collidewithdizzy3
  BEQ notovercoin

  ; A coin was picked up
  LDA roomno:ORA #&80:STA cointable+2, Y
  TXA:PHA:JSR addtocoins:PLA:TAX
  
  ; Prevent inventory showing and show coin message instead
  LDA #&00:STA pickup

  LDA roomno:PHA ; Cache room number
  LDA #ROOM_STRINGS:STA roomno
  LDA #STR_youfoundcoinmess:JSR findroomstr
  PLA:STA roomno ; Restore room number

  JSR prtmessage

  ;;;;;;;;;;;;;;;;;;;;
  JSR handoffandwait ; Wait for new key press
  JSR resetuproom ; Draw the room again
  ;;;;;;;;;;;;;;;;;;;;

.notovercoin

.nocoinhere
  INX:CPX #totalcoins:BNE testpickupcoin

.done
  RTS
}

; cx = x
; cy = y
; cw = w
; ch = h
;
; return a = 0 when no collision
.collidewithdizzy3
{
  LDA dontupdatedizzy:BNE skipthis
  LDA killed:BNE skipthis

  LDA dizzyx:CLC:ADC #eggwidth ; calculate right diz
  CMP cx:BCC skipthis ; vs left obj

  LDA dizzyy:CLC:ADC #eggheight ; calculate bottom diz
  CMP cy:BCC skipthis ; vs top obj

  LDA cw:CLC:ADC cx ; calculate right obj
  CMP dizzyx:BCC skipthis ; vs left diz

  LDA cy:CLC:ADC ch ; calculate bottom obj
  CMP dizzyy:BCC skipthis; vs top diz

  LDA #&FF:RTS ; Collision

.skipthis
  LDA #0:RTS
}

eggheight = 16
eggwidth = 5

.codeend

INCLUDE "objects.asm"

.objend

ORG SERIAL_OUT_BUFFER
GUARD NMI_WORKSPACE
.extradata
INCLUDE "extra.asm"
.extraend

PUTFILE "EXOSCR", "$.EXOSCR", EXO_LOAD_ADDR
PUTFILE "SPEECH", "$.SPEECH", EXO_LOAD_ADDR
PUTFILE "MELODY", "$.MELODY", EXO_LOAD_ADDR
SAVE "EXTRA", extradata, extraend
SAVE "VARCODE", start_of_var_code, end_of_var_code
SAVE "DIZZY3", start, objend, onetimeinit
PUTFILE "RMDATA", "$.RMDATA", &4000
PUTFILE "XDATA", "$.XDATA", &4000
SAVE "OBJDATA", movingdata, endofmovingdata
PUTFILE "TREPIC", "TREPIC", MODE8BASE
PUTFILE "loadscr", "FRAME", MODE8BASE

PRINT "-------------------------------------------"
PRINT "Zero page from ", ~zpstart, " to ", ~zpend-1, "  (", ZP_ECONET_WORKSPACE-zpend, " bytes left )"
PRINT "Stack from ", ~start_of_stack, " to ", ~end_of_stack-1
PRINT "VARS from ", ~start_of_vars, " to ", ~end_of_vars-1
PRINT "VARCODE from ", ~start_of_var_code, " to ", ~end_of_var_code-1, "  (", SOUND_WORKSPACE-end_of_var_code, " bytes left )"
PRINT "BVARS from ", ~start_of_buff, " to ", ~end_of_buff-1, "  (", ENVELOPE_DEFS-end_of_buff, " bytes left )"
PRINT "EXTRA from ", ~extradata, " to ", ~extraend-1, "  (", NMI_WORKSPACE-extraend, " bytes left )"
PRINT "DATA from ", ~datastart, " to ", ~dataend-1, "  (", dataend-datastart, " bytes )"
PRINT "CODE from ", ~codestart, " to ", ~codeend-1, "  (", codeend-codestart, " bytes )"
PRINT ""
PRINT "Main code entry point : ", ~onetimeinit
PRINT "Objects : ", ~movingdata, "..", ~endofmovingdata, " (", endofmovingdata-movingdata, " bytes, ", noofmoving, " objs )"
PRINT ""
remaining = MODE8BASE-objend
PRINT "Space before screen memory : ", ~remaining, "  (", remaining, " bytes left )"
PRINT "-------------------------------------------"
