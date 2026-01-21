; Debug settings and flags
seecoins = 0
liquidkills = 0
firekills = 0
allowsndfx = 0

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
  LDA #58:STA z80ereg
  LDA #57:STA z80lreg
  LDA #SPR_DIZZYLOGO
  JSR store_sprite_vars1
  ; JSR plotattris
  JSR frame

.keeptesting
  ; Wait until "START" pressed
  LDA #INKEY_SPACE:JSR scankey
  BNE donetitle

  ; Check for Joystick
  JSR scanjoy
  BEQ keeptesting

  STA padfound

.donetitle

  ; Don't reset moving data on first load (as it's already loaded)
.checkmoving
  LDA #&01:BNE movingdone
  JSR resetmoving ; Put all the objects back to their starting positions
.movingdone
  LDA #&00:STA checkmoving+1

  JSR resetmoving1

  ; Reset coin positions
  JSR resetcoins

  ; Reset what is being carried
  JSR resetcarrying

.resetlives
  LDA #3:STA lives ; Set the number of lives to start with
  LDA #46:STA startx
  LDA #168:STA starty
  LDA #GAMESTARTROOM:STA startroom ; THE CASTLE'S DUNGEON

  LDA #&00:STA completedgame
  STA objcollide

.^nextlife
  JSR subfromlives

  JSR starteggres

  LDA #&00
  STA bag
  STA oldclock
  STA clock ; Init clock
  STA dontupdatedizzy ; Allow Dizzy to be drawn
  STA upsidedown ; Start right-way-up

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
  JSR tryputtingdown ; Put object down / Inventory

  LDA clock:AND #&03:BNE skipwaterflame ; Limit drawing fire/water
  JSR updatewater
  JSR updateflames
.skipwaterflame

  JSR checkholdinghole
  JSR checkifdrunk
  JSR shopkeeperrou

.wantaquickkill

  ; See if room changed
  LDA newroomno
  CMP roomno:BNE differentroom
  JMP notanewroom

.differentroom

  ; only a problem if newroomno =23 or 55
  ; when roomno=39
  ; or if newroomno=39 (set path to tumble)

  ; Check if we've just left the well
  LDA roomno
  CMP #WELLROOM:BEQ leaving39

  ; Check if we went down from Australia
  LDA newroomno
  CMP #UNDERAUSROOM:BEQ fallenoutof23
  CMP #WELLROOM:BNE gotoenterroom

  ; Gone down from Australia (into well)
.fallenoutof23
  LDA #WELLROOM:STA newroomno
  ; set to ordinary tumble
  LDA roomno:STA lastroom
  
  ;SEI ; REMOVED
  LDA #0
  STA animation ; First frame of animation
  ;STA left      ; Not going left
  ;STA right     ; Not going right

  LDA #4:STA dy
  ; LDA #3:STA sequence ; jumping/tumbling straight up/down ; TODO put this back in when animation done
  ;CLI ; REMOVED

  JMP gotoenterroom

  ; Leaving well, if into Australia, then vertical flip
.leaving39
  LDA newroomno
  CMP #STRANGENEWROOM:BEQ flipandsettumble

  ; notroom23
  ; were going up on seq. 8
  LDA lastroom
  CMP #TOPWELLROOM:BEQ skipthis
  CMP #STRANGENEWROOM:BNE gotoenterroom ; TODO remove when collision detection done
  LDA #TOPWELLROOM:BNE settojumpout
.skipthis
  LDA #STRANGENEWROOM

.settojumpout
  STA newroomno
  ; set path to jump (+ve x)

  ;SEI ; REMOVED

  LDA #0
  STA animation ; First frame of animation
  ;STA left ; Not going left

  ;LDA #1:STA right ; Going right
  LDA #256-8:STA dy
  ; LDA #5:STA sequence ; jump/tumble right ; TODO put this back in when animation done

  ;CLI ; REMOVED

  JMP gotoenterroom

.flipandsettumble
  ; set path to upside down tumble
  ;SEI ; REMOVED

  LDA #90:STA dizzyy ; TODO

  LDA #0
  STA animation ; First frame of animation
  ;STA left ; Not going left
  ;STA right ; Not going right
  ; (dy) will automatically be set to -6

  ; LDA #8:STA sequence ; upside down tumble ; TODO put this back in when animation done

  ; Switch upsidedown
  LDA upsidedown
  EOR #&01:STA upsidedown

  ; Go through the well a second time
  LDA #WELLROOM:STA newroomno

  ;CLI ; REMOVED

.gotoenterroom
  JSR enterroom
  LDA #&00:STA dontupdatedizzy

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
  LDA killed:BEQ restartloop
  DEC killed:LDA killed:BEQ keepgoing
.restartloop
  JMP maingamelp
.keepgoing

  LDA #&01:STA dontupdatedizzy ; Stop Dizzy being drawn

  LDA roomno:PHA ; Cache room number
  LDA #ROOM_STRINGS:STA roomno
  LDA #STR_deadwindow:JSR findroomstr
  JSR prtmessage
  PLA:STA roomno ; Restore room number

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

; Set input key states
.checkkeys
{
  ; Set defaults to "nothing" pressed
  LDA #&00

  STA left
  STA right
  STA jump
  STA fire

  ; Do nothing if killed
  LDA killed:BNE done

  ; Cache the current input state
  LDX keys

  ; Prevent fire (pickup/inventory) being pressed when not "looking forward idle"
  LDA sequence:BNE firenotpressed

  ; Prevent fire (pickup/inventory) being pressed when already picking up
  LDA usepickup:BNE firenotpressed

  ; Check for FIRE button
  TXA:AND #PAD_FIRE:BEQ firenotpressed

.firepressed
  INC fire
  RTS

  ; Check for LEFT button
.firenotpressed
  TXA:AND #PAD_LEFT:BEQ leftnotpressed

.leftpressed
  INC left

  ; Check for RIGHT button
.leftnotpressed
  TXA:AND #PAD_RIGHT:BEQ rightnotpressed

.rightpressed
  INC right

  ; Check for JUMP button
.rightnotpressed
  TXA:AND #PAD_JUMP:BEQ done

.jumppressed
  INC jump

.done
  RTS
}

; Draw Dizzy in new position
.plotnew
{
  LDA x:STA ox ; Cache X
  STA frmx

  LDA y:STA oy ; Cache Y
  CLC:ADC #&01
  STA frmy

  LDA ff:STA of ; Cache frame
  STA frmno

  JMP drawdizzy
}

; Dizzy has gone off the screen to the left
.goneleft
{
  LDA #56:STA x ; Put Dizzy on the far right

  ; Determine new room number
  LDA roomno
  SEC:SBC #&01

  JMP newroom
}

; Dizzy has gone off the screen to the right
.goneright
{
  LDA #2:STA x ; Put Dizzy on the far left

  ; Determine new room number
  LDA roomno
  CLC:ADC #&01

  JMP newroom
}

; Dizzy has gone off the screen upwards
.goneup
{
  LDA y:CLC:ADC #118:STA y ; Put Dizzy at the bottom

  ; Determine new room number
  LDA roomno
  CLC:ADC #16

  JMP newroom
}

; Dizzy has gone off the screen downwarsd
.gonedown
{
  LDA y:SEC:SBC #114:STA y ; Put Dizzy at the top

  ; Determine new room number
  LDA roomno
  SEC:SBC #16

  ; Fall through
}

; Handle switching to a new room
;
; IN A = new room number
.newroom
{
  AND #127:STA newroomno

  ; Prevent Dizzy being drawn
  LDA #&01:STA dontupdatedizzy

  RTS
}

.jumping
{
  ; If animation is in progress, then don't stop
  LDA animation:BNE done
  JMP checkfloor

.done
  JMP cantstop
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
  JSR ruboutdizzy

  ; Check Dizzy is still alive
  LDA killed:BEQ notdeadyet

  ; Check for bobbing upside down
  LDA sequence:CMP #6:BEQ cantstop

  ; Check for not keeling over backwards
  CMP #7:BNE notkeelingover

  ; Check to see if keeling over animation sequence has finished
  LDA animation:CMP #7:BEQ cantstop

  ; Set animation frame to penultimate one
  LDA #6:STA animation:BNE cantstop

.notkeelingover
  LDA sequence
  BNE notdeadyet

  ; Reset animation frame to 0
  STA animation

  ; Set sequence to "fall over backwards"
  ; LDA #7:STA sequence:BNE cantstop ; TODO put this back in when animation done
  JMP cantstop ; TODO remove this when animation done

  ; Check for "jumping/tumbling straight up/down"
.notdeadyet
  LDA sequence:CMP #3:BCC checkfloor
  JMP jumping

.^checkfloor
  LDA floor:BEQ cantstop

if allowsndfx = 1

  ; Don't make movement sounds when not moving
  LDA sequence:BEQ bettercheckkeys

  ; Movement sound (once every 4 frames)
  LDA animation:AND #&03:LSR A:BCC bettercheckkeys
  STA sndfx

endif

.bettercheckkeys
  JSR checkkeys

  ; See if LEFT is pressed
.tryleft
  LDA left:BEQ tryright
  LDA #1:BNE tryjump ; Left animation sequence

  ; See if RIGHT is pressed
.tryright
  LDA right:BEQ trynone
  LDA #2:BNE tryjump ; Right animation sequence

.trynone
  LDA #0 ; Up animation sequence
.tryjump
  STA z80breg ; Cache direction of jump

  ; See if JUMP is pressed
  LDA jump
  BEQ setsequnce ; no jump

if allowsndfx = 1

  ; Jump sound effect
  LDA #21:STA sndfx

endif

  LDA #0:STA animation ; Set animation to first frame
  LDA #256-8:STA dy ; ??? Set delta Y -> gravity ???

  LDA #3 ; Jumping sequence base
.setsequnce
  CLC:ADC z80breg
  STA sequence

.^cantstop
  ; Don't check keys

  ; Look up frame to use from sequence[n][animation]
  LDA sequence
  ASL A ; * 2 (and clear carry)
  ROL A:ROL A ; * 4 to make a total of * 8, as there are 8 frames in each sequence
  ADC animation ; Add animation frame for offset (no need for CLC due to ASL above)
  TAY:LDA seq0, Y ; Load frame from sequence
  STA ff ; Cache animation frame

  ; Advance animation frame
  LDY animation:INY:TYA
  AND #7:STA animation

  LDA roomno:STA oldroomno

  ; Determine new x position based on keys pressed
  LDA x:STA z80breg
  SEC:SBC left
  CLC:ADC right

  ; See if Dizzy has gone off the screen
  CMP #1:BNE noleft:JMP goneleft
.noleft
  CMP #57:BNE noright:JMP goneright
.noright

.sidereturn
  STA x:STA z80breg
  LDA ox:CMP z80breg
  BEQ sideback ; ox == x
  BCC checkrightside ; ox < x
  JMP checkleftside ; ox > x

.sideback
  LDA sequence

  CMP #6:BEQ vertreturn ; upside down in water

  CMP #8:PHP ; tumbling upsidedown
  LDA #256-6:PLA
  BEQ aroundgravity

  LDA dy
  CLC:ADC #&01

.aroundgravity
  STA dy
  BMI checktopside
  JMP checkbottomside

.updownback
  LDA #&00:STA floor
.updownback1

.vertreturn
  ; If room changed don't draw Dizzy
  LDA oldroomno:CMP roomno:BNE dontdraw
  JMP plotnew
.dontdraw
  RTS

.checktopside
.checktopsidelp

.checkbottomside
.slowfall
.checkbottomsidelp
.floorfound
.storedizzy

.checkleftside
.checkleftsidelp

.checkrightside
.checkrightsidelp

.nosidemove

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; Draw new
  ;INC dizzyfrm ; Advance animation frame

  LDA #&00:STA dizzyfrm
  LDA frmx:STA lookx
  LDA frmy:STA looky

  ; Check top left
  JSR checkattri
  BEQ emptytl
  LDA #&03:STA dizzyfrm
.emptytl

  ; Check top right
  LDA lookx:CLC:ADC #&05:STA lookx
  JSR checkattri
  BEQ emptytr
  LDA #&03:STA dizzyfrm
.emptytr

  ; Bottom right
  LDA looky:CLC:ADC #20:STA looky
  JSR checkattri
  BEQ emptybr
  LDA #&03:STA dizzyfrm
.emptybr

  ; Bottom left
  LDA frmx:STA lookx
  JSR checkattri
  BEQ emptybl
  LDA #&03:STA dizzyfrm
.emptybl

  LDA dizzyfrm:AND #&1F:STA dizzyfrm:STA frmno
  LDA dizzyx:STA frmx:STA oldx
  LDA dizzyy:STA frmy:STA oldy
  JSR drawdizzy
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  RTS
}

.checkline
{
.checklinelp
  RTS
}

; Check attributes at specified position (8x8 blocks)
;
; IN lookx (0..63)
; IN looky (0..191)
;
; OUT A=0 not set, A!=0 set
.checkattri
{
  ; Set target pointer
  LDA #hi(attritable):STA zptr2+1
  LDA #lo(attritable):STA zptr2

  ; Calculate row
  LDA looky
  LSR A:LSR A:LSR A ; A /= 8 (8 pixel high blocks)
  SEC:SBC #6 ; A -= 6 (attritable ignores top header)

  ; Set row offset
  ASL A:ASL A ; Determine byte offset for start of row
  STA zptr2

  ; Calculate column (bit position 0..31)
  LDA lookx:AND #&7F
  SEC:SBC #32
  LSR A
  STA colpos+1
  
  ; Set column offset
  LSR A:LSR A:LSR A
  CLC:ADC zptr2:STA zptr2

  ; Calculate starting bit pattern
.colpos
  LDA #&00:AND #&07
  TAY:LDA bitpattern, Y
  STA bitmask+1

  LDY #&00
  LDA (zptr2), Y
.bitmask
  AND #&00

  RTS
}

; Y = slot (input)
; A = object (output)
MACRO WHATINSLOT
  LDA objectscarried, Y
ENDMACRO

; Y = number down menu list
.printcarryingline
{
  ; Position cursor
  TYA:ASL A:ASL A:ASL A ; YPOS = (8*Y)+80
  CLC:ADC #80
  LDX bag:BNE baginvent:ADC #8 ; Small bag needs text pushing down a bit more
.baginvent
  STA messy
  LDA #12:STA messx ; XPOS = 12

  ; See what's in slot inventory[y]
  LDA #hi(nothingheremess):STA zptr5+1
  LDA #lo(nothingheremess):STA zptr5
  WHATINSLOT:TAX
  BEQ justprint

  ; It's not empty, so look up object name
  LDA #hi(movingdata+oldmovex):STA zptr4+1
  LDA #lo(movingdata+oldmovex):STA zptr4

  ; If it's the bag (EOF), position further down
  CPX #OBJ_BAG:BNE notbag
  LDA messy:CLC:ADC #&04:STA messy
.notbag

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

; zptr4 = object
.checkproximity
{
  ; Check for null object pointer (set by whiskey)
  LDA zptr4:ORA zptr4+1:BNE notnull
.done
  RTS
.notnull

  ; Load proximity for object
  LDY #oldmovefrm:LDA (zptr4), Y:STA zptr6
  LDY #delay:LDA (zptr4), Y:STA zptr6+1

  ; Check for null proximity pointer
  ORA zptr6:BEQ done

  ; Fall through
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

.tryputtingdown
{
  ; Do nothing if we're not allowed to pickup
  LDA pickup:BNE ready
  RTS
.ready

  ; Check proximity box for painting
  LDA #hi(proxpicture):STA zptr6+1
  LDA #lo(proxpicture):STA zptr6
  JSR checkproximity1

.^tryputtingdown1
  LDA #&01:STA tryputdownvar
.^inventoryrou
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
  LDA bag:AND #&01
  ASL A:CLC:ADC #&02
  STA distdownmenu+1
  STA distdownmenu1+1

  LDY #&00
.printwhatcarrying
  TYA:PHA:JSR printcarryingline:PLA:TAY
  INY
.distdownmenu1
  CMP #1 ; 2+bag*2
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

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Allow navigating up/down inventory to choose what to drop
  LDY #&00 ; Start with first line highlighted (when not picking up)

  LDA tryputdownvar:CMP #&01:BEQ notempty
  LDY distdownmenu+1 ; Select last item when picking up
.notempty

.chooseobjecttodrop
  STY objecttodrop ; cache selection
.flywait
  TYA:PHA:JSR waitvsync:PLA:TAY ; TODO - temporary

  ; Change colour of highlighted item
  INC cyclecolour:LDA cyclecolour:AND #&07:STA cyclecolour
  STA messpen
  BNE notblack:INC messpen:INC messpen ; Don't draw black text on black background
.notblack
  TYA:PHA:JSR printcarryingline:PLA:TAY

  ; See if ENTER has been pressed
  LDA keys:AND #PAD_FIRE:BNE tryingtodrop

  ; See if inventory is empty
  LDA objectscarried:BEQ notdownmenu

.notchingdown
  CPY #&00:BEQ notupmenu

  ; See if UP pressed
  LDA keys:AND #PAD_UP:BEQ notupmenu
.yesupmenu
  DEY
  LDA objectscarried, Y:CMP #OBJ_EMPTY:BEQ yesupmenu ; Prevent getting stuck on empty item - TODO rework
.notupmenu

.distdownmenu
  CPY #1 ; 2+bag*2
  BEQ notdownmenu

  ; See if DOWN pressed
  LDA keys:AND #PAD_DOWN:BEQ notdownmenu
.yesdownmenu
  INY
  LDA objectscarried, Y:CMP #OBJ_EMPTY:BEQ yesdownmenu ; Prevent getting stuck on empty item - TODO rework
.notdownmenu
  CPY objecttodrop:BEQ chooseobjecttodrop ; If selection hasn't changed, go round again

  ; Selection changed, so draw previous item without highlight
  LDA #PAL_RED:STA messpen
  TYA:PHA:LDY objecttodrop:JSR printcarryingline:PLA:TAY
  JMP chooseobjecttodrop ; go round again

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; Something has been chosen
.tryingtodrop
  LDA objectscarried, Y
  CMP #OBJ_EMPTY:BEQ justexitinvent ; Prevent empty slot being selected - TODO rework
  STA objecttodrop ; Record selected item
  JSR gettomovingdata ; Point to it

  ; See if it's the whiskey
  LDA objecttodrop:CMP #OBJ_WHISKEYBOTTLE:BNE notwhiskey
  TYA:PHA:JSR droppingwhiskey:PLA:TAY
.notwhiskey
  ; If BAG (EOF) selected, then just exit
  LDA objecttodrop:CMP #OBJ_BAG:BEQ justexitinvent

  ; Shuffle down anything from next slot onwards
.sufflelp
  INY
  LDA objectscarried, Y:CMP #OBJ_BAG:BEQ justexitinvent1 ; Is this the bag?
  STA objectscarried-1, Y ; Store it in previous slot
  JMP sufflelp

.justexitinvent1
  LDA #OBJ_EMPTY:STA objectscarried-1, Y ; Empty inventory slot
  JSR dropobject

  ;CHECK DROPPING OBJECT BY TRIGGER
  LDA #&01:STA objcollide
  JSR checkproximity ; zptr4 is set up by dropobject()

  ; Check proximity box for shopkeeper
  LDA zptr4:ORA zptr4+1:BEQ done
  LDA #&01:STA objcollide
  LDA #hi(proxshopkeeper):STA zptr6+1
  LDA #lo(proxshopkeeper):STA zptr6
  JSR checkproximity1

.justexitinvent
  JSR resetuproom ; Draw the room again

  LDA #&00
  STA tryputdownvar
  STA dontupdatedizzy ; Allow Dizzy to be drawn
  STA toomuchtohold

.done
  RTS
}

; Make Dizzy drunk
.droppingwhiskey
{
  ; Check if drank already
  LDY #var1:LDA (zptr4), Y:BNE done
  LDA #&01:STA (zptr4), Y ; Set as drank

  ; Change name of object to "AN EMPTY BOTTLE"
  LDY #oldmovex:LDA #lo(emptybottlemess):STA (zptr4), Y
  LDY #oldmovey:LDA #hi(emptybottlemess):STA (zptr4), Y

  ; Set Dizzy as drunk
  LDA #&FF:STA drunk

  ; Report that Dizzy is now drunk
  LDA roomno:PHA:LDA #ROOM_STRINGS:STA roomno
  LDA #STR_dropwhiskeymess:JSR findroomstr
  PLA:STA roomno
  JSR prtmessage

  LDA #&FF:STA pickup

  ; Wait for no keypress, then keypress
  JMP handoffandwait

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
  LDA objcollide:BNE allowprox
  LDA dontupdatedizzy:BNE skipthis
.allowprox
  LDA #&00:STA objcollide
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

.killdizzy
{
  ; Set killed parameter default
  LDA #10

.^killdizzy1
  STA z80breg ; Cache parameter

  ; If killed is set, stop now
  LDA killed:BNE done

  ; Restore parameter, set killed
  LDA z80breg:STA killed

  ; Lookup killed message
  LDA roomno:PHA ; Cache room number
  LDA #ROOM_STRINGS:STA roomno
  LDA deathmsg:JSR findroomstr
  PLA:STA roomno ; Restore room number

  LDA zptr5:STA killedmess
  LDA zptr5+1:STA killedmess+1

if allowsndfx = 1

  LDA #25:STA sndfx

endif

.done
  RTS
}

.starteggres
{
  LDA startx:STA x
  STA dizzyx ; TODO - REMOVE
  LDA starty:STA y
  STA dizzyy ; TODO - REMOVE
  LDA startroom:STA newroomno

  LDA #0
  STA left:STA right:STA jump:STA fire
  STA dy
  STA floor
  STA sequence ; Looking forward idle animation
  STA animation ; Animation frame offset within sequence
  STA killed ; Dizzy is not dead
  STA obstructinglift ; Not obstructing lift
  STA drunk ; Not drunk

  LDA #10:STA usepickup

  LDX #1
  LDA newroomno:CMP #GAMESTARTROOM
  BNE standforwardframe

  LDA y:CMP #100:BCC standforwardframe

  LDX #25

.standforwardframe
  STX ff

.^enterroom
  LDA newroomno
  STA roomno
  STA startroom

  LDA x
  LDA dizzyx ; TODO - REMOVE
  STA startx

  LDA y
  LDA dizzyy ; TODO - REMOVE
  STA starty

  ; Fall through
}

.resetuproom
{
  JMP roomsetup

  ; Start by drawing Dizzy so there is something to rub out
  ; TODO - reinstate plotnew, and change above to JSR
  ;JMP plotnew
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LOOKING AT PICTURE
.proxpicture
{
  EQUB ENTRANCEHALLROOM ;; room
  EQUB 62, 104 ;; x, y
  EQUB 5, 16   ;; w, h

.proxpicturerou
  PLA:PLA ; Prevent inventory appearing
  JSR dotreasurepic

  ; Put lives/coin counts back in status
  JSR drawlives
  JMP drawcoins
}

; Handler for VBLANK event
.eventhandler
{
  STA eventno+1

  ; Save registers
  PHP
  PHA
  TXA:PHA
  TYA:PHA

  ; Find out which event it is
.eventno
  LDA #&00
  CMP #EV_VSYNC
  BNE done ; not vsync, so end now

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  LDA palettefoo:BEQ skipthis
  ; Handle vsync, top-half palette
  SET_COL2 PAL_OS_Yellow

  ; Set timer2 to change palette part way down
  LDA #lo(scanline_time)
  ADC #lo(timer2_base_in_us)
  STA USERVIA_T2CL ; Low value

  LDA #hi(scanline_time)
  ADC #hi(timer2_base_in_us)
  STA USERVIA_T2CH ; High value - also starts timer
.skipthis
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  INC clock

  JSR read_input

.done
  ; Restore registers
  PLA:TAY
  PLA:TAX
  PLA
  PLP

  RTS
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
PUTFILE "RMDATA", "$.RMDATA", SWR_CACHE
PUTFILE "XDATA", "$.XDATA", SWR_CACHE
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
PRINT "Objects : ", ~movingdata, "..", ~endofmovingdata-1, " (", endofmovingdata-movingdata, " bytes, ", noofmoving, " objs )"
PRINT ""
remaining = MODE8BASE-objend
PRINT "Space before screen memory : ", ~remaining, "  (", remaining, " bytes left )"
PRINT "-------------------------------------------"
