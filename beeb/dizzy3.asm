; OS defines
INCLUDE "os.asm"

MODE8BASE = &5000

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
