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
INCLUDE "objects.asm"
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

  LDA #&03:STA lives ; Set the number of lives to start with
  LDA #46:STA startx
  LDA #168:STA starty
  LDA #STARTROOM:STA startroom
  
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

  LDA dontupdatedizzy
  BNE nodraw

  JSR updatedizzy
.nodraw

  JMP maingamelp
}

.resetcarrying
{
  LDA #&00
  STA objectscarried
  STA objectscarried+2
  STA objectscarried+3

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
  JSR waitvsync

  ; See if we are allowed to run yet
  DEC eggcount:LDA eggcount
  BEQ timetoupdate
  RTS

  .timetoupdate
  LDA #4:STA eggcount ; Schedule next update in 4 frames time

  ;;;;; TEMPORARILY DRAW A DIZZY FRAME TO TEST ;;;;;
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

.codeend

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
PUTFILE "MELODY", "$.MELODY", EXO_LOAD_ADDR
PUTFILE "SPEECH", "$.SPEECH", EXO_LOAD_ADDR
PUTFILE "RMDATA", "$.RMDATA", 0
SAVE "EXTRA", extradata, extraend
SAVE "DIZZY3", start, codeend, onetimeinit
SAVE "OBJDATA", movingdata, endofmovingdata
PUTFILE "TREPIC", "TREPIC", MODE8BASE
PUTFILE "loadscr", "FRAME", MODE8BASE

PRINT "-------------------------------------------"
PRINT "Zero page from ", ~zpstart, " to ", ~zpend-1, "  (", ZP_ECONET_WORKSPACE-zpend, " bytes left )"
PRINT "VARS from ", ~start_of_vars, " to ", ~end_of_vars-1, "  (", SOUND_WORKSPACE-end_of_vars, " bytes left )"
PRINT "EXTRA from ", ~extradata, " to ", ~extraend-1, "  (", NMI_WORKSPACE-extraend, " bytes left )"
PRINT "DATA from ", ~datastart, " to ", ~dataend-1, "  (", dataend-datastart, " bytes )"
PRINT "CODE from ", ~codestart, " to ", ~codeend-1, "  (", codeend-codestart, " bytes )"
PRINT ""
PRINT "Main code entry point : ", ~onetimeinit
PRINT "Objects : ", ~movingdata, "..", ~endofmovingdata, " (", noofmoving, " objs )"
PRINT ""
remaining = MODE8BASE-codeend
PRINT "Bytes left before screen memory : ", ~remaining, "  (", remaining, " bytes )"
PRINT "-------------------------------------------"
