REM DIZZY3
REM By The Oliver Twins 1989
:
REM Check for TUBE
IF INKEY-256 A%=&EA:X%=0:Y%=&FF:IF USR(&FFF4) AND&FF00 THEN VDU26,12:PRINT"Please turn your TUBE off, and restart":END
:
REM Load loading screen
*FX229,1
MODE1
VDU23,1,0;0;0;0;:REM Hide cursor
:
VDU 19,0,0,0,0,0
VDU 19,1,2,0,0,0
VDU 19,2,7,0,0,0
VDU 19,3,1,0,0,0
:
?&FE00=&01:?&FE01=&40:REM Set 256 pixels wide
?&FE00=&02:?&FE01=&59:REM Centre horizontally
?&FE00=&06:?&FE01=&1C:REM Set 240 pixels high
?&FE00=&07:?&FE01=&1F:REM Centre vertically
:
REM Change screen start address to &5000
REM  to gain 8k bytes
?&FE00=&0D:?&FE01=&00
?&FE00=&0C:?&FE01=&0A
:
*L.LOADSCR
*FX15
A=INKEY(500)
