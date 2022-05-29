; Moving stuff

; Offsets into 16-byte objects array
room = 0
rou = 1
movex = 2
movey = 3
movefrm = 4
oldmovex = 5
oldmovey = 6
oldmovefrm = 7
delay = 8
delaycounter = 9
var1 = 10
colour = 11
origroom = 12
origx = 13
origy = 14
origfrm = 15

; Routine index
portcullis = 0
portswitch = 1
pickupable = 2
armorog = 3
dragon = 4
crocodile = 5
log = 6
hawk = 7
machines = 8 
lift = 9
dozyfloat = 10
rat = 11
troll = 12
dagger = 13
door  = 14
crowbar = 15
miner = 16
daisy = 17
switch1 = 18
daisy1 = 19

;colour byte     7   6   5     4   3   2   1   0
;               rev:dull:atplot:plot: colour

.movingdata

; room, rou, x, y, frm, oldx, oldy, ofrm, dly, v1, v2, col, orm, orx, ory, ofrm

 EQUB 49, hawk, 60, 80, 97 
 EQUW nothingheremess
 EQUB 0, 2, 0, 0, 5+8+16, 49, 60, 80, 97

 EQUB 55, pickupable, 48, 144, 1
 EQUW bagmess
 EQUB 0, 0, 0, 0, 2+64, 55, 48, 144, 1

.porthere
 EQUB 51,portcullis,76 ,136,120,96,136,   0   ,4  ,0 ,0 ,7   ,51 ,76 ,96,120

 EQUB 51,portswitch,66 ,78 ,122,0   ,0   ,0   ,0  ,0 ,0 ,5+64,51 ,66 ,78 ,122

.shopkeeperhere
 EQUB 22,pickupable,68 ,136,105
 EQUW                pigmycowmess,shoptalk
 EQUB                   0 ,0 ,7+64,255,68,136,105

.shopkeeperhere1
 EQUB 22,crowbar,68+4,136,105
 EQUW                pigmycowmess,shoptalk
 EQUB                0 ,0 ,7+64+128,255,68+4,136,105

 EQUB 72,pickupable,62 ,144,11
 EQUW                blackholemess
 EQUB        0   ,0  ,0 ,0 ,7+64,72 ,62 ,144,11

.manurehere
 EQUB 58,pickupable,72 ,170,3
 EQUW                0 ;;;pickupmanuremess
 EQUB        0,   0,  0 ,0 ,2+64,58,72 ,170,3

 EQUB 36,pickupable,58 ,136,17
 EQUW                applemess,proxapple
 EQUB                 0 ,0 ,4+64,255,58 ,136,17

.bonehere
 EQUB 100,pickupable,52 ,160,6
 EQUW                           bonemess
 EQUB                                     0   ,0  ,0 ,0 ,7+64,100 ,52 ,160,6

.beanhere
 EQUB 22,pickupable,68 ,160,2
 EQUW                greenbeanmess,proxbean
 EQUB                 0 ,0 ,4+64,255 ,62 ,144,2

.goldenegghere
 EQUB 93,pickupable,80 ,152,10
 EQUW                goldeneggmess,proxegg
 EQUB                 0 ,0 ,7+64,93 ,80 ,152,10

 EQUB 50,pickupable,86 ,160,138
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,2+64,50 ,86 ,160,138

.armoroghere
 EQUB 50,armorog   ,54 ,156,102,0   ,0   ,0   ,2  ,0 ,0 ,2+64+8,50 ,54 ,156,102  

.dragonhere
 EQUB 54,dragon    ,68 ,152,109,0   ,0   ,0   ,0  ,0 ,0 ,2+64,54 ,68 ,152,109

.sleepingpotionhere
 EQUB 45,pickupable,80 ,128,15
 EQUW                sleeppotionmess,proxsleep
 EQUB                 0 ,0 ,6+64,255,80 ,128,15

 EQUB 53,crocodile ,70 ,152,123,0   ,0   ,0   ,0  ,0 ,0 ,4+8,53 ,70 ,152,123

.ropehere
 EQUB 68,pickupable,76 ,160,14
 EQUW                ropemess,proxcroc
 EQUB                 0 ,0 ,7+64,255,76 ,160,14

 EQUB 35,pickupable,58 ,136,139
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,2+64,35 ,58,136,139

 EQUB 53,pickupable,90 ,144,136
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,2+64,53 ,90 ,144,136

 EQUB 48,log       ,60 ,136,158,0   ,0   ,0   ,4  ,0 ,0 ,2+8 ,48 ,60 ,136,158

.whiskeyhere
 EQUB 53,pickupable,50 ,136,18
 EQUW                fullwhiskeymess,emptybottlemess
 EQUB                 0 ,0 ,6+64,53 ,50 ,136,18

 EQUB 71,lift      ,52 ,56 ,125,56,112,   0   ,1  ,0 ,0 ,7+16,71 ,52,48 ,125

 EQUB 56,machines  ,50 ,116,127 ,0   ,0   ,0   ,32 ,0 ,0 ,5+64 ,56,50 ,116,127

 EQUB 85,pickupable,46 ,136,13
 EQUW                keymess,proxkey1
 EQUB                 0 ,0 ,6+64,85 ,46 ,136,13

 EQUB 40,lift      ,40 ,56 ,125,56,134,   0   ,1  ,0 ,0 ,7+16,40 ,40,56 ,125

 EQUB 56,machines  ,72 ,116,127 ,0   ,0   ,0   ,32 ,0 ,0 ,5+64,56,72 ,116,127

 EQUB 24,pickupable,80 ,136,13
 EQUW                keymess,proxkey2
 EQUB                 0 ,0 ,6+64,24 ,80 ,136,13

 EQUB 88,lift      ,58 ,56 ,125,56,136,   0   ,1  ,0 ,0 ,7+16,88 ,58,48 ,125

 EQUB 56,machines  ,52 ,156,127 ,0   ,0   ,0   ,32 ,0 ,0 ,5+64,56,52 ,156 ,127

 EQUB 60,pickupable,60 ,120,13
 EQUW                keymess,proxkey3
 EQUB                 0 ,0 ,6+64,60 ,60 ,120,13

 EQUB 56,lift      ,60 ,104 ,125,104,140,   0   ,1  ,0 ,0 ,7+16 ,56 ,60,104 ,125

 EQUB 56,machines  ,70 ,156,127 ,0   ,0   ,0   ,32 ,0 ,0 ,5+64,56,70 ,156,127

 EQUB 48,pickupable,40 ,96,13
 EQUW                keymess,proxkey4
 EQUB                 0 ,0 ,6+64,48 ,40 ,96,13

.buckethere
 EQUB 83,pickupable,80 ,144,5
 EQUW                mtbucketmess,proxmtbucket
 EQUB                 0 ,0 ,5+64,83,80 ,144,5

 EQUB 60,pickupable,46 ,144,5
 EQUW                fullbucketmess,proxfullbucket
 EQUB                 0 ,0 ,5+64,255,46 ,144,5

 EQUB 59,pickupable,52 ,102,206
 EQUW                leavesmess
 EQUB        0,   0,  0 ,0 ,4+64,59,52 ,102,206

 EQUB 58,pickupable,60 ,160,7
 EQUW                pigmycowmess
 EQUB        0,   0,  0 ,0 ,7+64,58,60 ,160,7

 EQUB 55,pickupable,58 ,136,206
 EQUW                leavesmess
 EQUB        0,   0,  0 ,0 ,4+64,55,58 ,136,206

 EQUB 55,pickupable,76 ,128,192
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,2+64,55,76 ,128,192

.dozyhere
 EQUB 45,pickupable,74 ,116,32
 EQUW                dozyrou,dozytalking
 EQUB                   0 ,0 ,7+64,45,74 ,116,32

.dozyfloathere
 EQUB 45,dozyfloat,68 ,139,32,0  ,0  ,0   ,0,      0 ,0 ,7+64+16+8,45,68,139,32

 EQUB 36,pickupable,68 ,144,19
 EQUW                jugmess,proxjug
 EQUB                 0 ,0 ,5+64,36,68 ,144,19

.loafhere
 EQUB 36,pickupable,72 ,144,20
 EQUW                loafmess,proxloaf
 EQUB               0 ,0 ,6+64,36,72 ,144,20

.rathere
 EQUB 36,rat       ,42 ,73 ,104,44,80 ,   0   ,2  ,0 ,0 ,5+16+8,36,96,73 ,104

.trollhere
 EQUB 36,troll     ,78 ,136,96 ,44,80 ,   0   ,0  ,0 ,0 ,4+64 ,36,78,136 ,96

 EQUB 69,dagger    ,78 ,136,169 ,0 ,0 ,   0   ,0  ,0 ,0 ,7+64 ,69,40,112 ,169

 EQUB 89,pickupable,58 ,136,21
 EQUW            doorknockermess,proxdoor
 EQUB                 0 ,0 ,6+64,89,58 ,136,21

.doorhere
 EQUB 84,door    ,34 ,144,177 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2 ,84,34,144 ,177

.doughere
 EQUB 88,pickupable,42 ,76,36
 EQUW                dougrou,dougtalking
 EQUB                   0 ,0 ,7+64,88,42,76,36

.dragonhere1
 EQUB 40,dragon    ,68 ,152,109,0   ,0   ,0   ,0  ,0 ,0 ,4+64,40 ,68 ,152,109

.goldenegghere1
 EQUB 40,pickupable,60 ,152,10
 EQUW                goldeneggmess
 EQUB        0   ,0  ,0 ,0 ,7+64,40 ,60,152,10

.crowbarhere
 EQUB 88,pickupable,48 ,80,4
 EQUW              crowbarmess,proxcrowbar
 EQUB                   0 ,0 ,5+64,255,48,80,4

.welllidhere
 EQUB 55,crowbar  ,46 ,160,158 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2 ,55,46,160,158

 EQUB 87,pickupable,64 ,80,9
 EQUW              pickaxemess,proxpickaxe
 EQUB                   0 ,0 ,2+64,87,64,80,9

.rockhere
 EQUB 41,crowbar  ,36 ,101,146 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2+8,41,36,101,146

 EQUB 41,miner     ,96 ,120,96 ,44,80 ,   0   ,0  ,0 ,0 ,4+64 ,41,96,120 ,96

 EQUB 94,dagger    ,42 ,152,169 ,0 ,0 ,   0   ,0  ,0 ,0 ,7+64 ,94,42,152,169

 EQUB 94,dagger    ,50 ,152,169 ,0 ,0 ,   0   ,0  ,0 ,0 ,7+64 ,94,50,152,169

 EQUB 40,pickupable,52 ,112,12
 EQUW              rugmess,proxrug
 EQUB                   0 ,0 ,2+64,40,52,112,12

.carpethere
 EQUB 94,crowbar  ,40 ,152,210 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2,255,40,152,210

.carpethere1
 EQUB 94,crowbar  ,46 ,152,210 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2,255,46,152,210

.daisylifthere
 EQUB 94,lift     ,74 ,56,125,56,120,   0   ,2  ,0 ,0  ,7  ,94 ,74,48,125

.daisyhere
 EQUB 94,daisy   ,75 ,80,35,0  ,0  ,0   ,2   ,  0 ,0 ,7+64+16+8,94,75,80,35

 EQUB 94,switch1 ,62 ,70,122,0   ,0   ,0   ,2  ,0 ,0 ,5+64+8,94 ,62 ,70 ,122

.dylanhere
 EQUB 59,pickupable,72 ,147,34
 EQUW                dylanrou,dylantalking
 EQUB                   0 ,0 ,7+64,59,72,147,34

.denzilhere
 EQUB 68,pickupable,80 ,155,33
 EQUW                denzilrou,denziltalking
 EQUB                   0 ,0 ,7+64,68,80,155,33

.daisy1here
 EQUB 73,daisy1,48 ,77,35,  0,0,0,2,   0 ,0 ,7+64,255,48,77,35

 EQUB 56,pickupable,84 ,128,192
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,2+64,56,84 ,128,192

 EQUB 72,pickupable,76 ,80,192
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,2+64,72,76 ,80,192

 EQUB 73,pickupable,56 ,72,204
 EQUW                windowmess
 EQUB        0,   0,  0 ,0 ,4+64,73,56 ,72,204

 EQUB 52,pickupable,86 ,88,192
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,7+64,52,86 ,88,192

.endofmovingdata

noofmoving = (endofmovingdata-movingdata)/16


;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Temporarily blank messages
.dozytalking
.dougtalking
.dylantalking
.denziltalking
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.nothingheremess EQUB PRT_END
.bagmess EQUB "EXIT:AND:DON;T:DROP",PRT_END
.greenbeanmess EQUB "A:SINGLE:GREEN:BEAN",PRT_END
.bonemess EQUB "A:FRESH:MEATY:BONE",PRT_END
.goldeneggmess EQUB "A:HEAVY:DRAGON:EGG",PRT_END
.blackholemess EQUB "A:LARGE:ROUND:HOLE",PRT_END
.sleeppotionmess EQUB "SOME:SLEEPING:POTION",PRT_END
.applemess EQUB "A:FRESH:GREEN:APPLE",PRT_END
.jugmess EQUB "A:JUG:OF:COLD:WATER",PRT_END
.loafmess EQUB "STALE:LOAF:OF:BREAD",PRT_END
.fullwhiskeymess EQUB "A:BOTTLE:OF:WHISKEY",PRT_END
.ropemess EQUB "A:PIECE:OF:ROPE",PRT_END
.rockmess EQUB "A:HEAVY:BOULDER",PRT_END
.fullwinemess EQUB "A:BOTTLE:OF:WINE",PRT_END
.emptybottlemess EQUB "AN:EMPTY:BOTTLE",PRT_END
.keymess EQUB "A:SHINY:GOLD:KEY",PRT_END
.mtbucketmess EQUB "AN:EMPTY:BUCKET",PRT_END
.fullbucketmess EQUB "A:BUCKET:OF:WATER",PRT_END
.leavesmess EQUB "A:CLUMP:OF:LEAVES",PRT_END
.pigmycowmess EQUB "A:CUTE:PIGMY:COW",PRT_END
.railingmess EQUB "A:PIECE:OF:RAILING",PRT_END
.doorknockermess EQUB "BRASS:DOOR:KNOCKER",PRT_END
.crowbarmess EQUB "A:STRONG:CROWBAR",PRT_END
.pickaxemess EQUB "A:RUSTY:OLD:PICKAXE",PRT_END
.rugmess EQUB "AN:OLD:THICK:RUG",PRT_END
.windowmess EQUB "A:WINDOW:FRAME",PRT_END

.shoptalk EQUW beanhere+room

;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Temporarily empty routines
.dozyrou
.dougrou
.dylanrou
.denzilrou
  RTS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;APPLE
.proxapple
  EQUB 36 ;;room
  EQUB 78,152 ;;;x,y
  EQUB 4,16 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLANTING BEAN
.proxbean
  EQUB 58 ;;room
  EQUB 71,160 ;;;x,y
  EQUB 8,16 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;EGG IN NEST
.proxegg
  EQUB 40 ;;room
  EQUB 54,150 ;;;x,y
  EQUB 4,20 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ROCK
.proxrock
  EQUB 48 ;;room
  EQUB 72,80 ;;;x,y
  EQUB 10,30 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SLEEP
.proxsleep
  EQUB 54 ;;room
  EQUB 60,150 ;;;x,y
  EQUB 10,30 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CROCODILE
.proxcroc
  EQUB 53 ;;room
  EQUB 68,140 ;;;x,y
  EQUB 10,20 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;KEYS
.proxkey1
  EQUB 56 ;;room
  EQUB 51,120 ;;;x,y
  EQUB 4,16 ;;;w,h
.proxkey2
  EQUB 56 ;;room
  EQUB 73,120 ;;;x,y
  EQUB 4,16 ;;;w,h
.proxkey3
  EQUB 56 ;;room
  EQUB 53,160 ;;;x,y
  EQUB 4,16 ;;;w,h
.proxkey4
  EQUB 56 ;;room
  EQUB 71,160 ;;;x,y
  EQUB 4,16 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FILL BUCKET
.proxmtbucket
  EQUB 60 ;;room
  EQUB 46,144 ;;;x,y
  EQUB 4,16 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WATER BEAN STALK
.proxfullbucket
  EQUB 58 ;;room
  EQUB 71,160 ;;;x,y
  EQUB 8,16 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;THROWING WATER OF FIRE
.proxjug
  EQUB 36 ;;room
  EQUB 44,150 ;;;x,y
  EQUB 6,26 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LOAF AND RAT
.proxloaf
  EQUB 36 ;;room
  EQUB 46,64 ;;;x,y
  EQUB 40,16 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DOOR KNOCKER
.proxdoor
  EQUB 84 ;;room
  EQUB 34,160 ;;;x,y
  EQUB 4,16 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CROW BAR
.proxcrowbar
  EQUB 55 ;;room
  EQUB 46,144 ;;;x,y
  EQUB 8,16 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PICK AXE
.proxpickaxe
  EQUB 41 ;;room
  EQUB 36,101 ;;;x,y
  EQUB 12,20 ;;;w,h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RUG TRICK
.proxrug
  EQUB 94 ;;room
  EQUB 34,152 ;;;x,y
  EQUB 4,16 ;;;w,h



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ODD MESSAGES

.youfoundcoinmess
  EQUB PRT_PEN+5,PRT_XY+16,64,PRT_DRAWBOX,12,5,PRT_PEN+3
  EQUB PRT_XY+22,88,"WELL:DONE@",PRT_PEN+6
  EQUB PRT_XY+23,96,"YOU:FOUND"
  EQUB PRT_XY+26,104,"A:COIN",PRT_END

.resetmoving
{
  LDA #lo(movingdata):STA zptr4
  LDA #hi(movingdata):STA zptr4+1

  LDX #&00
.loop

  LDY #origroom:LDA (zptr4), Y:LDY #room:STA (zptr4), Y
  LDY #origx:LDA (zptr4), Y:LDY #movex:STA (zptr4), Y
  LDY #origy:LDA (zptr4), Y:LDY #movey:STA (zptr4), Y
  LDY #origfrm:LDA (zptr4), Y:LDY #movefrm:STA (zptr4), Y

  LDA #&00
  LDY #var1:STA (zptr4), Y
  LDY #delaycounter:STA (zptr4), Y

  ; Advance to next object
  LDA zptr4:CLC:ADC #&10:STA zptr4
  BCC samepage
  INC zptr4+1
.samepage

  INX:CPX #noofmoving:BNE loop ; Loop until done

  RTS
}