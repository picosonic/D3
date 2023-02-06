; Moving stuff

; Offsets into 16-byte objects array (now 12-byte)
room = 0 ; Room that this object is currently in
rou = 1 ; Routine index which specifies what to run for this object
movex = 2 ; Current X position
movey = 3 ; Current Y position
movefrm = 4 ; Current sprite/frame id
oldmovex = 5
oldmovey = 6
oldmovefrm = 7
delay = 8 ; If non-zero, is the number of steps to delay for
delaycounter = 9 ; Counts from 0 to delay, then resets to 0
var1 = 10
colour = 11 ; Colour for whole object when drawn
;origroom = 12
;origx = 13
;origy = 14
;origfrm = 15

; Size of each object in bytes
movingsize = 12

; Null room - off the map (don't draw)
OFFMAP = 255

; Routine index values
portcullis = 0
portswitch = 1
pickupable = 2 ; An object which can be picked up
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

; The number of routines defined
roucount = 20

;colour byte     7   6   5     4   3   2   1   0
;               rev:dull:atplot:plot: colour

; All the moving things are defined here and stored in a file
;   on the Beeb. When we want to reset them, we re-load this file
;   over the top. The equivalent of resetmoving().
.movingdata

; room, rou, x, y, frm, oldx, oldy, ofrm, dly, v1, v2, col
;   orm, orx, ory, ofrm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE GUARD HOUSE
OBJ_HAWK = 0

 EQUB 49, hawk, 60, 80, SPR_HAWK0 
 EQUW nothingheremess
 EQUB 0, 2, 0, 0, PAL_CYAN+PLOT_NULL
 ;EQUB 49, 60, 80, SPR_HAWK0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BOTTOMLESS WELL
OBJ_BAG = 1

 EQUB 55, pickupable, 48, 144, SPR_BAG
 EQUW bagmess
 EQUB 0, 0, 0, 0, PAL_RED+ATTR_NOTSOLID
 ;EQUB 55, 48, 144, SPR_BAG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MOAT AND PORTCULLIS
OBJ_PORTCULLIS = 2

.porthere
 EQUB 51,portcullis,76 ,96,SPR_PORTCULLIS,96,136,   0   ,4  ,0 ,0 ,PAL_WHITE
 ;EQUB 51 ,76 ,96,SPR_PORTCULLIS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MOAT AND PORTCULLIS
OBJ_SWITCH = 3

 EQUB 51,portswitch,66 ,78 ,SPR_SWITCH,0   ,0   ,0   ,0  ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB 51 ,66 ,78 ,SPR_SWITCH

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE MARKET SQUARE
OBJ_SHOPKEEPER = 4

.shopkeeperhere
 EQUB OFFMAP,pickupable,68 ,136,SPR_SHOPKEEPER
 EQUW                pigmycowmess,shoptalk
 EQUB                   0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB OFFMAP,68,136,SPR_SHOPKEEPER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE MARKET SQUARE
OBJ_SHOPKEEPER2 = 5

.shopkeeperhere1
 EQUB OFFMAP,crowbar,68+4,136,SPR_SHOPKEEPER
 EQUW                pigmycowmess,shoptalk
 EQUB                0 ,0 ,PAL_WHITE+ATTR_NOTSOLID+ATTR_REVERSE
 ;EQUB OFFMAP,68+4,136,SPR_SHOPKEEPER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DENZIL'S PAD
OBJ_BLACKHOLE = 6

 EQUB 72,pickupable,62 ,144,SPR_BLACKHOLE
 EQUW                blackholemess
 EQUB        0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 72 ,62 ,144,SPR_BLACKHOLE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SMELLY ALLOTMENT
OBJ_MANURE = 7

.manurehere
 EQUB 58,pickupable,72 ,170,SPR_MANURE
 EQUW                0 ;;;pickupmanuremess
 EQUB        0,   0,  0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 58,72 ,170,SPR_MANURE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This item starts in your inventory
OBJ_APPLE = 8

 EQUB OFFMAP,pickupable,58 ,136,SPR_APPLE
 EQUW                applemess,proxapple
 EQUB                 0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB OFFMAP,58 ,136,SPR_APPLE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE ATTIC
OBJ_BONE = 9

.bonehere
 EQUB 100,pickupable,52 ,160,SPR_BONE
 EQUW                           bonemess
 EQUB                                     0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 100 ,52 ,160,SPR_BONE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This item is given to you by the shopkeeper
OBJ_BEAN = 10

.beanhere
 EQUB OFFMAP,pickupable,62 ,144,SPR_BEAN
 EQUW                greenbeanmess,proxbean
 EQUB                 0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB OFFMAP ,62 ,144,SPR_BEAN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CLOUD CASTLE
OBJ_GOLDENEGG = 11

.goldenegghere
 EQUB 93,pickupable,80 ,152,SPR_GOLDENEGG
 EQUW                goldeneggmess,proxegg
 EQUB                 0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 93 ,80 ,152,SPR_GOLDENEGG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ARMOROG'S DEN
OBJ_ROCK2 = 12

 EQUB 50,pickupable,86 ,160,SPR_SMALLSTONE2
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 50 ,86 ,160,SPR_SMALLSTONE2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ARMOROG'S DEN
OBJ_ARMOROG = 13

.armoroghere
 EQUB 50,armorog   ,54 ,156,SPR_GRUNT0,0   ,0   ,0   ,2  ,0 ,0 ,PAL_RED+ATTR_NOTSOLID+PLOT_OR
 ;EQUB 50 ,54 ,156,SPR_GRUNT0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE WIDE-EYED DRAGON
OBJ_DRAGON = 14

.dragonhere
 EQUB 54,dragon    ,68 ,152,SPR_DRAGONHEADCLOSED,0   ,0   ,0   ,0  ,0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 54 ,68 ,152,SPR_DRAGONHEADCLOSED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This item is given to you by Dozy
OBJ_SLEEPINGPOTION = 15

.sleepingpotionhere
 EQUB OFFMAP,pickupable,80 ,128,SPR_SLEEPINGPOTION
 EQUW                sleeppotionmess,proxsleep
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB OFFMAP,80 ,128,SPR_SLEEPINGPOTION

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SNAP HAPPY GATOR
OBJ_CROCODILE = 16

 EQUB 53,crocodile ,70 ,152,SPR_CROCCLOSED,0   ,0   ,0   ,0  ,0 ,0 ,PAL_GREEN+PLOT_OR
 ;EQUB 53 ,70 ,152,SPR_CROCCLOSED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This item is given to you by Denzil
OBJ_ROPE = 17

.ropehere
 EQUB OFFMAP,pickupable,76 ,160,SPR_ROPE
 EQUW                ropemess,proxcroc
 EQUB                 0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB OFFMAP,76 ,160,SPR_ROPE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; SMUGGLER'S HIDEOUT
OBJ_ROCK3 = 18

 EQUB 35,pickupable,58 ,136,SPR_SMALLSTONE3
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 35 ,58,136,SPR_SMALLSTONE3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SNAP HAPPY GATOR
OBJ_ROCK0 = 19

 EQUB 53,pickupable,90 ,144,SPR_SMALLSTONE0
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 53 ,90 ,144,SPR_SMALLSTONE0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BROKEN BRIDGE
OBJ_WOOD = 20

 EQUB 48,log       ,60 ,136,SPR_WOOD0,0   ,0   ,0   ,4  ,0 ,0 ,PAL_RED+PLOT_OR
 ;EQUB 48 ,60 ,136,SPR_WOOD0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SNAP HAPPY GATOR
OBJ_WHISKEYBOTTLE = 21

.whiskeyhere
 EQUB 53,pickupable,50 ,136,SPR_BRANDYBOTTLE
 EQUW                fullwhiskeymess,emptybottlemess
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB 53 ,50 ,136,SPR_BRANDYBOTTLE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; KEEP OUT! DOZY'S HUT
OBJ_LIFT = 22

 EQUB 71,lift      ,52 ,48 ,SPR_LIFTTOP,56,112,   0   ,1  ,0 ,0 ,PAL_WHITE+PLOT_XOR
 ;EQUB 71 ,52,48 ,SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_MACHINE = 23

 EQUB 56,machines  ,50 ,116,SPR_MACHINE ,0   ,0   ,0   ,32 ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB 56,50 ,116,SPR_MACHINE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE EAST TOWER
OBJ_KEY = 24

 EQUB 85,pickupable,46 ,136,SPR_KEY
 EQUW                keymess,proxkey1
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB 85 ,46 ,136,SPR_KEY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DRAGON'S LAIR
OBJ_LIFT2 = 25

 EQUB 40,lift      ,40 ,56 ,SPR_LIFTTOP,56,134,   0   ,1  ,0 ,0 ,PAL_WHITE+PLOT_XOR
 ;EQUB 40 ,40,56 ,SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_MACHINE2 = 26

 EQUB 56,machines  ,72 ,116,SPR_MACHINE ,0   ,0   ,0   ,32 ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB 56,72 ,116,SPR_MACHINE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSIDE THE CHURCH
OBJ_KEY2 = 27

 EQUB 24,pickupable,80 ,136,SPR_KEY
 EQUW                keymess,proxkey2
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB 24 ,80 ,136,SPR_KEY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIFT TO THE ELDERS
OBJ_LIFT3 = 28

 EQUB 88,lift      ,58 ,48 ,SPR_LIFTTOP,56,136,   0   ,1  ,0 ,0 ,PAL_WHITE+PLOT_XOR
 ;EQUB 88 ,58,48 ,SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_MACHINE3 = 29

 EQUB 56,machines  ,52 ,156,SPR_MACHINE ,0   ,0   ,0   ,32 ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB 56,52 ,156 ,SPR_MACHINE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; BASE OF THE VOLCANO
OBJ_KEY3 = 30

 EQUB 60,pickupable,60 ,120,SPR_KEY
 EQUW                keymess,proxkey3
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB 60 ,60 ,120,SPR_KEY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_LIFT4 = 31

 EQUB 56,lift      ,60 ,104 ,SPR_LIFTTOP,104,140,   0   ,1  ,0 ,0 ,PAL_WHITE+PLOT_XOR
 ;EQUB 56 ,60,104 ,SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_MACHINE4 = 32

 EQUB 56,machines  ,70 ,156,SPR_MACHINE ,0   ,0   ,0   ,32 ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB 56,70 ,156,SPR_MACHINE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BROKEN BRIDGE
OBJ_KEY4 = 33

 EQUB 48,pickupable,40 ,96,SPR_KEY
 EQUW                keymess,proxkey4
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB 48 ,40 ,96,SPR_KEY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE WEST TOWER
OBJ_BUCKETEMPTY = 34

.buckethere
 EQUB 83,pickupable,80 ,144,SPR_BUCKET
 EQUW                mtbucketmess,proxmtbucket
 EQUB                 0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB 83,80 ,144,SPR_BUCKET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This replaces the empty bucket when filled at base of volcano
OBJ_BUCKETFULL = 35

 EQUB OFFMAP,pickupable,46 ,144,SPR_BUCKET
 EQUW                fullbucketmess,proxfullbucket
 EQUB                 0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB OFFMAP,46 ,144,SPR_BUCKET

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LARGE OAK TREE
OBJ_LEAF = 36

 EQUB 59,pickupable,52 ,102,SPR_LEAFYBIT1
 EQUW                leavesmess
 EQUB        0,   0,  0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB 59,52 ,102,SPR_LEAFYBIT1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SMELLY ALLOTMENT
OBJ_COW = 37

 EQUB 58,pickupable,60 ,160,SPR_COW
 EQUW                pigmycowmess
 EQUB        0,   0,  0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 58,60 ,160,SPR_COW

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BOTTOMLESS WELL
OBJ_LEAF2 = 38

 EQUB 55,pickupable,58 ,136,SPR_LEAFYBIT1
 EQUW                leavesmess
 EQUB        0,   0,  0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB 55,58 ,136,SPR_LEAFYBIT1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BOTTOMLESS WELL
OBJ_RAILING = 39

 EQUB 55,pickupable,76 ,128,SPR_WOODENRAIL
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 55,76 ,128,SPR_WOODENRAIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LOOKING OUT TO SEA
OBJ_DOZY = 40

.dozyhere
 EQUB 45,pickupable,74 ,116,SPR_DOZY
 EQUW                dozyrou,dozytalking
 EQUB                   0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 45,74 ,116,SPR_DOZY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LOOKING OUT TO SEA
OBJ_DOZYFLOAT = 41

.dozyfloathere
 EQUB 45,dozyfloat,68 ,139,SPR_DOZY,0  ,0  ,0   ,0,      0 ,0 ,PAL_WHITE+ATTR_NOTSOLID+PLOT_NULL
 ;EQUB 45,68,139,SPR_DOZY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE'S DUNGEON
OBJ_JUGOFWATER = 42

 EQUB 36,pickupable,68 ,144,SPR_JUGOFWATER
 EQUW                jugmess,proxjug
 EQUB                 0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB 36,68 ,144,SPR_JUGOFWATER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE'S DUNGEON
OBJ_BREAD = 43

.loafhere
 EQUB 36,pickupable,72 ,144,SPR_BREAD
 EQUW                loafmess,proxloaf
 EQUB               0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB 36,72 ,144,SPR_BREAD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE'S DUNGEON
OBJ_RAT = 44

.rathere
 EQUB 36,rat       ,96 ,73 ,SPR_RAT,44,80 ,   60   ,2  ,0 ,255 ,PAL_CYAN+PLOT_NULL
 ;EQUB 36,96,73 ,SPR_RAT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE'S DUNGEON
OBJ_TROLL = 45

.trollhere
 EQUB 36,troll     ,78 ,136,SPR_TROLL ,44,80 ,   0   ,0  ,0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB 36,78,136 ,SPR_TROLL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE EAST WING
OBJ_DAGGER = 46

 EQUB 69,dagger    ,40 ,112,SPR_DAGGERBLADE ,0 ,0 ,   0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 69,40,112 ,SPR_DAGGERBLADE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DIZZY'S PARENTS HUT
OBJ_DOORKNOCKER = 47

 EQUB 89,pickupable,58 ,136,SPR_DOORKNOCKER
 EQUW            doorknockermess,proxdoor
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB 89,58 ,136,SPR_DOORKNOCKER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE STAIRCASE
OBJ_PLANK = 48

.doorhere
 EQUB 84,door    ,34 ,144,SPR_PLANKOFWOOD ,0 ,0 ,   0   ,0  ,0 ,0 ,  PAL_RED
 ;EQUB 84,34,144 ,SPR_PLANKOFWOOD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIFT TO THE ELDERS
OBJ_GRANDDIZZY = 49

.doughere
 EQUB 88,pickupable,42 ,76,SPR_GRANDDIZZY
 EQUW                dougrou,dougtalking
 EQUB                   0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 88,42,76,SPR_GRANDDIZZY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DRAGON'S LAIR
OBJ_DRAGON2 = 50

.dragonhere1
 EQUB 40,dragon    ,68 ,152,SPR_DRAGONHEADCLOSED,0   ,0   ,0   ,0  ,0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB 40 ,68 ,152,SPR_DRAGONHEADCLOSED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DRAGON'S LAIR
OBJ_GOLDENEGG2 = 51

.goldenegghere1
 EQUB 40,pickupable,60 ,152,SPR_GOLDENEGG
 EQUW                goldeneggmess
 EQUB        0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 40 ,60,152,SPR_GOLDENEGG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This item is given to you by Doug
OBJ_CROWBAR = 52

.crowbarhere
 EQUB OFFMAP,pickupable,48 ,80,SPR_CROWBAR
 EQUW              crowbarmess,proxcrowbar
 EQUB                   0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB OFFMAP,48,80,SPR_CROWBAR

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BOTTOMLESS WELL
OBJ_WELLLID = 53

.welllidhere
 EQUB 55,crowbar  ,46 ,160,SPR_WOOD0 ,0 ,0 ,   0   ,0  ,0 ,0 ,  PAL_RED
 ;EQUB 55,46,160,SPR_WOOD0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE MEETING HALL
OBJ_PICKAXE = 54

 EQUB 87,pickupable,64 ,80,SPR_PICKAXE
 EQUW              pickaxemess,proxpickaxe
 EQUB                   0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 87,64,80,SPR_PICKAXE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DESERTED MINES
OBJ_STONE2 = 55

.rockhere
 EQUB 41,crowbar  ,36 ,101,SPR_LARGESTONE2 ,0 ,0 ,   0   ,0  ,0 ,0 ,  PAL_RED+PLOT_OR
 ;EQUB 41,36,101,SPR_LARGESTONE2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DESERTED MINES
OBJ_TROLL2 = 56

 EQUB 41,miner     ,96 ,120,SPR_TROLL ,44,80 ,   0   ,0  ,0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB 41,96,120 ,SPR_TROLL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_DAGGER2 = 57

 EQUB 94,dagger    ,42 ,152,SPR_DAGGERBLADE ,0 ,0 ,   0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 94,42,152,SPR_DAGGERBLADE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_DAGGER3 = 58

 EQUB 94,dagger    ,50 ,152,SPR_DAGGERBLADE ,0 ,0 ,   0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 94,50,152,SPR_DAGGERBLADE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DRAGON'S LAIR
OBJ_RUG = 59

 EQUB 40,pickupable,52 ,112,SPR_THICKRUG
 EQUW              rugmess,proxrug
 EQUB                   0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 40,52,112,SPR_THICKRUG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
; This is only shown when rug is used on daggers
OBJ_CARPET = 60

.carpethere
 EQUB OFFMAP,crowbar  ,40 ,152,SPR_GROUND ,0 ,0 ,   0   ,0  ,0 ,0 ,  PAL_RED
 ;EQUB OFFMAP,40,152,SPR_GROUND

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
; This is only shown when rug is used on daggers
OBJ_CARPET2 = 61

.carpethere1
 EQUB OFFMAP,crowbar  ,46 ,152,SPR_GROUND ,0 ,0 ,   0   ,0  ,0 ,0 ,  PAL_RED
 ;EQUB OFFMAP,46,152,SPR_GROUND

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_LIFT5 = 62

.daisylifthere
 EQUB 94,lift     ,74 ,48,SPR_LIFTTOP,56,120,   0   ,2  ,0 ,0  ,PAL_WHITE
 ;EQUB 94 ,74,48,SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_DAISY = 63

.daisyhere
 EQUB 94,daisy   ,75 ,80,SPR_DAISY,0  ,0  ,0   ,2   ,  0 ,0 ,PAL_WHITE+ATTR_NOTSOLID+PLOT_NULL
 ;EQUB 94,75,80,SPR_DAISY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_SWITCH2 = 64

 EQUB 94,switch1 ,62 ,70,SPR_SWITCH,0   ,0   ,0   ,2  ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID+PLOT_OR
 ;EQUB 94 ,62 ,70 ,SPR_SWITCH

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LARGE OAK TREE
OBJ_DYLAN = 65

.dylanhere
 EQUB 59,pickupable,72 ,147,SPR_DYLAN
 EQUW                dylanrou,dylantalking
 EQUB                   0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 59,72,147,SPR_DYLAN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BANQUET HALL
OBJ_DENZIL = 66

.denzilhere
 EQUB 68,pickupable,80 ,155,SPR_DENZIL
 EQUW                denzilrou,denziltalking
 EQUB                   0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 68,80,155,SPR_DENZIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Appears at DAISY'S EMPTY HUT, following rescue
OBJ_DAISY2 = 67

.daisy1here
 EQUB OFFMAP,daisy1,48 ,77,SPR_DAISY,  0,0,0,2,   0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB OFFMAP,48,77,SPR_DAISY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_RAILING2 = 68

 EQUB 56,pickupable,84 ,128,SPR_WOODENRAIL
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 56,84 ,128,SPR_WOODENRAIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DENZIL'S PAD
OBJ_RAILING3 = 69

 EQUB 72,pickupable,76 ,80,SPR_WOODENRAIL
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB 72,76 ,80,SPR_WOODENRAIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S EMPTY HUT
OBJ_WINDOW = 70

 EQUB 73,pickupable,56 ,72,SPR_WINDOW
 EQUW                windowmess
 EQUB        0,   0,  0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB 73,56 ,72,SPR_WINDOW

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE ENTRANCE HALL
OBJ_RAILING4 = 71

 EQUB 52,pickupable,86 ,88,SPR_WOODENRAIL
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB 52,86 ,88,SPR_WOODENRAIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.endofmovingdata

noofmoving = (endofmovingdata-movingdata)/movingsize

; Reset moving items state
.resetrous
  EQUW resetportcullis
  EQUW resetportswitch
  EQUW resetpickupable
  EQUW resetarmorog
  EQUW resetdragon
  EQUW resetcrocodile
  EQUW resetlog
  EQUW resethawk
  EQUW resetmachines
  EQUW resetlift
  EQUW resetdozyfloat
  EQUW resetrat
  EQUW resettroll
  EQUW resetdagger
  EQUW resetdoor
  EQUW printmoving  ;;;resetcrowbar
  EQUW resetminer
  EQUW resetdaisy
  EQUW resetswitch1
  EQUW resetdaisy1

; Moving items routines
.movingrous
  EQUW portcullisrou
  EQUW portswitchrou
  EQUW pickupablerou
  EQUW armorogrou
  EQUW dragonrou
  EQUW crocodilerou
  EQUW logrou
  EQUW hawkrou
  EQUW machinesrou
  EQUW liftrou
  EQUW dozyfloatrou
  EQUW ratrou
  EQUW trollrou
  EQUW daggerrou
  EQUW doorrou
  EQUW rethere            ;;crowbarrou
  EQUW minerrou
  EQUW daisyrou
  EQUW switchrou1
  EQUW daisyrou1

;; TEMPORARY - Placeholder empty routines
.resetportswitch
.resetpickupable
.resetarmorog
.resetdragon
.resetcrocodile
.resetlog
.resethawk
.resetmachines
.resetlift
.resetdozyfloat
.resetrat
.resettroll
.resetdagger
.resetdoor
.resetminer
.resetdaisy
.resetswitch1
.resetdaisy1

.portswitchrou
.pickupablerou
.armorogrou
.dragonrou
.crocodilerou
.logrou
.hawkrou
.machinesrou
.liftrou
.dozyfloatrou
.ratrou
.trollrou
.daggerrou
.doorrou
.rethere
.minerrou
.daisyrou
.switchrou1
.daisyrou1
  RTS
;;

.printmoving
{
  LDY #movefrm:LDA (zptr4), Y:STA frmno
  LDY #movex:LDA (zptr4), Y:STA frmx
  LDY #movey:LDA (zptr4), Y:STA frmy
  LDY #colour:LDA (zptr4), Y:AND %01000111:STA frmattri

  JSR frame

  RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PORTCULLIS HERE
.resetportcullis
{
  LDY #var1:LDA (zptr4), Y
  BNE resetrope1
.resetrope
  LDA #&00:STA (zptr4), Y
  LDY #oldmovey:LDA (zptr4), Y
  LDY #movey:STA (zptr4), Y
.resetrope1
  LDA #96:STA ztmp7 ; portcullis.origy
  LDY #movey:LDA (zptr4), Y
  DEC ztmp7:DEC ztmp7
  LDA ztmp7:STA (zptr4), Y
.drawropedownlp
  INC ztmp7:INC ztmp7
  LDA ztmp7:STA (zptr4), Y
  JSR printmoving
  LDY #movey:LDA (zptr4), Y
  CMP ztmp7
  BNE drawropedownlp
  RTS
}

.portcullisrou
{
  RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

shoptalk = beanhere+room
dozytalking = sleepingpotionhere+room
denziltalking = ropehere+room
dougtalking = crowbarhere+room
duffmem = 0
dylantalking = duffmem

.nothingheremess EQUB PRT_END ; Used to print nothing (e.g. empty inventory slot)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;TALKING TO YOLKFOLK

.chatter
{
  LDA #&01:STA dontupdatedizzy ; Stop Dizzy being drawn
  JSR printandwait ; Print message and wait for user input to move on

  LDA (zptr5), Y ; If next character to print is not END then show next message
  CMP #PRT_END:BNE chatter

  JMP windowrou1 ; Draw room again and allow dizzy to be drawn
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DOZYROU
.dozyrou
  ; TODO - more to add
  LDA #OFFMAP:STA dozyhere+room
  STA dozyfloathere+var1

  LDA #STR_pushdozymess:JSR findroomstr
  JMP windowrou

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DOUG ROU
.dougrou
  LDA #STR_goonmysonmess:JSR findroomstr
  JMP windowrou

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DYLAN ROU
.dylanrou
  LDA #STR_trancemess:JSR findroomstr
  JMP windowrou

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DENZIL ROU
.denzilrou
  LDA #STR_stereoess:JSR findroomstr
  JMP windowrou

;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Proximity locations, when dropping things, to know how to interact
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.domoving
{
  LDA #lo(movingdata):STA zptr4
  LDA #hi(movingdata):STA zptr4+1

  LDX #&00
.domovinglp
  STX slotno ; Cache object slot incase it gets picked up

  ; Check we are in the right room for this object
  LDY #room:LDA (zptr4), Y:CMP roomno:BNE notinthisroom

  LDY #rou:LDA (zptr4), Y ; Get routine id for this object
  CMP #pickupable:BEQ skipdelay
  ; If it's not pickupable, limit how often we run routine
  JSR delayrou
  BNE notinthisroom ; Check for delaycounter being zero, otherwise move on
.skipdelay

  LDA #lo(movingrous):STA zptr5
  LDA #hi(movingrous):STA zptr5+1
  JSR jumptoroutine

.notinthisroom

  ; Advance to next object
  LDA zptr4:CLC:ADC #movingsize:STA zptr4
  BCC samepage
  INC zptr4+1
.samepage

  INX:CPX #noofmoving:BNE domovinglp ; Loop until done

.done
  RTS
}

; If delay value set, advance delaycounter until it matches delay
; When a match occurs reset delaycounter to zero
.delayrou
{
  ; See if delay is needed
  LDY #delay:LDA (zptr4), Y
  BEQ done

  STA ztmp7 ; Store delay

  ; Advance delaycounter
  LDY #delaycounter:LDA (zptr4), Y
  CLC:ADC #&01:STA (zptr4), Y

  ; Compare delaycounter to delay
  CMP ztmp7:BNE done ; If different, return

  ; Reset counter, setting Z flag so that routine is run
  LDA #&00:LDY #delaycounter:STA (zptr4), Y

.done

  RTS
}

; Look up object[n] (zptr4) to get
;   x=movex, y=movey
;
; Look up object[n].movefrm to get
;   w, h
.collidewithdizzy16
{
  LDY movex:LDA (zptr4), Y:STA cx
  LDY movey:LDA (zptr4), Y:STA cy

  ; Get offset to frame data
  LDA #hi(frametable):STA zptr2+1
  LDA #lo(frametable):STA zptr2

  LDY movefrm:LDA (zptr4), Y
  BPL nochange
  INC zptr2+1
.nochange
  ASL A:TAY ; Y = A * 2

  ; Get high byte of offset
  INY:LDA (zptr2), Y
  CMP #&FF:BNE notempty
  LDA #&00:STA cw:STA ch ; NULL frame
  RTS
.notempty
  CLC:ADC #hi(framedefs):STA zptr1+1

  ; Get low byte of offset
  DEY:LDA (zptr2), Y
  CLC:ADC #lo(framedefs):STA zptr1
  BCC samepage
  INC zptr1+1
.samepage

  ; Get (width/4)
  LDY #&00:LDA (zptr1), Y:STA cw

  ; Get height
  INY:LDA (zptr1), Y:STA ch

  JMP collidewithdizzy3
}
