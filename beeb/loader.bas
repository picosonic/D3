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
swrpage=&11FF
swrtest=&1600
swrcopy=&1634
CALL swrtest
IF ?swrpage=255 MODE7:PRINT"No sideways RAM detected":END
*L.RMDATA
Y%=&FF:CALL swrcopy
swrpage=swrpage-1
IF ?swrpage=255 MODE7:PRINT"Only one sideways RAM detected, two or  more required":END
*L.XDATA
Y%=&FE:CALL swrcopy
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
