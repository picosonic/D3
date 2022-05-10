; OS defines
INCLUDE "os.asm"

; Variable and constant defines
INCLUDE "consts.asm"
INCLUDE "vars.asm"

ORG MAIN_LOAD_ADDR
GUARD MODE8BASE

.start
.datastart
EQUB &00 ; Placeholder
.dataend

.codestart
INCLUDE "init.asm"

.infiniteloop
  JMP infiniteloop
.codeend

ORG &0900
GUARD &0D00
.extradata
INCLUDE "extra.asm"
.extraend

ORG &00
CLEAR &00, &FF
.plingboot
EQUS "*BASIC", &0D ; Reset to BASIC
EQUS "PAGE=&1900", &0D ; Set PAGE
EQUS "*FX21", &0D ; Flush buffer
EQUS "CLOSE#0:CH.", '"', "LOADER", '"', &0D ; Close "!BOOT" and run the main code
EQUS "REM https://github.com/picosonic/D3/", &0D ; Repo URL
EQUS "REM D3 build ", TIME$ ; Add a build date
.plingend

SAVE "!BOOT", plingboot, plingend
PUTBASIC "loader.bas", "$.LOADER"
PUTFILE "loadscr", "$.LOADSCR", MODE8BASE
SAVE "EXTRA", extradata, extraend
SAVE "DIZZY3", start, codeend, codestart

PRINT "-------------------------------------------"
PRINT "Zero page from &00 to ", ~zpend-1, "  (", ZP_ECONET_WORKSPACE-zpend, " bytes left )"
PRINT "VARS from &400 to ", ~end_of_vars-1, "  (", SOUND_WORKSPACE-end_of_vars, " bytes left )"
PRINT "EXTRA from ", ~extradata, " to ", ~extraend-1, "  (", NMI_WORKSPACE-extraend, " bytes left )"
PRINT "DATA from ", ~datastart, " to ", ~dataend-1
PRINT "CODE from ", ~codestart, " to ", ~codeend-1, "  (", codeend-codestart, " bytes )"
PRINT ""
remaining = MODE8BASE-codeend
PRINT "Bytes left : ", ~remaining, "  (", remaining, " bytes )"
PRINT "-------------------------------------------"
