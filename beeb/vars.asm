; Zero page variables

ORG ZEROPAGE
GUARD ZP_ECONET_WORKSPACE

.zpstart

; Input bitfield
.keys EQUB &00

.zptr1 EQUW 0
.zidx1 EQUB 0

.zptr2 EQUW 0
.zidx2 EQUB 0

.zptr3 EQUW 0
.zidx3 EQUB 0

.zptr4 EQUW 0
.zidx4 EQUB 0

.zptr5 EQUW 0
.zidx5 EQUB 0

.zptr6 EQUW 0
.zidx6 EQUB 0

.roomptr EQUW 0
.nextroomptr EQUW 0

.ztmp1 EQUB 0
.ztmp2 EQUB 0
.ztmp3 EQUB 0
.ztmp4 EQUB 0
.ztmp5 EQUB 0
.ztmp6 EQUB 0

; Seed for random number generator
.seed EQUW &0000, &0000

; Frame counter
.oldclock EQUB &00
.clock EQUB &00

; Frame data
.frmno EQUB 0
.frmx EQUB 0
.frmy EQUB 0
.frmattri EQUB 0
.frmwidth EQUB 0
.frmheight EQUB 0
.frmplot EQUB 0
.frmreverse EQUB 0
.frmlocation EQUW 0
.frmcolour EQUB 0

.eggcount EQUB 0 ; Dizzy animation countdown

; Dizzy position / status
.dizzyx EQUB 0 ; X
.dizzyy EQUB 0 ; Y
.dizzyfrm EQUB 0 ; Frame
.dizzyox EQUB 0 ; Old X
.dizzyoy EQUB 0 ; Old Y
.dizzyofrm EQUB 0 ; Old frame

.dontupdatedizzy EQUB 0

; Flames / water / lava
.noofflames EQUB 0 ; Count of active flames
.noofwater EQUB 0 ; Count of active water / lava
.waterheight EQUB 0 ; Water line
.watercolour EQUB 0 ; If "water" is actually water / lava

.flamelist ; 4 * (X, Y, Frame)
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0

.waterlist ; 8 * (X, Y, Frame)
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0, 0, 0
  EQUB 0

.talkbefore
  EQUB 0, 0, 0, 0, 0
  EQUB 0

.objectscarried
  EQUB 0, 0, 0, 0
.bag
  EQUB 0

; Dragon
.dragonvar EQUB 0
.breathingfire EQUB 0
.dragonflame EQUB 0

; Non-zero to clip draw routine to play area
.cliptoplayarea EQUB 0
.startx EQUB 0 ; Starting X position
.starty EQUB 0 ; Starting Y position
.startroom EQUB 0 ; Starting room id
.coins EQUB 0 ; Count of collected coins
.lives EQUB 0 ; Number of lives remaining
.fireout EQUB 0 ; Non-zero means fire in room 36 is out
.ratcount EQUB 0 ; 0 / 1 / 2
.completedgame EQUB 0

.printloops EQUB 0 ; Number of remaining loops when doing print repeats
.printidx EQUB 0 ; Place to loop back to on repeats

.zpend

; ---------------------------------------------------------
; Variables in LANGUAGE workspace, &400 to &7FF

ORG LANGUAGE_WORKSPACE
GUARD SOUND_WORKSPACE

.start_of_vars

; When drawing flipped frame, it's built here
.flippedframe SKIP 190 ; Biggest frame (&b6) - a branch, is 190 bytes

.end_of_vars

; ---------------------------------------------------------
; Variables in printer buffer workspace, &880 to &8BF

ORG PRINTER_BUFFER
GUARD ENVELOPE_DEFS

.start_of_buff

.roomno EQUB 0 ; Current room
.loadedroomno EQUB 0 ; Last room loaded from disk
.roomlen EQUW 0 ; Length of active roomdata

.end_of_buff