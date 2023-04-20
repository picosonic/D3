REM DIZZY3 - Fantasy World Dizzy
REM   by The Oliver Twins 1989
:
REM Check for TUBE
IF INKEY-256 A%=&EA:X%=0:Y%=&FF:IF USR(&FFF4) AND&FF00 THEN VDU26,12:PRINT"Please turn your TUBE off, and restart":END
:
*FX200,3
MODE7:VDU23;8202;0;0;0;
:
PROCDIZZY
PRINT'CHR$(129)"GAME STORY:"
PRINT'" DIZZY & DAISY strolled through the      enchanted forest without a care in the"
PRINT" world..."
PRINT'CHR$(131)"BUT SUDDENLY"CHR$(135)"the Evil King's trolls     seized poor Daisy!"
PRINT'" She was sent to Wizard Weird's Tallest  Tower while Dizzy was dragged away and"
PRINT" thrown into the deepest, darkest,       dankest, of the King's Dungeons in the"
PRINT" bowels of Fantasy World."
*FX200,2
PROCSPACE
:
PROCDIZZY
PRINT'CHR$(129)"GAME STORY:"
PRINT'" DIZZY was frightened!   Who knew what   fate awaited him...and he still hadn't"
PRINT" done this week's homework!"
PRINT'" But then he remembered that he had a   "CHR$(130)"fresh green apple"CHR$(135)"that he had planned"
PRINT" to give to his teacher to escape        detention, and he cheered up.   And"
PRINT" there was some"CHR$(131)"bread"CHR$(135)"and"CHR$(134)"water"CHR$(135)"on the   table! A cunning plan began to brew"
PRINT" in his mind..."
PRINT'" But DIZZY can't do everything on his    own...you must help him!"
PROCSPACE
:
PROCDIZZY
PRINT'CHR$(129)"CONTROL FUNCTIONS:"
PRINT'CHR$(131)"     Z"CHR$(135)"moves DIZZY"CHR$(129)"left"
PRINT'CHR$(131)"     X"CHR$(135)"moves DIZZY"CHR$(129)"right"
PRINT'CHR$(131)" SPACE"CHR$(135)"to make DIZZY"CHR$(129)"jump"
PRINT'CHR$(131)"RETURN"CHR$(135)"to"CHR$(129)"pick up"CHR$(135)"items or coins, or to open your inventory. When using the"
PRINT" inventory use"CHR$(131)"*"CHR$(135)"and"CHR$(131)"?"CHR$(135)"to go"CHR$(129)"up"CHR$(135)"and"CHR$(129)"down"CHR$(135)"to select something to use or drop"
PRINT'CHR$(131)"ESCAPE"CHR$(135)"quits the game"
PROCSPACE
:
CLS:*FX200,3
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
swrtest=&1D00
swrcopy=&1D34
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
:
DEFPROCDIZZY
PRINTTAB(9,0)CHR$(141)CHR$(131)"FANTASY WORLD DIZZY"
PRINTTAB(9,1)CHR$(141)CHR$(129)"FANTASY WORLD DIZZY"
ENDPROC
:
DEFPROCSPACE
*FX15,0
PRINTTAB(5,23)CHR$(129)"Press"CHR$(131)"SPACE BAR"CHR$(129)"to continue"
REPEATUNTILGET=32:CLS
ENDPROC
