; Zero page variables

ORG ZEROPAGE
GUARD ZP_ECONET_WORKSPACE

.zpstart

; Input bitfield
.keys EQUB &00

; Z80 equivalents
.z80bcreg
.z80creg EQUB 0
.z80breg EQUB 0

.z80dereg
.z80ereg EQUB 0
.z80dreg EQUB 0

.z80hlreg
.z80lreg EQUB 0
.z80hreg EQUB 0

.z80ixreg EQUW 0
.z80iyreg EQUW 0

; Pointers and indexes
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

.machineptr EQUW 0
.liftptr EQUW 0

; Temporary variables
.ztmp1 EQUB 0
.ztmp2 EQUB 0
.ztmp3 EQUB 0
.ztmp4 EQUB 0
.ztmp5 EQUB 0
.ztmp6 EQUB 0
.ztmp7 EQUB 0
.ztmp8 EQUB 0

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
.x EQUB 0
.ox EQUB 0
.y EQUB 0
.oy EQUB 0
.dy EQUB 0
.ff EQUB 0
.of EQUB 0
.floor EQUB 0
.animation EQUB 0
.sequence EQUB 0
.lookx EQUB 0
.looky EQUB 0

.startx EQUB 0 ; Starting X position
.starty EQUB 0 ; Starting Y position
.oldx EQUB 0
.oldy EQUB 0
.oldox EQUB 0
.oldoy EQUB 0

; Dizzy position / status
.dizzyx EQUB 0 ; X
.dizzyy EQUB 0 ; Y
.dizzyfrm EQUB 0 ; Frame
.dizzyox EQUB 0 ; Old X
.dizzyoy EQUB 0 ; Old Y
.dizzyofrm EQUB 0 ; Old frame
.deathmsg EQUB 0 ; Message ID to use upon death

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

.printloops EQUB 0 ; Number of remaining loops when doing print repeats
.printidx EQUB 0 ; Place to loop back to on repeats

.zpend

; ---------------------------------------------------------
; Variables in STACK, from &100

ORG STACK
GUARD USERV

attrisize = ((MAXX/ATTR_GRID)/BITSPERBYTE) * ((MAXY-((5+1+1)*ATTR_GRID))/ATTR_GRID)

.start_of_stack

; Attribute table, used for hit-detection on 8x8 grid of screen
; 256x136 = 32x17 blocks = 4x17 bytes
.attritable
.hearttable ; 32 x (X, Y)
SKIP attrisize

.end_of_stack

; ---------------------------------------------------------
; Variables in LANGUAGE workspace, from &400

ORG LANGUAGE_WORKSPACE
GUARD SOUND_WORKSPACE

.start_of_vars

; When drawing flipped frame, it's built here
.flippedframe SKIP 190 ; Biggest frame (&b6) - a branch, is 190 bytes

.end_of_vars

; ---------------------------------------------------------
; Code in LANGUAGE workspace, up to &7FF

.start_of_var_code

INCLUDE "varcode.asm"

.end_of_var_code

; ---------------------------------------------------------
; Variables in printer buffer workspace, &880 to &8BF

ORG PRINTER_BUFFER
GUARD ENVELOPE_DEFS

.start_of_buff

.lastroom EQUB 0
.roomno EQUB 0 ; Current room
.newroomno EQUB 0
.oldroomno EQUB 0
.roomlen EQUW 0 ; Length of active room
.spritenothere EQUB 0
.dontupdatedizzy EQUB 0
.killed EQUB 0
.killedmess EQUW 0 ; Pointer to message to show why Dizzy killed
.coins EQUB 0 ; Count of collected coins
.lives EQUB 0 ; Number of lives remaining
.usepickup EQUB 0
.pickup EQUB 0 ; Flag to say if we can pickup/drop objects
.toomuchtohold EQUB 0
.objecttodrop EQUB 0 ; The id of object to be dropped
.cyclecolour EQUB 0 ; Used when colouring selected inventory item, 0..7
.tryputdownvar EQUB 0
.obstructinglift EQUB 0
.drunk EQUB 0
.shopkeepercount EQUB 0
.spat EQUB 0
.fireout EQUB 0 ; Non-zero means fire in room 36 is out
.ratcount EQUB 0 ; 0 / 1 / 2
.slotno EQUB 0
.completedgame EQUB 0
.holding EQUB 0
.holdingix EQUB 0
.holidingnumberix EQUB 0
.deadmess EQUB 0
.implode EQUB 0
.startroom EQUB 0 ; Starting room id
.objcollide EQUB 0 ; Allow proximity collision detection to work

; Collision box
.cx EQUB 0
.cy EQUB 0
.cw EQUB 0
.ch EQUB 0

.end_of_buff
