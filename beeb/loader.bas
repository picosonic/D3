REM DIZZY3 - Fantasy World Dizzy
REM   by The Oliver Twins 1989
:
REM Check for TUBE
IF INKEY-256 A%=&EA:X%=0:Y%=&FF:IF USR(&FFF4) AND&FF00 THEN VDU26,12:PRINT"Please turn your TUBE off, and restart":END
:
REM Disable ESC processing
*FX229,1
:
REM Load loading screen
MODE1
VDU23,1,0;0;0;0;:REM Hide cursor
:
REM Set palette
VDU19,0,0,0,0;
VDU19,1,2,0,0;
VDU19,2,7,0,0;
VDU19,3,1,0,0;
:
*/EXOSCR
*FX15
A=INKEY(500)
:
REM Load extra datafile
*L.EXTRA
:
REM Load and run main game file
*/DIZZY3
END
