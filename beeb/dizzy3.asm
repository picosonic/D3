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

.entrypoint
INCLUDE "init.asm"

  ; Default to drawing frames clipped to play area
  LDA #&01:STA cliptoplayarea

  ; Reset loaded room number
  LDA #&FF:STA loadedroomno

  ; Reset coins
  STA coins
  JSR addtocoins

  JSR resetmoving ; Put all the objects back to their starting positions

  ; Open roomdata file
  LDX #lo(roomdatafn)
  LDY #hi(roomdatafn)
  LDA #OPENIN
  JSR OSFIND
  STA fcb ; Store file handle

  ; Load initial room
  LDA #STARTROOM:JSR roomsetup

.gameloop
{
  JSR process_inputs

  ; See if room changed
  LDA roomno:CMP loadedroomno:BEQ same

  JSR roomsetup
  ; Wait until nothing pressed
.holdon
  LDX keys:BNE holdon

.same

  JMP gameloop
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

;.drawloop
  ;LDA loadedroom:JSR drawroom
  ;JSR waitabit
;
  ;;JSR addtocoins
  ;;LDA #hi(youfoundcoinmess):STA zptr5+1
  ;;LDA #lo(youfoundcoinmess):STA zptr5
  ;;JSR windowrou
;
  ;;LDA #hi(inventory):STA zptr5+1
  ;;LDA #lo(inventory):STA zptr5
  ;;JSR prtmessage
;
;.nextroom
  ;INC loadedroom
;
  ;; Check for overflow
  ;LDA loadedroom:CMP #101:BCC keepgoing
  ;LDA #&00:STA loadedroom
;.keepgoing
;
  ;; Set up pointer to data for this room
  ;LDA loadedroom:ASL A:TAY
  ;LDA roomtable, Y:STA roomptr
  ;LDA roomtable+1, Y:STA roomptr+1
;
  ;; Set up pointer to data for next room
  ;LDA roomtable+2, Y:STA nextroomptr
  ;LDA roomtable+3, Y:STA nextroomptr+1
;
  ;; If this is an empty room, then skip it
  ;LDA roomptr+1:CMP nextroomptr+1:BNE lroomok
  ;LDA roomptr:CMP nextroomptr:BNE lroomok
  ;JMP nextroom
;
;.lroomok
  ;JMP drawloop
;
;.loadedroom
;  EQUB &00

; Wait for 256 vblanks ~ 5 seconds @ 50Hz
.waitabit
{
  LDX #&00

.somemore
  JSR waitvsync
  DEX
  BNE somemore

  RTS
}

.infiniteloop
  JMP infiniteloop

; Handler for VBLANK event
.eventhandler
{
  ; Save registers
  PHP
  PHA
  TXA:PHA
  TYA:PHA

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
SAVE "DIZZY3", start, codeend, entrypoint
PUTFILE "TREPIC", "TREPIC", MODE8BASE
PUTFILE "loadscr", "FRAME", MODE8BASE

PRINT "-------------------------------------------"
PRINT "Zero page from ", ~zpstart, " to ", ~zpend-1, "  (", ZP_ECONET_WORKSPACE-zpend, " bytes left )"
PRINT "VARS from ", ~start_of_vars, " to ", ~end_of_vars-1, "  (", SOUND_WORKSPACE-end_of_vars, " bytes left )"
PRINT "EXTRA from ", ~extradata, " to ", ~extraend-1, "  (", NMI_WORKSPACE-extraend, " bytes left )"
PRINT "DATA from ", ~datastart, " to ", ~dataend-1, "  (", dataend-datastart, " bytes )"
PRINT "CODE from ", ~codestart, " to ", ~codeend-1, "  (", codeend-codestart, " bytes )"
PRINT ""
PRINT "Main code entry point : ", ~entrypoint
PRINT "Objects : ", ~movingdata, "..", ~endofmovingdata, " (", noofmoving, " objs )"
PRINT ""
remaining = MODE8BASE-codeend
PRINT "Bytes left : ", ~remaining, "  (", remaining, " bytes )"
PRINT "-------------------------------------------"
