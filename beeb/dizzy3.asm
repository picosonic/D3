; OS defines
INCLUDE "os.asm"
INCLUDE "inkey.asm"
INCLUDE "internal.asm"

; Variable and constant defines
INCLUDE "consts.asm"
INCLUDE "vars.asm"

ORG MAIN_LOAD_ADDR
GUARD MODE8BASE

.start
.datastart
.frametable
INCBIN "frametable.bin"
.framedefs
INCBIN "framedefs.bin"

INCLUDE "rooms.asm"
INCLUDE "dizzyfrm.asm"
.dataend

.codestart
; Import modules
INCLUDE "input.asm"
INCLUDE "rand.asm"
INCLUDE "gfx.asm"

.titlescreen
{
  LDA #&01:STA dontupdatedizzy ; Stop Dizzy being drawn

  LDA #TITLEROOM:STA roomno
  JSR roomsetup

  ; Print all the title screen text
  LDA #STR_startmess:JSR findroomstr
  JSR prtmessage

  ; Dizzy logo
  LDA #27:STA frmno
  LDA #58:STA frmx
  LDA #57:STA frmy
  LDA #7:STA frmattri
  JSR frame

.keeptesting
  ; Wait until "START" pressed
  LDA #INKEY_SPACE:JSR scankey
  BEQ keeptesting

  JSR resetmoving ; Put all the objects back to their starting positions
  JSR resetcoins
  JSR resetcarrying

  LDA #3:STA lives ; Set the number of lives to start with
  LDA #46:STA startx
  LDA #168:STA starty
  LDA #STARTROOM:STA startroom ; THE CASTLE'S DUNGEON

  ;;;;;;;;
  STA roomno
  JSR roomsetup
  ;;;;;;;;

  LDA #&00:STA completedgame

.nextlife
  JSR subfromlives

  LDA #&00
  STA oldclock
  STA clock ; Init clock
  STA dontupdatedizzy ; Allow Dizzy to be drawn

  ; Fall through into main game loop
}  

.maingamelp
{
  JSR process_inputs

  ; See if room changed
  LDA roomno:CMP loadedroomno:BEQ same

  JSR roomsetup

  ; Wait until nothing pressed
.holdon
  LDX keys:BNE holdon

.same

.afterdomoving
  JSR updatewater
  JSR updateflames

  LDA dontupdatedizzy
  BNE nodraw

  JSR updatedizzy
.nodraw

  JMP maingamelp
}

.updatewater
{
  ; First check if there is any water
  LDA noofwater:BEQ done

  TAX
  LDA #lo(waterlist):STA zptr4
  LDA #hi(waterlist):STA zptr4+1  

  ; Get water colour, e.g. water or lava
  LDA watercolour:AND #&E7:ORA #&10:STA frmattri

  LDY #&00
.updatewaterlp

  LDA (zptr4), Y:STA frmx:INY
  LDA (zptr4), Y:STA frmy:INY
  LDA (zptr4), Y
  STA zidx4:INC zidx4:LDA zidx4:AND #&03:STA (zptr4), Y:INY
  CLC:ADC #92:STA frmno

  JSR frame

  ; ...

  DEX:BNE updatewaterlp

.done
  RTS
}

.updateflames
{
  ; First check if there are flames
  LDA noofflames:BEQ done

  TAX
  LDA #lo(flamelist):STA zptr4
  LDA #hi(flamelist):STA zptr4+1

  ; Update flame loop
  LDA #115:STA frmno
  LDA clock:AND #&01:TAY:LDA flamecolours, Y:STA frmattri

  LDY #&00
.updateflamelp

  LDA (zptr4), Y:STA frmx:INY
  LDA (zptr4), Y:STA frmy:INY
  INY
  JSR frame

  DEX:BNE updateflamelp

.done
  RTS

.flamecolours
  EQUB     &02  ; Red
  EQUB &80+&07  ; White (h-flip)
}

.resetcarrying
{
  LDA #&00
  STA objectscarried+1
  STA objectscarried+3
  STA objectscarried+4

  LDA #OBJ_BAG:STA objectscarried+2 ; Bag
  LDA #OBJ_APPLE:STA objectscarried ; Apple

  RTS
}

.process_inputs
{
  LDX keys
  BEQ done ; Nothing pressed

.case_right
  TXA:AND #PAD_RIGHT
  BEQ case_left
  INC roomno

.case_left
  TXA:AND #PAD_LEFT
  BEQ case_up
  DEC roomno

.case_up
  TXA:AND #PAD_UP
  BEQ case_down
  LDA roomno:CLC:ADC #&10:STA roomno

.case_down
  TXA:AND #PAD_DOWN
  BEQ checkno
  LDA roomno:SEC:SBC #&10:STA roomno

.checkno
  LDA roomno:CMP #101:BCC done
  LDA #STARTROOM:STA roomno ; Reset

.done
  RTS
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
  LDA dizzyfrm:AND #&1F:STA frmno
  LDA dizzyx:STA frmx
  LDA dizzyy:STA frmy
  LDA #PAL_WHITE:STA frmattri
  JSR drawdizzy
  
  ; Draw new
  INC dizzyfrm
  LDA dizzyfrm:AND #&1F:STA frmno
  JSR drawdizzy
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  RTS
}

; Handler for VBLANK event
.eventhandler
{
  ; Save registers
  PHP
  PHA
  TXA:PHA
  TYA:PHA

  INC clock

  JSR read_input

  ; Restore registers
  PLA:TAY
  PLA:TAX
  PLA
  PLP

  RTS
}

.resetmoving
{
  LDX #lo(objresetcmd)
  LDY #hi(objresetcmd)
  JSR OSCLI

  LDA &00
  STA waterheight
  STA fireout
  STA ratcount
  STA dragonhere+oldmovex
  STA dragonhere1+oldmovex
  STA doorhere+oldmovex
  
  LDA #&FF
  ;STA shopkeepercount
  STA rathere+var1

  LDA #60
  STA rathere+oldmovefrm

  ;LDA fullwhiskeymess
  ;STA whiskeyhere+oldmovex

  LDA #&01
  ;STA ratcoll+1

  LDA #5+16+8
  STA rathere+colour

  LDY #&00:LDA #&00
.scrubtalkbefore
  STA talkbefore, Y
  INY
  CPY #&05:BNE scrubtalkbefore

  RTS

.objresetcmd
  EQUS "L.OBJDATA", &0D
}

; Reset coins
.resetcoins
{
  LDA #&FF:STA coins

  ; More to do

  ; Fall through ...
}

.addtocoins
{
  INC coins

  ; Determine how many 10s
  LDX #0:LDA coins
.more10s
  CMP #11:BCC nomore10s
  SBC #10:INX
  JMP more10s
.nomore10s
  PHA:TXA:CLC:ADC #'0':STA noofcoinsmess

  ; Determine how many units
  LDX #0:PLA
.moreunits
  CMP #2:BCC nomoreunits
  SBC #1:INX
  JMP moreunits
.nomoreunits
  TXA:CLC:ADC #'0':STA noofcoinsmess+1

  ; Draw the full coins message
  LDA #hi(coinsmess):STA zptr5+1
  LDA #lo(coinsmess):STA zptr5
  JMP prtmessage

.coinsmess EQUB PRT_PEN+4, PRT_XY+46,8
.noofcoinsmess EQUB 0, 0, PRT_END
}

.subfromlives
{
  ; Subtract 1 from lives
  DEC lives

  ; Inject lives number into number of lives messages, using repeat count
  LDA lives:STA nooflivesmess+1

  ; Print number of lives (as eggs)
  LDA #hi(livesmess):STA zptr5+1
  LDA #lo(livesmess):STA zptr5

  JMP prtmessage

.livesmess EQUB PRT_PEN+4, PRT_XY+14,8, ":::", PRT_XY+14,8
.nooflivesmess EQUB PRT_REP, 1, "/", PRT_ENDREP, PRT_END
}

.codeend

INCLUDE "objects.asm"

.objend

ORG SERIAL_OUT_BUFFER
GUARD NMI_WORKSPACE
.extradata
INCLUDE "extra.asm"
.extraend

ORG &00
CLEAR &00, &FF
.plingboot
EQUS "*BASIC", &0D ; Reset to BASIC
EQUS "PAGE=&1300", &0D ; Set PAGE to second file buffer (as we only use 1 file at a time)
EQUS "*FX21", &0D ; Flush buffer
EQUS "CLOSE#0:CH.", '"', "LOADER", '"', &0D ; Close "!BOOT" and run the main code
EQUS "REM https://github.com/picosonic/D3/", &0D ; Repo URL
EQUS "REM D3 build ", TIME$ ; Add a build date
.plingend

SAVE "!BOOT", plingboot, plingend
PUTBASIC "loader.bas", "$.LOADER"
PUTFILE "EXOSCR", "$.EXOSCR", EXO_LOAD_ADDR
PUTFILE "SPEECH", "$.SPEECH", EXO_LOAD_ADDR
PUTFILE "MELODY", "$.MELODY", EXO_LOAD_ADDR
SAVE "EXTRA", extradata, extraend
SAVE "VARCODE", start_of_var_code, end_of_var_code
SAVE "DIZZY3", start, codeend, onetimeinit
PUTFILE "RMDATA", "$.RMDATA", 0
SAVE "OBJDATA", movingdata, endofmovingdata
PUTFILE "TREPIC", "TREPIC", MODE8BASE
PUTFILE "loadscr", "FRAME", MODE8BASE

PRINT "-------------------------------------------"
PRINT "Zero page from ", ~zpstart, " to ", ~zpend-1, "  (", ZP_ECONET_WORKSPACE-zpend, " bytes left )"
PRINT "VARS from ", ~start_of_vars, " to ", ~end_of_vars-1
PRINT "VARCODE from ", ~start_of_var_code, " to ", ~end_of_var_code-1, "  (", SOUND_WORKSPACE-end_of_var_code, " bytes left )"
PRINT "BVARS from ", ~start_of_buff, " to ", ~end_of_buff-1, "  (", ENVELOPE_DEFS-end_of_buff, " bytes left )"
PRINT "EXTRA from ", ~extradata, " to ", ~extraend-1, "  (", NMI_WORKSPACE-extraend, " bytes left )"
PRINT "DATA from ", ~datastart, " to ", ~dataend-1, "  (", dataend-datastart, " bytes )"
PRINT "CODE from ", ~codestart, " to ", ~codeend-1, "  (", codeend-codestart, " bytes )"
PRINT ""
PRINT "Main code entry point : ", ~onetimeinit
PRINT "Objects : ", ~movingdata, "..", ~endofmovingdata, " (", noofmoving, " objs )"
PRINT ""
remaining = MODE8BASE-objend
PRINT "Bytes left before screen memory : ", ~remaining, "  (", remaining, " bytes )"
PRINT "-------------------------------------------"
