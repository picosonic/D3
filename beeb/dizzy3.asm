; OS defines
INCLUDE "os.asm"
INCLUDE "inkey.asm"
INCLUDE "internal.asm"

; Variable and constant defines
INCLUDE "consts.asm"
INCLUDE "vars.asm"

; Debug settings
seecoins = 0

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

; Dizzy sprites
INCLUDE "dizzyfrm.asm"
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
  STA oldclock
  STA clock ; Init clock
  STA dontupdatedizzy ; Allow Dizzy to be drawn

  ; Fall through into main game loop
}  

.maingamelp
{
  JSR process_inputs ;;; TODO - move this

.notpickup
  LDA #&00:STA pickup
  LDA usepickup:BEQ oktopickup
  SEC:SBC #&01:STA usepickup
  JMP notfacing

.oktopickup
  LDA sequence
  BNE notfacing
  LDA keys:AND #PAD_FIRE:BNE notfacing ; Check for FIRE / RETURN being pressed
  LDA #&FF:STA pickup

.notfacing
  JSR domoving
  LDA killed
  CMP #&01
  BEQ wantaquickkill

.afterdomoving
  ;JSR pickupcoins
  ;JSR tryputtingdown

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
  LDA #STR_killedbydaggersmess:JSR findroomstr
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
