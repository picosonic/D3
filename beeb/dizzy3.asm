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
INCLUDE "rooms.asm"

.frametable
INCBIN "frametable.bin"
.framedefs
INCBIN "framedefs.bin"

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
  PAGE_ROOMDATA

  LDA #STR_startmess:JSR findroomstr
  JSR prtmessage

  PAGE_RESTORE

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
  LDA dizzyx:STA frmx
  LDA dizzyy:STA frmy
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
;  TXA:AND #PAD_START:BEQ setsequnce ; No jump
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
PUTFILE "RMDATA", "$.RMDATA", &4000
SAVE "OBJDATA", movingdata, endofmovingdata
PUTFILE "TREPIC", "TREPIC", MODE8BASE
PUTFILE "loadscr", "FRAME", MODE8BASE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Hearts demo loads over the top of roomdata
ORG MAIN_LOAD_ADDR
CLEAR datastart, datastart+BIGGESTROOM
GUARD datastart+BIGGESTROOM
.hearts_start
INCLUDE "hearts.asm"
.hearts_end

SAVE "HEARTS", hearts_start, hearts_end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

PRINT "-------------------------------------------"
PRINT "Zero page from ", ~zpstart, " to ", ~zpend-1, "  (", ZP_ECONET_WORKSPACE-zpend, " bytes left )"
PRINT "Stack from ", ~start_of_stack, " to ", ~end_of_stack-1
PRINT "VARS from ", ~start_of_vars, " to ", ~end_of_vars-1
PRINT "VARCODE from ", ~start_of_var_code, " to ", ~end_of_var_code-1, "  (", SOUND_WORKSPACE-end_of_var_code, " bytes left )"
PRINT "BVARS from ", ~start_of_buff, " to ", ~end_of_buff-1, "  (", ENVELOPE_DEFS-end_of_buff, " bytes left )"
PRINT "EXTRA from ", ~extradata, " to ", ~extraend-1, "  (", NMI_WORKSPACE-extraend, " bytes left )"
PRINT "DATA from ", ~datastart, " to ", ~dataend-1, "  (", dataend-datastart, " bytes )"
PRINT "CODE from ", ~codestart, " to ", ~codeend-1, "  (", codeend-codestart, " bytes )"
PRINT "HEARTS from ", ~hearts_start, " to ", ~hearts_end-1, "  (", hearts_end-hearts_start, " bytes )"
PRINT ""
PRINT "Main code entry point : ", ~onetimeinit
PRINT "Objects : ", ~movingdata, "..", ~endofmovingdata, " (", endofmovingdata-movingdata, " bytes, ", noofmoving, " objs )"
PRINT ""
remaining = MODE8BASE-objend
PRINT "Space before screen memory : ", ~remaining, "  (", remaining, " bytes left )"
PRINT "-------------------------------------------"
