REM DIZZY3
REM By The Oliver Twins 1989
:
REM Check for TUBE
IF INKEY-256 A%=&EA:X%=0:Y%=&FF:IF USR(&FFF4) AND&FF00 THEN VDU26,12:PRINT"Please turn your TUBE off, and restart":END
:
REM Load loading screen
*FX229,1
MODE1
REM Set palette
VDU 19,0,0,0,0,0
VDU 19,1,2,0,0,0
VDU 19,2,7,0,0,0
VDU 19,3,1,0,0,0
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
