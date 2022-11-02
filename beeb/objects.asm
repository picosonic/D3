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

OBJ_HAWK = 0

 EQUB 49, hawk, 60, 80, 97 
 EQUW nothingheremess
 EQUB 0, 2, 0, 0, 5+8+16, 49, 60, 80, 97

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_BAG = 1

 EQUB 55, pickupable, 48, 144, 1
 EQUW bagmess
 EQUB 0, 0, 0, 0, 2+64, 55, 48, 144, 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_PORTCULLIS = 2

.porthere
 EQUB 51,portcullis,76 ,136,120,96,136,   0   ,4  ,0 ,0 ,7   ,51 ,76 ,96,120

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_SWITCH = 3

 EQUB 51,portswitch,66 ,78 ,122,0   ,0   ,0   ,0  ,0 ,0 ,5+64,51 ,66 ,78 ,122

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_SHOPKEEPER = 4

.shopkeeperhere
 EQUB 22,pickupable,68 ,136,105
 EQUW                pigmycowmess,shoptalk
 EQUB                   0 ,0 ,7+64,255,68,136,105

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_SHOPKEEPER2 = 5

.shopkeeperhere1
 EQUB 22,crowbar,68+4,136,105
 EQUW                pigmycowmess,shoptalk
 EQUB                0 ,0 ,7+64+128,255,68+4,136,105

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_BLACKHOLE = 6

 EQUB 72,pickupable,62 ,144,11
 EQUW                blackholemess
 EQUB        0   ,0  ,0 ,0 ,7+64,72 ,62 ,144,11

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_MANURE = 7

.manurehere
 EQUB 58,pickupable,72 ,170,3
 EQUW                0 ;;;pickupmanuremess
 EQUB        0,   0,  0 ,0 ,2+64,58,72 ,170,3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_APPLE = 8

 EQUB 36,pickupable,58 ,136,17
 EQUW                applemess,proxapple
 EQUB                 0 ,0 ,4+64,255,58 ,136,17

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_BONE = 9

.bonehere
 EQUB 100,pickupable,52 ,160,6
 EQUW                           bonemess
 EQUB                                     0   ,0  ,0 ,0 ,7+64,100 ,52 ,160,6

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_BEAN = 10

.beanhere
 EQUB 22,pickupable,68 ,160,2
 EQUW                greenbeanmess,proxbean
 EQUB                 0 ,0 ,4+64,255 ,62 ,144,2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_GOLDENEGG = 11

.goldenegghere
 EQUB 93,pickupable,80 ,152,10
 EQUW                goldeneggmess,proxegg
 EQUB                 0 ,0 ,7+64,93 ,80 ,152,10

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_ROCK2 = 12

 EQUB 50,pickupable,86 ,160,138
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,2+64,50 ,86 ,160,138

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_ARMOROG = 13

.armoroghere
 EQUB 50,armorog   ,54 ,156,102,0   ,0   ,0   ,2  ,0 ,0 ,2+64+8,50 ,54 ,156,102

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DRAGON = 14

.dragonhere
 EQUB 54,dragon    ,68 ,152,109,0   ,0   ,0   ,0  ,0 ,0 ,2+64,54 ,68 ,152,109

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_SLEEPINGPOTION = 15

.sleepingpotionhere
 EQUB 45,pickupable,80 ,128,15
 EQUW                sleeppotionmess,proxsleep
 EQUB                 0 ,0 ,6+64,255,80 ,128,15

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_CROCODILE = 16

 EQUB 53,crocodile ,70 ,152,123,0   ,0   ,0   ,0  ,0 ,0 ,4+8,53 ,70 ,152,123

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_ROPE = 17

.ropehere
 EQUB 68,pickupable,76 ,160,14
 EQUW                ropemess,proxcroc
 EQUB                 0 ,0 ,7+64,255,76 ,160,14

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_ROCK3 = 18

 EQUB 35,pickupable,58 ,136,139
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,2+64,35 ,58,136,139

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_ROCK0 = 19

 EQUB 53,pickupable,90 ,144,136
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,2+64,53 ,90 ,144,136

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_WOOD = 20

 EQUB 48,log       ,60 ,136,158,0   ,0   ,0   ,4  ,0 ,0 ,2+8 ,48 ,60 ,136,158

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_WHISKEYBOTTLE = 21

.whiskeyhere
 EQUB 53,pickupable,50 ,136,18
 EQUW                fullwhiskeymess,emptybottlemess
 EQUB                 0 ,0 ,6+64,53 ,50 ,136,18

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_LIFT = 22

 EQUB 71,lift      ,52 ,56 ,125,56,112,   0   ,1  ,0 ,0 ,7+16,71 ,52,48 ,125

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_MACHINE = 23

 EQUB 56,machines  ,50 ,116,127 ,0   ,0   ,0   ,32 ,0 ,0 ,5+64 ,56,50 ,116,127

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_KEY = 24

 EQUB 85,pickupable,46 ,136,13
 EQUW                keymess,proxkey1
 EQUB                 0 ,0 ,6+64,85 ,46 ,136,13

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_LIFT2 = 25

 EQUB 40,lift      ,40 ,56 ,125,56,134,   0   ,1  ,0 ,0 ,7+16,40 ,40,56 ,125

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_MACHINE2 = 26

 EQUB 56,machines  ,72 ,116,127 ,0   ,0   ,0   ,32 ,0 ,0 ,5+64,56,72 ,116,127

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_KEY2 = 27

 EQUB 24,pickupable,80 ,136,13
 EQUW                keymess,proxkey2
 EQUB                 0 ,0 ,6+64,24 ,80 ,136,13

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_LIFT3 = 28

 EQUB 88,lift      ,58 ,56 ,125,56,136,   0   ,1  ,0 ,0 ,7+16,88 ,58,48 ,125

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_MACHINE3 = 29

 EQUB 56,machines  ,52 ,156,127 ,0   ,0   ,0   ,32 ,0 ,0 ,5+64,56,52 ,156 ,127

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_KEY3 = 30

 EQUB 60,pickupable,60 ,120,13
 EQUW                keymess,proxkey3
 EQUB                 0 ,0 ,6+64,60 ,60 ,120,13

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_LIFT4 = 31

 EQUB 56,lift      ,60 ,104 ,125,104,140,   0   ,1  ,0 ,0 ,7+16 ,56 ,60,104 ,125

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_MACHINE4 = 32

 EQUB 56,machines  ,70 ,156,127 ,0   ,0   ,0   ,32 ,0 ,0 ,5+64,56,70 ,156,127

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_KEY4 = 33

 EQUB 48,pickupable,40 ,96,13
 EQUW                keymess,proxkey4
 EQUB                 0 ,0 ,6+64,48 ,40 ,96,13

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_BUCKETEMPTY = 34

.buckethere
 EQUB 83,pickupable,80 ,144,5
 EQUW                mtbucketmess,proxmtbucket
 EQUB                 0 ,0 ,5+64,83,80 ,144,5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_BUCKETFULL = 35

 EQUB 60,pickupable,46 ,144,5
 EQUW                fullbucketmess,proxfullbucket
 EQUB                 0 ,0 ,5+64,255,46 ,144,5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_LEAF = 36

 EQUB 59,pickupable,52 ,102,206
 EQUW                leavesmess
 EQUB        0,   0,  0 ,0 ,4+64,59,52 ,102,206

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_COW = 37

 EQUB 58,pickupable,60 ,160,7
 EQUW                pigmycowmess
 EQUB        0,   0,  0 ,0 ,7+64,58,60 ,160,7

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_LEAF2 = 38

 EQUB 55,pickupable,58 ,136,206
 EQUW                leavesmess
 EQUB        0,   0,  0 ,0 ,4+64,55,58 ,136,206

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_RAILING = 39

 EQUB 55,pickupable,76 ,128,192
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,2+64,55,76 ,128,192

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DOZY = 40

.dozyhere
 EQUB 45,pickupable,74 ,116,32
 EQUW                dozyrou,dozytalking
 EQUB                   0 ,0 ,7+64,45,74 ,116,32

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DOZYFLOAT = 41

.dozyfloathere
 EQUB 45,dozyfloat,68 ,139,32,0  ,0  ,0   ,0,      0 ,0 ,7+64+16+8,45,68,139,32

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_JUGOFWATER = 42

 EQUB 36,pickupable,68 ,144,19
 EQUW                jugmess,proxjug
 EQUB                 0 ,0 ,5+64,36,68 ,144,19

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_BREAD = 43

.loafhere
 EQUB 36,pickupable,72 ,144,20
 EQUW                loafmess,proxloaf
 EQUB               0 ,0 ,6+64,36,72 ,144,20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_RAT = 44

.rathere
 EQUB 36,rat       ,42 ,73 ,104,44,80 ,   0   ,2  ,0 ,0 ,5+16+8,36,96,73 ,104

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_TROLL = 45

.trollhere
 EQUB 36,troll     ,78 ,136,96 ,44,80 ,   0   ,0  ,0 ,0 ,4+64 ,36,78,136 ,96

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DAGGER = 46

 EQUB 69,dagger    ,78 ,136,169 ,0 ,0 ,   0   ,0  ,0 ,0 ,7+64 ,69,40,112 ,169

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DOORKNOCKER = 47

 EQUB 89,pickupable,58 ,136,21
 EQUW            doorknockermess,proxdoor
 EQUB                 0 ,0 ,6+64,89,58 ,136,21

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_PLANK = 48

.doorhere
 EQUB 84,door    ,34 ,144,177 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2 ,84,34,144 ,177

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_GRANDDIZZY = 49

.doughere
 EQUB 88,pickupable,42 ,76,36
 EQUW                dougrou,dougtalking
 EQUB                   0 ,0 ,7+64,88,42,76,36

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DRAGON2 = 50

.dragonhere1
 EQUB 40,dragon    ,68 ,152,109,0   ,0   ,0   ,0  ,0 ,0 ,4+64,40 ,68 ,152,109

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_GOLDENEGG2 = 51

.goldenegghere1
 EQUB 40,pickupable,60 ,152,10
 EQUW                goldeneggmess
 EQUB        0   ,0  ,0 ,0 ,7+64,40 ,60,152,10

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_CROWBAR = 52

.crowbarhere
 EQUB 88,pickupable,48 ,80,4
 EQUW              crowbarmess,proxcrowbar
 EQUB                   0 ,0 ,5+64,255,48,80,4

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_WELLLID = 53

.welllidhere
 EQUB 55,crowbar  ,46 ,160,158 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2 ,55,46,160,158

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_PICKAXE = 54

 EQUB 87,pickupable,64 ,80,9
 EQUW              pickaxemess,proxpickaxe
 EQUB                   0 ,0 ,2+64,87,64,80,9

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_STONE2 = 55

.rockhere
 EQUB 41,crowbar  ,36 ,101,146 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2+8,41,36,101,146

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_TROLL2 = 56

 EQUB 41,miner     ,96 ,120,96 ,44,80 ,   0   ,0  ,0 ,0 ,4+64 ,41,96,120 ,96

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DAGGER2 = 57

 EQUB 94,dagger    ,42 ,152,169 ,0 ,0 ,   0   ,0  ,0 ,0 ,7+64 ,94,42,152,169

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DAGGER3 = 58

 EQUB 94,dagger    ,50 ,152,169 ,0 ,0 ,   0   ,0  ,0 ,0 ,7+64 ,94,50,152,169

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_RUG = 59

 EQUB 40,pickupable,52 ,112,12
 EQUW              rugmess,proxrug
 EQUB                   0 ,0 ,2+64,40,52,112,12

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_CARPET = 60

.carpethere
 EQUB 94,crowbar  ,40 ,152,210 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2,255,40,152,210

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_CARPET2 = 61

.carpethere1
 EQUB 94,crowbar  ,46 ,152,210 ,0 ,0 ,   0   ,0  ,0 ,0 ,  2,255,46,152,210

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_LIFT5 = 62

.daisylifthere
 EQUB 94,lift     ,74 ,56,125,56,120,   0   ,2  ,0 ,0  ,7  ,94 ,74,48,125

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DAISY = 63

.daisyhere
 EQUB 94,daisy   ,75 ,80,35,0  ,0  ,0   ,2   ,  0 ,0 ,7+64+16+8,94,75,80,35

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_SWITCH2 = 64

 EQUB 94,switch1 ,62 ,70,122,0   ,0   ,0   ,2  ,0 ,0 ,5+64+8,94 ,62 ,70 ,122

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DYLAN = 65

.dylanhere
 EQUB 59,pickupable,72 ,147,34
 EQUW                dylanrou,dylantalking
 EQUB                   0 ,0 ,7+64,59,72,147,34

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DENZIL = 66

.denzilhere
 EQUB 68,pickupable,80 ,155,33
 EQUW                denzilrou,denziltalking
 EQUB                   0 ,0 ,7+64,68,80,155,33

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_DAISY2 = 67

.daisy1here
 EQUB 73,daisy1,48 ,77,35,  0,0,0,2,   0 ,0 ,7+64,255,48,77,35

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_RAILING2 = 68

 EQUB 56,pickupable,84 ,128,192
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,2+64,56,84 ,128,192

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_RAILING3 = 69

 EQUB 72,pickupable,76 ,80,192
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,2+64,72,76 ,80,192

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_WINDOW = 70

 EQUB 73,pickupable,56 ,72,204
 EQUW                windowmess
 EQUB        0,   0,  0 ,0 ,4+64,73,56 ,72,204

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

OBJ_RAILING4 = 71

 EQUB 52,pickupable,86 ,88,192
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,7+64,52,86 ,88,192

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.endofmovingdata

noofmoving = (endofmovingdata-movingdata)/16


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

  LDA &00
  STA waterheight
  STA fireout
  STA ratcount
  STA dragonhere+oldmovex
  STA dragonhere1+oldmovex
  STA doorhere+oldmovex
  
  LDA #&FF
  ;STA shopkeepercount
  STA rathere+var1

  LDA #60
  STA rathere+oldmovefrm

  ;LDA fullwhiskeymess
  ;STA whiskeyhere+oldmovex

  LDA #&01
  ;STA ratcoll+1

  LDA #5+16+8
  STA rathere+colour

  LDY #&00:LDA #&00
.scrubtalkbefore
  STA talkbefore, Y
  INY
  CPY #&05:BNE scrubtalkbefore

  RTS
}

; Reset coins
.resetcoins
{
  LDA #&FF:STA coins

  ; More to do

  ; Fall through ...
}

.addtocoins
{
  INC coins

  ; Determine how many 10s
  LDX #0:LDA coins
.more10s
  CMP #11:BCC nomore10s
  SBC #10:INX
  JMP more10s
.nomore10s
  PHA:TXA:CLC:ADC #'0':STA noofcoinsmess

  ; Determine how many units
  LDX #0:PLA
.moreunits
  CMP #2:BCC nomoreunits
  SBC #1:INX
  JMP moreunits
.nomoreunits
  TXA:CLC:ADC #'0':STA noofcoinsmess+1

  ; Draw the full coins message
  LDA #hi(coinsmess):STA zptr5+1
  LDA #lo(coinsmess):STA zptr5
  JMP prtmessage

.coinsmess EQUB PRT_PEN+4, PRT_XY+46,8
.noofcoinsmess EQUB 0, 0, PRT_END
}

.subfromlives
{
  ; Subtract 1 from lives
  DEC lives

  ; Inject lives number into number of lives messages, using repeat count
  LDA lives:STA nooflivesmess+1

  ; Print number of lives (as eggs)
  LDA #hi(livesmess):STA zptr5+1
  LDA #lo(livesmess):STA zptr5

  JMP prtmessage

.livesmess EQUB PRT_PEN+4, PRT_XY+14,8, ":::", PRT_XY+14,8
.nooflivesmess EQUB PRT_REP, 1, "/", PRT_ENDREP, PRT_END
}