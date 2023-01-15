REM DIZZY3 - Fantasy World Dizzy
REM   by The Oliver Twins 1989
:
REM Check for TUBE
IF INKEY-256 A%=&EA:X%=0:Y%=&FF:IF USR(&FFF4) AND&FF00 THEN VDU26,12:PRINT"Please turn your TUBE off, and restart":END
:
REM Disable ESC processing
*FX229,1
:
REM Prepare screen
MODE1
VDU23,1,0;0;0;0;:REM Hide cursor
VDU19,1,0;0;19,2,0;0;19,3,0;0;:REM Blank palette
:
REM Sideways RAM loader
DIM code 80
swrpage=&11FF
romsel=&FE30
swrcheck=&8008
FOR N%=0 TO 2 STEP 2
P%=code
[ OPT N%
.swrtest
SEI
LDY #&FF:STY swrpage:INY
.findswr
STY romsel
LDA swrcheck:EOR #&55:STA swrcheck
CMP swrcheck
BNE noswryet
STY swrpage:BEQ swrdone
.noswryet
INY:CPY #16
BNE findswr
.swrdone
LDY &F4:STY romsel
CLI
RTS
.swrcopy
SEI
LDY swrpage:STY romsel
LDX #&00
.swrcpyloop
LDA &4000, X:STA &8000, X
INX
CPX #&00:BNE swrcpyloop
INC swrcpyloop+2:INC swrcpyloop+5
LDA swrcpyloop+2
CMP #&80:BNE swrcpyloop
LDY &F4:STY romsel
CLI
RTS
]
NEXT
IF P%-code > 80 MODE7:PRINT"Too much code ";P%-code:END
CALL swrtest
IF ?swrpage=255 MODE7:PRINT"No sideways RAM detected":END
*L.RMDATA
CALL swrcopy
:
REM Load loading screen
*/EXOSCR
:
VDU19,1,1;0;19,2,2;0;19,3,7;0;:REM Set palette
:
*/SPEECH
REM */MELODY
:
REM Load extra datafile
*L.EXTRA
:
REM Load and run main game file
*/DIZZY3
END
