REM DIZZY2 - Treasure Island Dizzy
REM   by The Oliver Twins 1989
:
REM Disable ESC processing
*FX229,1
:
REM Load DIZZY2 screen
MODE1
VDU23,1,0;0;0;0;:REM Hide cursor
:
REM Set palette
VDU19,0,0,0,0;
VDU19,1,4,0,0;
VDU19,2,3,0,0;
VDU19,3,7,0,0;
:
REM Set the screen up
?&FE00=&01:?&FE01=&40
?&FE00=&02:?&FE01=&59
?&FE00=&06:?&FE01=&18
?&FE00=&07:?&FE01=&1F
?&FE00=&0D:?&FE01=&00
?&FE00=&0C:?&FE01=&0A
:
*L.TREPIC
END
