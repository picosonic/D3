; Moving stuff

; Offsets into 16-byte objects array (now 12-byte)
room = 0 ; Room that this object is currently in
rou = 1 ; Routine index which specifies what to run for this object
movex = 2 ; Current X position
movey = 3 ; Current Y position
movefrm = 4 ; Current sprite/frame id
oldmovex = 5
oldmovey = 6
oldmovefrm = 7 ; / proximity low
delay = 8 ; If non-zero, is the number of steps to delay for / proximity high
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
portcullis =  0 ; Raising/lowering animation, with death
portswitch =  1 ; Starting portcullis
pickupable =  2 ; An object which can be picked up
armorog    =  3 ; Alertness trigger, charging, sleeping, eating bone
dragon     =  4 ; Head raise/lower animation, breathing flame, calmed by sleeping potion or egg
crocodile  =  5 ; Snapping animation, plus being tied by rope
log        =  6 ; Floating log, height dependant on water raised by stones
hawk       =  7 ; Patrolling and diving
machines   =  8 ; Unlock by key to start associated lift
lift       =  9 ; Lift mechanism
dozyfloat  = 10 ; Dozy float animation when pushed into water
rat        = 11 ; Random patrolling and eating loaf
troll      = 12 ; Troll when in dungeon
dagger     = 13 ; In prison and castle pit
door       = 14 ; In castle to west tower
crowbar    = 15 ; Does nothing - used on shopkeeper / well lid / large rock in mine / carpet in prison
miner      = 16 ; Troll when in mine
daisy      = 17 ; Daisy in prison
switch1    = 18 ; Daisy prison lift switch
daisy1     = 19 ; Daisy at hut

; The number of routines defined
roucount = 20

; For empty inventory slot
OBJ_EMPTY = 0

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

 EQUB GUARDHOUSEROOM, hawk, 60, 80, SPR_HAWK0
 EQUW nothingheremess
 EQUB 0, 2, HAWK_FLYING, 0, PAL_CYAN+PLOT_OR+ATTR_NOTSOLID
 ;EQUB GUARDHOUSEROOM, 60, 80, SPR_HAWK0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BOTTOMLESS WELL
OBJ_BAG = 1

 EQUB TOPWELLROOM, pickupable, 48, 144, SPR_BAG
 EQUW bagmess
 EQUB 0, 0, 0, 0, PAL_RED+ATTR_NOTSOLID
 ;EQUB TOPWELLROOM, 48, 144, SPR_BAG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MOAT AND PORTCULLIS
OBJ_PORTCULLIS = 2

.porthere
 EQUB MOATROOM, portcullis, 76 ,96, SPR_PORTCULLIS
 EQUB 96,136,   0   ,4  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID ; TODO - align not solid with original
 ;EQUB MOATROOM, 76, 96, SPR_PORTCULLIS

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MOAT AND PORTCULLIS
OBJ_SWITCH = 3

.portswitchhere
 EQUB MOATROOM, portswitch, 66 ,78, SPR_SWITCH
 EQUB 0, 0, 0, 0, 0, 0, PAL_CYAN+ATTR_NOTSOLID
 ;EQUB MOATROOM, 66, 78, SPR_SWITCH

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE MARKET SQUARE
OBJ_SHOPKEEPER = 4

.shopkeeperhere
 EQUB OFFMAP,pickupable,68 ,136,SPR_SHOPKEEPER
 EQUW                pigmycowmess,shoptalk
 EQUB                STR_thanksforthecowmess ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB OFFMAP,68,136,SPR_SHOPKEEPER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE MARKET SQUARE
OBJ_SHOPKEEPER2 = 5

.shopkeeperhere1
 EQUB OFFMAP,crowbar,68+4,136,SPR_SHOPKEEPER
 EQUW                pigmycowmess,shoptalk
 EQUB                STR_thanksforthecowmess ,0 ,PAL_WHITE+ATTR_NOTSOLID+ATTR_REVERSE
 ;EQUB OFFMAP,68+4,136,SPR_SHOPKEEPER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DENZIL'S PAD
OBJ_BLACKHOLE = 6

 EQUB DENZILSPADROOM, pickupable, 62, 144, SPR_BLACKHOLE
 EQUW                blackholemess
 EQUB        0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB DENZILSPADROOM, 62, 144, SPR_BLACKHOLE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SMELLY ALLOTMENT
OBJ_MANURE = 7

.manurehere
 EQUB ALLOTMENTROOM, pickupable,72 ,170,SPR_MANURE
 EQUW                0 ;;;pickupmanuremess
 EQUB        0,   0,  MANURE_IDLE ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB ALLOTMENTROOM, 72 ,170,SPR_MANURE

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
 EQUB ATTICROOM, pickupable, 52, 160, SPR_BONE
 EQUW                           bonemess
 EQUB                                     0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB ATTICROOM, 52, 160, SPR_BONE

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
 EQUB CLOUDCASTLE, pickupable, 80, 152, SPR_GOLDENEGG
 EQUW                goldeneggmess,proxegg
 EQUB                 0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB CLOUDCASTLE, 80, 152, SPR_GOLDENEGG

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ARMOROG'S DEN
OBJ_ROCK2 = 12

 EQUB ARMOROGROOM, pickupable, 86, 160, SPR_SMALLSTONE2
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB ARMOROGROOM, 86, 160, SPR_SMALLSTONE2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ARMOROG'S DEN
OBJ_ARMOROG = 13

.armoroghere
 EQUB ARMOROGROOM, armorog   ,54 ,156,SPR_GRUNT0,0   ,0   ,0   ,2  ,ARMOROG_SLEEPING ,0 ,PAL_RED+ATTR_NOTSOLID+PLOT_OR
 ;EQUB ARMOROGROOM, 54, 156, SPR_GRUNT0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE WIDE-EYED DRAGON
OBJ_DRAGON = 14

.dragonhere
 EQUB WIDEEYEDDRAGONROOM, dragon    ,68 ,152,SPR_DRAGONHEADCLOSED,0   ,0   ,0   ,0  ,0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB WIDEEYEDDRAGONROOM, 68 ,152,SPR_DRAGONHEADCLOSED

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

.crochere
 EQUB GATORROOM, crocodile ,70 ,152,SPR_CROCCLOSED,0   ,0   ,0   ,0  ,0 ,0 ,PAL_GREEN+PLOT_OR
 ;EQUB GATORROOM, 70, 152, SPR_CROCCLOSED

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

 EQUB SMUGGLERSROOM, pickupable, 58, 136, SPR_SMALLSTONE3
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB SMUGGLERSROOM, 58, 136, SPR_SMALLSTONE3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SNAP HAPPY GATOR
OBJ_ROCK0 = 19

 EQUB GATORROOM, pickupable, 90, 144, SPR_SMALLSTONE0
 EQUW                rockmess,proxrock
 EQUB                 0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB GATORROOM, 90, 144, SPR_SMALLSTONE0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BROKEN BRIDGE
OBJ_WOOD = 20

 EQUB BROKENBRIDGEROOM, log       ,60 ,136,SPR_WOOD0,0   ,0   ,0   ,4  ,0 ,0 ,PAL_RED+PLOT_OR
 ;EQUB BROKENBRIDGEROOM, 60 ,136,SPR_WOOD0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SNAP HAPPY GATOR
OBJ_WHISKEYBOTTLE = 21

.whiskeyhere
 EQUB GATORROOM, pickupable, 50, 136, SPR_BRANDYBOTTLE
 EQUW                fullwhiskeymess,emptybottlemess
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB GATORROOM, 50, 136, SPR_BRANDYBOTTLE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; KEEP OUT! DOZY'S HUT
OBJ_LIFT = 22

.lift1here
 EQUB DOZYSHUTROOM, lift      ,52 ,48 ,SPR_LIFTTOP,56,112,  48   ,1  ,0 ,0 ,PAL_WHITE+PLOT_XOR
 ;EQUB DOZYSHUTROOM, 52, 48, SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_MACHINE = 23

.machine1here
 EQUB LIFTCONTROLROOM, machines  ,50 ,116,SPR_MACHINE ,0   ,0   ,0   ,32 ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB LIFTCONTROLROOM, 50 ,116,SPR_MACHINE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE EAST TOWER
OBJ_KEY = 24

 EQUB EASTTOWERROOM, pickupable, 46, 136, SPR_KEY
 EQUW                keymess,proxkey1
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB EASTTOWERROOM, 46, 136, SPR_KEY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DRAGON'S LAIR
OBJ_LIFT2 = 25

.lift2here
 EQUB DRAGONSLAIRROOM, lift      ,40 ,56 ,SPR_LIFTTOP,56,134,  56   ,1  ,0 ,0 ,PAL_WHITE+PLOT_XOR
 ;EQUB DRAGONSLAIRROOM, 40,56 ,SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_MACHINE2 = 26

.machine2here
 EQUB LIFTCONTROLROOM, machines  ,72 ,116,SPR_MACHINE ,0   ,0   ,0   ,32 ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB LIFTCONTROLROOM, 72 ,116,SPR_MACHINE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; INSIDE THE CHURCH
OBJ_KEY2 = 27

 EQUB CHURCHROOM, pickupable, 80, 136, SPR_KEY
 EQUW                keymess,proxkey2
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB CHURCHROOM, 80, 136, SPR_KEY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIFT TO THE ELDERS
OBJ_LIFT3 = 28

.lift3here
 EQUB LIFTTOELDERSROOM, lift      ,58 ,48 ,SPR_LIFTTOP,56,136,  48   ,1  ,0 ,0 ,PAL_WHITE+PLOT_XOR
 ;EQUB LIFTTOELDERSROOM ,58,48 ,SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_MACHINE3 = 29

.machine3here
 EQUB LIFTCONTROLROOM, machines  ,52 ,156,SPR_MACHINE ,0   ,0   ,0   ,32 ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB LIFTCONTROLROOM, 52 ,156 ,SPR_MACHINE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; BASE OF THE VOLCANO
OBJ_KEY3 = 30

 EQUB BASEOFVOLCANOROOM, pickupable, 60, 120, SPR_KEY
 EQUW                keymess,proxkey3
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB BASEOFVOLCANOROOM, 60, 120, SPR_KEY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_LIFT4 = 31

.lift4here
 EQUB LIFTCONTROLROOM, lift      ,60 ,104 ,SPR_LIFTTOP,104,140,  104  ,1  ,0 ,0 ,PAL_WHITE+PLOT_XOR
 ;EQUB LIFTCONTROLROOM, 60,104 ,SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_MACHINE4 = 32

.machine4here
 EQUB LIFTCONTROLROOM, machines  ,70 ,156,SPR_MACHINE ,0   ,0   ,0   ,32 ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB LIFTCONTROLROOM, 70 ,156,SPR_MACHINE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BROKEN BRIDGE
OBJ_KEY4 = 33

 EQUB BROKENBRIDGEROOM, pickupable,40 ,96,SPR_KEY
 EQUW                keymess,proxkey4
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB BROKENBRIDGEROOM, 40 ,96,SPR_KEY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE WEST TOWER
OBJ_BUCKETEMPTY = 34

.buckethere
 EQUB WESTTOWERROOM, pickupable, 80, 144, SPR_BUCKET
 EQUW                mtbucketmess,proxmtbucket
 EQUB                 0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB WESTTOWERROOM, 80, 144, SPR_BUCKET

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

 EQUB OAKTREEROOM, pickupable, 52, 102, SPR_LEAFYBIT1
 EQUW                leavesmess
 EQUB        0,   0,  0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB OAKTREEROOM, 52, 102, SPR_LEAFYBIT1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE SMELLY ALLOTMENT
OBJ_COW = 37

 EQUB ALLOTMENTROOM, pickupable,60 ,160,SPR_COW
 EQUW                pigmycowmess
 EQUB        0,   0,  0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB ALLOTMENTROOM, 60 ,160,SPR_COW

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BOTTOMLESS WELL
OBJ_LEAF2 = 38

 EQUB TOPWELLROOM, pickupable,58 ,136,SPR_LEAFYBIT1
 EQUW                leavesmess
 EQUB        0,   0,  0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB TOPWELLROOM, 58 ,136,SPR_LEAFYBIT1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BOTTOMLESS WELL
OBJ_RAILING = 39

 EQUB TOPWELLROOM, pickupable,76 ,128,SPR_WOODENRAIL
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB TOPWELLROOM, 76 ,128,SPR_WOODENRAIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LOOKING OUT TO SEA
OBJ_DOZY = 40

.dozyhere
 EQUB OUTTOSEAROOM, pickupable, 74, 116, SPR_DOZY
 EQUW                dozyrou,dozytalking
 EQUB                   STR_dozytalking ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB OUTTOSEAROOM, 74, 116, SPR_DOZY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LOOKING OUT TO SEA
OBJ_DOZYFLOAT = 41

.dozyfloathere
 EQUB OUTTOSEAROOM, dozyfloat,68 ,139,SPR_DOZY,0  ,0  ,0   ,0,      0 ,0 ,PAL_WHITE+ATTR_NOTSOLID+PLOT_XOR
 ;EQUB OUTTOSEAROOM, 68, 139, SPR_DOZY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE'S DUNGEON
OBJ_JUGOFWATER = 42

 EQUB CASTLEDUNGEONROOM, pickupable,68 ,144,SPR_JUGOFWATER
 EQUW                jugmess,proxjug
 EQUB                 0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB CASTLEDUNGEONROOM, 68 ,144,SPR_JUGOFWATER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE'S DUNGEON
OBJ_BREAD = 43

.loafhere
 EQUB CASTLEDUNGEONROOM, pickupable,72 ,144,SPR_BREAD
 EQUW                loafmess,proxloaf
 EQUB               0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB CASTLEDUNGEONROOM, 72 ,144,SPR_BREAD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE'S DUNGEON
OBJ_RAT = 44

.rathere
 EQUB CASTLEDUNGEONROOM, rat       ,96 ,73 ,SPR_RAT,44,80 ,   60   ,2  ,0 ,255 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB CASTLEDUNGEONROOM, 96,73 ,SPR_RAT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE'S DUNGEON
OBJ_TROLL = 45

.trollhere
 EQUB CASTLEDUNGEONROOM, troll     ,78 ,136,SPR_TROLL ,44,80 ,   0   ,0  ,0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB CASTLEDUNGEONROOM, 78,136 ,SPR_TROLL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE EAST WING
OBJ_DAGGER = 46

 EQUB EASTWINGROOM, dagger    ,40 ,112,SPR_DAGGERBLADE ,0 ,0 ,   0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB EASTWINGROOM, 40, 112, SPR_DAGGERBLADE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DIZZY'S PARENTS HUT
OBJ_DOORKNOCKER = 47

 EQUB DIZZYSPARENTSHUTROOM, pickupable, 58, 136, SPR_DOORKNOCKER
 EQUW            doorknockermess,proxdoor
 EQUB                 0 ,0 ,PAL_YELLOW+ATTR_NOTSOLID
 ;EQUB DIZZYSPARENTSHUTROOM, 58, 136, SPR_DOORKNOCKER

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE CASTLE STAIRCASE
OBJ_PLANK = 48

.doorhere
 EQUB CASTLESTAIRCASEROOM, door    ,34 ,144,SPR_PLANKOFWOOD ,0 ,0 ,   0   ,0  ,0 ,0 ,  PAL_RED
 ;EQUB CASTLESTAIRCASEROOM, 34,144 ,SPR_PLANKOFWOOD

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; LIFT TO THE ELDERS
OBJ_GRANDDIZZY = 49

.doughere
 EQUB LIFTTOELDERSROOM, pickupable, 42, 76, SPR_GRANDDIZZY
 EQUW                dougrou,dougtalking
 EQUB                   STR_dougtalking ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB LIFTTOELDERSROOM, 42, 76, SPR_GRANDDIZZY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DRAGON'S LAIR
OBJ_DRAGON2 = 50

.dragonhere1
 EQUB DRAGONSLAIRROOM, dragon    ,68 ,152,SPR_DRAGONHEADCLOSED,0   ,0   ,0   ,0  ,0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB DRAGONSLAIRROOM, 68 ,152,SPR_DRAGONHEADCLOSED

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DRAGON'S LAIR
OBJ_GOLDENEGG2 = 51

.goldenegghere1
 EQUB DRAGONSLAIRROOM, pickupable,60 ,152,SPR_GOLDENEGG
 EQUW                goldeneggmess
 EQUB        0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB DRAGONSLAIRROOM, 60,152,SPR_GOLDENEGG

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
 EQUB TOPWELLROOM, crowbar  ,46 ,160,SPR_WOOD0 ,0 ,0 ,   0   ,0  ,0 ,0 ,  PAL_RED
 ;EQUB TOPWELLROOM, 46,160,SPR_WOOD0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE MEETING HALL
OBJ_PICKAXE = 54

 EQUB MEETINGHALLROOM, pickupable, 64, 80, SPR_PICKAXE
 EQUW              pickaxemess,proxpickaxe
 EQUB                   0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB MEETINGHALLROOM, 64, 80, SPR_PICKAXE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DESERTED MINES
OBJ_STONE2 = 55

.rockhere
 EQUB MINESROOM, crowbar  ,36 ,101,SPR_LARGESTONE2 ,0 ,0 ,   0   ,0  ,0 ,0 ,  PAL_RED+PLOT_OR
 ;EQUB MINESROOM, 36, 101, SPR_LARGESTONE2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DESERTED MINES
OBJ_TROLL2 = 56

.minerhere
 EQUB MINESROOM, miner     ,96 ,120,SPR_TROLL ,44,80 ,   0   ,0  ,0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB MINESROOM, 96, 120, SPR_TROLL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_DAGGER2 = 57

 EQUB DAISYSPRISONROOM, dagger    ,42 ,152,SPR_DAGGERBLADE ,0 ,0 ,   0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB DAISYSPRISONROOM, 42,152,SPR_DAGGERBLADE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_DAGGER3 = 58

 EQUB DAISYSPRISONROOM, dagger    ,50 ,152,SPR_DAGGERBLADE ,0 ,0 ,   0   ,0  ,0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB DAISYSPRISONROOM, 50,152,SPR_DAGGERBLADE

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE DRAGON'S LAIR
OBJ_RUG = 59

 EQUB DRAGONSLAIRROOM, pickupable,52 ,112,SPR_THICKRUG
 EQUW              rugmess,proxrug
 EQUB                   0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB DRAGONSLAIRROOM, 52,112,SPR_THICKRUG

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
 EQUB DAISYSPRISONROOM, lift     ,74 ,48,SPR_LIFTTOP,56,120,  48   ,2  ,0 ,0  ,PAL_WHITE
 ;EQUB DAISYSPRISONROOM, 74, 48, SPR_LIFTTOP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_DAISY = 63

.daisyhere
 EQUB DAISYSPRISONROOM, daisy   ,75 ,80,SPR_DAISY,0  ,0  ,0   ,2   ,  0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB DAISYSPRISONROOM, 75,80,SPR_DAISY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S PRISON
OBJ_SWITCH2 = 64

 EQUB DAISYSPRISONROOM, switch1 ,62 ,70,SPR_SWITCH,0   ,0   ,0   ,2  ,0 ,0 ,PAL_CYAN+ATTR_NOTSOLID
 ;EQUB DAISYSPRISONROOM, 62 ,70 ,SPR_SWITCH

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LARGE OAK TREE
OBJ_DYLAN = 65

.dylanhere
 EQUB OAKTREEROOM, pickupable, 72, 147, SPR_DYLAN
 EQUW                dylanrou,dylantalking
 EQUB                   STR_dylantalking ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB OAKTREEROOM, 72, 147, SPR_DYLAN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE BANQUET HALL
OBJ_DENZIL = 66

.denzilhere
 EQUB BANQUETHALLROOM, pickupable, 80, 155, SPR_DENZIL
 EQUW                denzilrou,denziltalking
 EQUB                   STR_denziltalking ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB BANQUETHALLROOM, 80, 155, SPR_DENZIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Appears at DAISY'S EMPTY HUT, following rescue
OBJ_DAISY2 = 67

.daisy1here
 EQUB OFFMAP,daisy1,48 ,77,SPR_DAISY,  0,0,0,2,   0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB OFFMAP,48,77,SPR_DAISY

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE LIFT CONTROL HUT
OBJ_RAILING2 = 68

 EQUB LIFTCONTROLROOM, pickupable,84 ,128,SPR_WOODENRAIL
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB LIFTCONTROLROOM, 84 ,128,SPR_WOODENRAIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DENZIL'S PAD
OBJ_RAILING3 = 69

 EQUB DENZILSPADROOM, pickupable, 76, 80, SPR_WOODENRAIL
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,PAL_RED+ATTR_NOTSOLID
 ;EQUB DENZILSPADROOM, 76, 80, SPR_WOODENRAIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; DAISY'S EMPTY HUT
OBJ_WINDOW = 70

 EQUB DAISYSHUTROOM, pickupable,56 ,72,SPR_WINDOW
 EQUW                windowmess
 EQUB        0,   0,  0 ,0 ,PAL_GREEN+ATTR_NOTSOLID
 ;EQUB DAISYSHUTROOM, 56 ,72,SPR_WINDOW

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; THE ENTRANCE HALL
OBJ_RAILING4 = 71

 EQUB ENTRANCEHALLROOM, pickupable,86 ,88,SPR_WOODENRAIL
 EQUW                railingmess
 EQUB        0,   0,  0 ,0 ,PAL_WHITE+ATTR_NOTSOLID
 ;EQUB ENTRANCEHALLROOM, 86 ,88,SPR_WOODENRAIL

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.endofmovingdata

noofmoving = (((endofmovingdata-movingdata)/movingsize) AND &FF)

IF (endofmovingdata-movingdata) <> (noofmoving*movingsize)
  ERROR "moving data typed in wrong"
ENDIF

; Reset moving items state, to when entering room they are in
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

; Moving items routines, run when in same room
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

.rethere
  RTS
;;

.rubprintmoving
{
  ; Load plot mode, and cache it
  LDY #colour:LDA (zptr4), Y:PHA

  ; Change to XOR plot
  AND #&E7:ORA #PLOT_XOR:STA (zptr4), Y

  ; Erase object
  JSR printmoving

  ; Restore plot mode
  LDY #colour:PLA:STA (zptr4), Y

  RTS
}

; IN : objecttodrop
; OUT : zptr4 points to movindata[objecttodrop]
.gettomovingdata
{
  ; Point to start of objects
  LDA #lo(movingdata):STA zptr4
  LDA #hi(movingdata):STA zptr4+1

  ; Iterate to correct one
  LDX #&00
.objectlp
  CPX objecttodrop:BEQ foundobject ; Is this the one?

  ; Advance to next object
  LDA zptr4:CLC:ADC #movingsize:STA zptr4
  BCC samepage
  INC zptr4+1
.samepage

  INX:CPX #noofmoving:BNE objectlp ; Loop until found or EOF

.foundobject
  RTS
}

; IN : objecttodrop = index of object to drop
.dropobject
{
  ; Point to correct object
  JSR gettomovingdata

  ; Store current room against object
  LDY #room:LDA roomno:STA (zptr4), Y

  ; Store Dizzy X position against object
  ;LDA x:AND %11111110:CLC:ADC #34
  LDA dizzyx ; TODO - REMOVE
  LDY #movex:STA (zptr4), Y

  ; Store Dizzy Y position against object
  ;LDA y:AND %11111000:SEC:SBC #8
  LDA dizzyy ; TODO - REMOVE
  LDY #movey:STA (zptr4), Y

if allowsndfx = 1

  LDA #11:STA sndfx

endif

  RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PICKUPABLE
; zptr4 = current object
.pickupablerou
{
  LDA pickup:BEQ done

  JSR collidewithdizzy16
  BEQ done

  LDA #&00:STA pickup

  LDY #movefrm:LDA (zptr4), Y
  CMP #SPR_SHOPKEEPER
  BNE notshopkeeper
  JMP inventoryrou ;;; shopkeeper

.notshopkeeper

  CMP #SPR_BAG
  BEQ pickingupbag

  CMP #SPR_MANURE
  BEQ pickupmanure

  ; Check for talking to yolk folk
  CMP #SPR_DOZY:BCC notpickingupbag  ;  < Dozy
  CMP #SPR_DIZZY:BCS notpickingupbag ; >= Dizzy
  JMP talkingtopeople

.notpickingupbag
  LDY #&00
.lookforslot
  LDA objectscarried, Y
  CMP #OBJ_BAG:BEQ noslotsleft ;;; end of carry list
  CMP #OBJ_EMPTY:BEQ gotslot ; found an empty slot
  INY:CLC:BCC lookforslot ; try next slot, this one is occupied

.gotslot
  CPY #&00:BEQ nomovingback ; if this is the first slot (empty bag), don't re-organise bag

.gotslotlp
  DEY:LDA objectscarried, Y ; Load object in previous slot
  INY:STA objectscarried, Y ; Store object in current slot
  CPY #&01:BEQ defragdone ; We've made a space at front of bag
  DEY
  CPY #&00:BNE gotslotlp
.defragdone

.nomovingback
  LDA slotno ; put picked up item at front of list
  STA objectscarried

.backtoinvent
  LDY #room:LDA #OFFMAP:STA (zptr4), Y ; Remove picked up object from room
  JMP inventoryrou

.noslotsleft
  ; When inventory is full, cycle it
  ; Drop the item picked up least recently
  DEY:LDA objectscarried, Y:STA objecttodrop
  TYA:PHA:LDA zptr4:PHA:LDA zptr4+1:PHA
  JSR dropobject
  PLA:STA zptr4+1:PLA:STA zptr4:PLA:TAY

  LDA #&01:STA toomuchtohold
  BNE gotslot ; Shuffle everything in bag to make empty slot first

.done
  RTS

.pickingupbag
  STA bag
  LDA #&00:STA objectscarried+2
  BEQ backtoinvent

.pickupmanure
  LDA manurehere+var1:BEQ yuck ; See if message already shown
  JMP tryputtingdown1
.yuck
  LDA #MANURE_PICKUP:STA manurehere+var1 ; Note that attempt was made to pick it up

  LDA #STR_pickupmanuremess:JSR findroomstr
  JMP windowrou
}

; zptr4 = current object
.printmoving
{
  LDY #movefrm:LDA (zptr4), Y:STA frmno
  LDY #movex:LDA (zptr4), Y:STA frmx
  LDY #movey:LDA (zptr4), Y:STA frmy
  LDY #colour:LDA (zptr4), Y:STA frmattri

  JSR frame
  JSR plotattris ; TODO - align better with original code

  RTS
}

resetpickupable = printmoving
resetcrocodile = printmoving
resetrat = printmoving
resettroll = printmoving
resetdagger = printmoving
resetminer = printmoving
resetdaisy = printmoving
resetdaisy1 = printmoving
resetswitch1 = printmoving

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; These are pointers to the room attribute of the object which appears after talking
; to specific yolkfolk, it gets updated from 255 to the current room, to become visible.

.duffmem ; Used when a person doesn't give you anything
  EQUB 0

shoptalk = beanhere+room
dozytalking = sleepingpotionhere+room
denziltalking = ropehere+room
dougtalking = crowbarhere+room
dylantalking = duffmem

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Names of objects which can be picked up and shown in inventory

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
.fullwinemess EQUB "A:BOTTLE:OF:WINE",PRT_END ; Never used by original code
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
.talkingtopeople
{
  LDY #movefrm:LDA (zptr4), Y
  CMP #SPR_DIZZY:BCS notyolkfolk ; >= Dizzy

  ; Find out how many times we've spoken before
  SEC:SBC #SPR_DOZY:TAY
  LDA talkbefore, Y
  BEQ notyolkfolk1 ; Not spoken yet (count is 0)

  ; clear bit 3 in talkbefore, and add 1
  AND #%11110111:CLC:ADC #&01
  STA talkbefore, Y

  ; jump to routine in object
  LDY #oldmovex
  LDA (zptr4), Y:STA jump+1:INY
  LDA (zptr4), Y:STA jump+2
.jump
  JMP duffmem

; Not spoken yet, so set to 1
.notyolkfolk1
  LDA #&01:STA talkbefore, Y

.notyolkfolk
  LDY #oldmovefrm:LDA (zptr4), Y:STA zptr5
  INY:LDA (zptr4), Y:STA zptr5+1

.^talkingtopeople1
  LDY #room:LDA roomno:STA (zptr5), Y ; Make object appear in current room

  ; Find associated chatter
  LDY #delaycounter:LDA (zptr4), Y
  JSR findroomstr

  ; fall through
}
.chatter
{
  LDA #&01:STA dontupdatedizzy ; Stop Dizzy being drawn
.morechatter
  JSR printandwait ; Print message and wait for user input to move on

  LDA (zptr5), Y ; If next character to print is not END then show next message
  CMP #PRT_END:BEQ done

  ; Advance zptr5 (since Y index gets reset)
  TYA:CLC:ADC zptr5:STA zptr5
  BCC samepage
  INC zptr5+1
.samepage
  LDA #&01:BNE morechatter

.done
  JMP windowrou1 ; Draw room again and allow dizzy to be drawn
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DOZYROU
.dozyrou
{
  ; Determine how many times we've spoken to dozy before
  LDA dozyhere+movefrm:SEC:SBC #SPR_DOZY:TAY
  LDA talkbefore, Y

  CMP #5        ; < 5
  BCC kickagain ; Kick again

  CMP #6        ; >= 6
  BCS done      ; Do nothing after 6th kick

  LDA #OFFMAP:STA dozyhere+room
  STA dozyfloathere+var1

  LDA #STR_pushdozymess:JSR findroomstr
  JMP windowrou

.kickagain
  LDA #STR_kickdozyagainmess:JSR findroomstr
  JMP windowrou

.done
  RTS
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DOUG ROU
.dougrou
{
  LDA #STR_goonmysonmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DYLAN ROU
.dylanrou
{
  LDA #STR_trancemess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DENZIL ROU
.denzilrou
{
  LDA #STR_stereoess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ARMOROG
.resetarmorog
{
  ; If "happy", don't reset everything
  LDA armoroghere+var1
  CMP #ARMOROG_HAPPY:BEQ done

.^armorogreguard
  ; Equivalent to reseteach()
  LDA #54:STA armoroghere+movex
  LDA #156:STA armoroghere+movey
  LDA #SPR_GRUNT0:STA armoroghere+movefrm
  LDA #&00
  STA armoroghere+var1
  STA armoroghere+delaycounter

  ; Clear h-flip
  LDA armoroghere+colour
  AND #&7F:STA armoroghere+colour

.done
  JMP printmoving
}

.armorogrou
{
  ; Check for collision with Dizzy
  JSR collidewithdizzy16
  BEQ armnotkilldizzy

  ; TODO - LDA #&00:STA left:STA right

  LDA #STR_armorogkilledmess:STA deathmsg ; Set death message to show
  LDA #20:JSR killdizzy1

.armnotkilldizzy
  ; State machine
  LDA armoroghere+var1:BEQ armasleep ; Default state
  CMP #ARMOROG_COUNTDOWN:BEQ armcountdown
  CMP #ARMOROG_RUNNING:BEQ armrunning
  CMP #ARMOROG_GUARDING:BEQ armguarding
.armhappy
.armguarding
  RTS

.armasleep
  ; Wake Armorog, to charge if Dizzy is in front of den
  LDA #64:STA cx:LDA #125:STA cy
  LDA #12:STA cw:LDA #40:STA ch
  JSR collidewithdizzy3:BEQ armguarding

  ; Start countdown to charge
  LDA #ARMOROG_COUNTDOWN:STA armoroghere+var1
  JSR rubprintmoving

  ; Indicate change of awareness
  LDA #155:STA armoroghere+movey
  LDA #SPR_GRUNT1:STA armoroghere+movefrm
  JSR printmoving
  LDA #20:STA armoroghere+oldmovex ; Set countdown value

  ; Count down to charge
.armcountdown
  DEC armoroghere+oldmovex
  BNE done
  LDA #ARMOROG_RUNNING:STA armoroghere+var1

  ; Running towards den
.armrunning
  JSR flyback
  JSR rubprintmoving
  INC armoroghere+movex ; Move right a bit

  ; Alternate between sprites for animation
  LDA armoroghere+movefrm:EOR #&01:STA armoroghere+movefrm

  ; If Dizzy is on the ground, charge
  LDA dizzyy:CMP #150:BCS intoden

  ; See if the bone is in the den, if so charge
  LDA bonehere+room:CMP armoroghere+room:BNE guardarm
  LDA bonehere+movex:CMP #80:BCC guardarm
  LDA bonehere+movey:CMP #140:BCC guardarm

.intoden
  LDA armoroghere+movex:CMP #78:BEQ not78
  JMP printmoving
.not78
  ; LDA #78:STA armoroghere+movex ; Stop armorog going offscreen (not in original)
  LDA armoroghere+colour:ORA #&80:STA armoroghere+colour ; h-flip
  LDA #156:STA armoroghere+movey
  LDA #ARMOROG_HAPPY:STA armoroghere+var1 ; Set to state to happy
  JSR printmoving

  ; If dizzy is dead, reset armorog
  LDA killed:BEQ notdead
  JMP armorogreguard
.notdead

  ; Remove bone from room
  LDA #OFFMAP:STA bonehere+room
  LDA #STR_fedarmorog:JSR findroomstr
  JMP windowrou

.guardarm
  JSR printmoving
  LDA armoroghere+movex
  CMP #62:BCC done
  LDA #ARMOROG_GUARDING:STA armoroghere+var1 ; Set state to guarding

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BLACK HOLE
.checkholdinghole
{
  ; See if it's the first item in inventory
  LDA objectscarried:CMP #OBJ_BLACKHOLE:BEQ found
.done
  RTS
.found

  ; Drop everything
  LDY #&00
.droplp
  LDA objectscarried, Y:CMP #OBJ_BAG+1:BCC enddrop

  STA objecttodrop

  TYA:PHA:JSR dropobject:PLA:TAY

  LDA #OBJ_EMPTY:STA objectscarried, Y
  INY:JMP droplp
.enddrop

  LDA roomno:PHA:LDA #ROOM_STRINGS:STA roomno
  LDA #STR_holdingholemess:JSR findroomstr
  PLA:STA roomno

  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DRAGON
.trytostartbreathing
{
  ; Check if this the fire-breathing dragon
  LDA roomno:CMP #WIDEEYEDDRAGONROOM:BEQ justrandomfire

  ; This is the dragon in the mine, so see check where golden egg is
  LDA goldenegghere1+room:CMP #OFFMAP:BNE done
  BEQ startbreath

.justrandomfire
  JSR random:CMP #5:BCS done

.startbreath
  LDA #1:STA breathingfire

if allowsndfx = 1

  LDA #10:STA sndfx ; snd fx for starting to breath fire

endif

  JMP alreadybreathing

.done
  RTS
}

.resetdragon
{
  LDA #&00:STA breathingfire

  JMP printneck
}

.dragonrou
{
  ; Check if dragon is asleep
  LDY #var1:LDA (zptr4), Y:BPL moveneckupanddown

  LDY #oldmovex:LDA (zptr4), Y:CMP #&F8:BNE keepgoing ; -8
  RTS
.keepgoing
  SEC:SBC #&01
  STA (zptr4), Y ; update oldmovex
  JMP resetdragon

.moveneckupanddown
  LDA breathingfire:BNE alreadybreathing

  JSR trytostartbreathing

.notbreathing
  LDY #delaycounter:LDA (zptr4), Y
  CLC:ADC #&01
  AND #31
  STA (zptr4), Y ; update delaycounter
  CMP #16:BCC okheadswing

  NEGATEACC
  CLC:ADC #32

.okheadswing
  LDY #oldmovex:STA (zptr4), Y ; update oldmovex

.^alreadybreathing
  ;;; LDY #var1:LDA (zptr4), Y:ORA &80:STA (zptr4), Y ; when sending dragon to sleep
.restdragon
  JSR collidewithdizzy16:BEQ notdragvdizz

  LDA #STR_dragonkilledmess:STA deathmsg ; Set death message to show
  JSR killdizzy

.notdragvdizz
  LDA breathingfire:BEQ keepgoing2
  JMP dragonfire
.keepgoing2

.^printneck
  LDA #SPR_DRAGONNECK:LDY #movefrm:STA (zptr4), Y

  JSR flyback

  LDA #1:STA z80breg
.dragonneck
  JSR findnecky ; Find Y position for this neck piece

  NEGATEACC
  CLC:ADC #DRAGON_HEAD_Y ; origy (both dragons are at the same Y position)
  LDY #movey:STA (zptr4), Y ; Set neck Y position

  LDA z80breg
  NEGATEACC
  CLC:ADC #77
  LDY #movex:STA (zptr4), Y ; Set neck X position

  JSR printmoving ; Draw neck piece

  INC z80breg ; Advance to next neck piece (1..6)
  LDA z80breg:CMP #&07:BNE dragonneck ; Loop for each next piece

.^printdragonhead
  LDY #oldmovex:LDA (zptr4), Y
  NEGATEACC
  CLC:ADC #DRAGON_HEAD_Y ; origy (both dragons are at the same Y position)
  LDY #movey:STA (zptr4), Y ; Set head Y position

  LDY #movex:LDA #DRAGON_HEAD_X:STA (zptr4), Y ; Set head X position

  ; Open mouth if breathing fire
  LDA breathingfire
  SEC:SBC #&01
  CMP #16
  LDA #SPR_DRAGONHEADCLOSED:BCS headclosed
  CLC:ADC #&01
.headclosed
  LDY #movefrm:STA (zptr4), Y ; Set head frame

  JMP printmoving ; Draw head
}

; z80creg
; z80breg (neck piece 1..6)
.findnecky
{
  LDA z80breg:BEQ done ; Don't think it ever will be 0 though

  PHA ; cache neck piece
  LDA z80creg:PHA ; cache c_reg
  LDY #oldmovex:LDA (zptr4), Y:STA z80creg

  ; Multiply neck piece by c_reg, result in a
  LDA #&00
.findnecklp
  CLC:ADC z80creg
  DEC z80breg:BNE findnecklp

  PHA ; Cache result
  LDA #3:STA z80breg ; neck piece = 3
  PLA ; Restore result

  JSR divide

  STA result+1 ; Cache divide result
  PLA:STA z80creg ; restore c_reg
  PLA:STA z80breg ; restore neck piece

.result
  LDA #&00 ; Restore divide result to return to callee

.done
  RTS
}

; Divide A by 16 ( >> 4 times)
.divide
{
  ; Check for negative input
  BMI negdivide

  ; Do positive divide
.dividelp
  LSR A
  DEC z80breg:BNE dividelp
  RTS

  ; Do negative divide
.negdivide
  NEGATEACC ; Change -ve to +ve
.divideneglp
  LSR A
  DEC z80breg:BNE divideneglp
  NEGATEACC ; Change +ve back to -ve
  RTS
}

.dragonfire
{
  ;;uses (breathingfire)
  LDA #&06
.dragonfirelp
  STA dragonflame

  LDA #7+64:STA z80creg ; c_reg = 7+64
  LDA breathingfire
  JSR printdragonflame

  LDA breathingfire ;;flips between yellow and red
  AND #&01:STA three+2
  ASL A
.three
  CLC:ADC #&00:ADC #2+64
  STA z80creg

  LDA breathingfire
  CLC:ADC #&01
  JSR printdragonflame

  LDA dragonflame
  AND #&01
  BNE keepgoing
  JSR flyback
.keepgoing

  LDA dragonflame
  SEC:SBC #&01:BEQ keepgoing2
  JMP dragonfirelp
.keepgoing2

  LDA breathingfire
  CLC:ADC #&01
  CMP #48:BCC juststoreit

  LDA #&00
.juststoreit
  STA breathingfire
  JMP printdragonhead
}

.printdragonflame
{
  STA z80breg

  LDA roomno
  LDX #50
  CMP #DRAGONSLAIRROOM ; Is this the dragon in the mine?
  BNE gotfirelim
  LDX #40

.gotfirelim
  LDA dragonflame
  ASL A ; *2
  SEC:SBC z80breg
  CLC:ADC #DRAGON_HEAD_X ;;;position of 1st flame
  STA hcomp+1 ; Cache for compare

.hcomp
  ;;;flame run out position
  CPX #&00:BCS done ; stop if run out to right of flame

  CMP #DRAGON_HEAD_X:BCS done ; stop if flame to right of dragon head

  STA frmx:STA cx

  LDA #&01:STA z80breg

  ; Get head position
  LDY #movey:LDA (zptr4), Y
  CLC:ADC #&08 ; Add on 8 (to appear in line with dragon's mouth)
  
  STA frmy:STA cy

  LDA #SPR_DRAGONFIRE:STA frmno

  JSR frame ; simprintflame()

  ; Set flame frame size for collision
  LDA #4:STA cw
  LDA #8:STA ch

  ; Check for collision with flame
  JSR collidewithdizzy3
  BEQ done

  LDA #STR_dragonflameskilledmess:STA deathmsg ; Set death message to show
  LDA #30:JMP killdizzy1

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SLEEP
.proxsleep
{
  EQUB WIDEEYEDDRAGONROOM ;;room
  EQUB 60,150 ;;;x,y
  EQUB 10,30 ;;;w,h

.proxsleeprou
  LDY #room:LDA #OFFMAP:STA (zptr4), Y ; Remove sleeping potion from room
  STA dragonhere+var1 ; Set dragon to be asleep

  LDA #STR_dragonasleepmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CROCODILE
.crocodilerou
{
  ; Only process if Dizzy is not dead
  LDA killed:BEQ cont
  RTS
.cont

  ; Advance delay counter to animate every 8th frame
  LDY #delaycounter:LDA (zptr4), Y
  CLC:ADC #&01:AND #&07:STA (zptr4), Y
  BNE justcroccoll

  ; Check if Dizzy is positioned on right of croc
  LDA #74:STA cx:LDA #80:STA cy
  LDA #20:STA cw:LDA #100:STA ch
  JSR collidewithdizzy3:STA ztmp7 ; cache result

  ; Start with default colour / plot
  LDA #(PAL_GREEN+PLOT_OR):STA ztmp8

  ; Don't flip if croc is tied
  LDY #var1:LDA (zptr4), Y
  BMI nottied

  ; Flip croc sprite horizontally when on right of it
  LDA ztmp7:BEQ notflipped
  LDA ztmp8:ORA #ATTR_REVERSE:STA ztmp8
.notflipped

.nottied
  JSR flyback
  JSR rubprintmoving ; Remove previously drawn croc

  ; Set new colour / plot
  LDY #colour:LDA ztmp8:STA (zptr4), Y

  ; See if crocodile is tied up
  LDY #var1:LDA (zptr4), Y:CMP #&FF
  BEQ hestied

  ; Advance var1
  CLC:ADC #&01:AND #&07
  STA (zptr4), Y

.hestied
  ; Start with mouth closed
  LDY #movefrm:LDA #SPR_CROCCLOSED:STA (zptr4), Y

  ; Determine if we need to open mouth
  LDY #var1:LDA (zptr4), Y
  CMP #240:BCS doprintmoving
  CMP #3:BCC doprintmoving
  AND #&01:BEQ doprintmoving

  ; Open crocodile's mouth
  LDY #movefrm:LDA #SPR_CROCOPEN:STA (zptr4), Y

  JSR printmoving

.justcroccoll
  LDY #movefrm:LDA (zptr4), Y:AND #&01:BNE done ; If mouth shut - skip death check

  ; Check for collision (proximitycollide)
  ;  Is Dizzy on top of crocodile with mouth open?
  LDA #70:STA cx:LDA #140:STA cy
  LDA #6:STA cw:LDA #10:STA ch
  JSR collidewithdizzy3:BEQ done

  ; Dizzy got eaten by crocodile

  LDA #7:STA sequence
  ; LDA #&00:STA left:STA right ; Clear keystate for left/right
  LDA #(69-32):STA x:LDA #160:STA y ; Set X, Y position for respawn
.^CROCDEATH
  LDA #STR_croceatenmess:STA deathmsg ; Set death message to show
  JMP killdizzy

.done
  RTS

.doprintmoving
  JMP printmoving
}

.proxcroc
{
  EQUB GATORROOM ;;room
  EQUB 68,140 ;;;x,y
  EQUB 10,20 ;;;w,h

.proxcrocrou
  LDY #room:LDA #OFFMAP:STA (zptr4), Y ; Remove rope from room
  STA crochere+var1 ; Set crocodile to be tied up

  LDA #STR_croctiedmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ROCK
.proxrock
{
  EQUB BROKENBRIDGEROOM ;;room
  EQUB 72,80 ;;;x,y
  EQUB 10,30 ;;;w,h

.proxrockrou
  LDY #room:LDA proxrock:STA (zptr4), Y

  ; Raise water
  LDA waterheight
  CLC:ADC #&06:STA waterheight

  ; Place the rock in the water (from right to left) to displace water
  NEGATEACC
  ADC #76
  LDY #movex:STA (zptr4), Y
  LDY #movey:LDA #176:STA (zptr4), Y

  LDA #STR_rockinwatermess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FLOATING LOG
.logrou
{
  JSR flyback
  JSR rubprintmoving

  ; fall through
}

.resetlog
{
  LDY #var1:LDA (zptr4), Y
  CLC:ADC #&01:AND #&03
  STA (zptr4), Y
  BNE logup

  LDA #&02
.logup
  STA ripple+2
  LDA waterheight
  NEGATEACC
.ripple
  CLC:ADC #&00
  CLC:ADC #162
  LDY #movey:STA (zptr4), Y

  JMP printmoving
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;HAWK
.resethawk
{
  LDY #movey:LDA #52:STA (zptr4), Y ; Place hawk in sky
  LDY #var1:LDA #HAWK_FLYING:STA (zptr4), Y ; Set to flying state (not diving)

  ; Draw in initial position
  JSR printmoving
}

.hawkrou
{
  ; Erase hawk
  JSR rubprintmoving

  ; Check first if hawk is diving for Dizzy
  LDY #var1:LDA (zptr4), Y
  BNE hawkdiving

.^joinresthawk
  ; Advance animation frame
  LDY #oldmovefrm:LDA (zptr4), Y
  AND #&03:BNE hawkupdown

  LDA #&02
.hawkupdown
  CLC:ADC #SPR_HAWK0-1
  LDY #movefrm:STA (zptr4), Y

  LDY #oldmovefrm:LDA (zptr4), Y
  CLC:ADC #&01
  AND #127
  STA (zptr4), Y

  LSR A
  CMP #32
  BCC okhawkx

  ;Flip direction of horizontal travel
  SEC:SBC #32
  NEGATEACC
  CLC:ADC #32

.okhawkx
  CLC:ADC #40
  LDY #movex:STA (zptr4), Y ; Set new X position

  ; If hawk above left cloud, it can't see Dizzy
  CMP #50
  BCS nextx
  JMP printmoving ; Draw hawk above left cloud

.nextx
  ; If hawk is above right cloud, it can't see Dizzy
  CMP #64
  BCC nextx2
  JMP printmoving ; Draw hawk above right cloud
.nextx2

  ; Check if Dizzy can be "seen" in narrow strip below hawk
  CLC:ADC #&02:STA cx
  LDA #52:STA cy
  LDA #4:STA cw
  LDA #120:STA ch
  JSR collidewithdizzy3:BEQ nocollide

  ; Hawk has seen Dizzy
  LDY #var1:LDA #HAWK_DIVING:STA (zptr4), Y ; Start dive
  LDY #movefrm:LDA #SPR_HAWK0:STA (zptr4), Y ; Set sprite

.nocollide
  ; End by drawing hawk in new position/frame
  JMP printmoving ; Draw hawk between clouds

  ; Hawk is diving for Dizzy
.hawkdiving
  LDA dizzyx
  LDY #movex:STA (zptr4), Y

  LDY #movey:LDA (zptr4), Y
  CLC:ADC #8
  STA (zptr4), Y

  JSR printmoving ; Draw hawk diving

  ; Check for collision with Dizzy
  JSR collidewithdizzy16
  BEQ done

  ; Collision occured
  LDA #STR_killedbyhawk:STA deathmsg ; Set death message to show
  LDA #3:JMP killdizzy1

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;KEYS
.proxkey1
{
  EQUB LIFTCONTROLROOM ;;room
  EQUB 51,120 ;;;x,y
  EQUB 4,16 ;;;w,h

  LDA #hi(machine1here):STA machineptr+1
  LDA #lo(machine1here):STA machineptr
  LDA #hi(lift1here):STA liftptr+1
  LDA #lo(lift1here):STA liftptr

.^proxkey1rou
  ; Remove dropped key
  LDY #room:LDA #OFFMAP:STA (zptr4), Y

  ; Set bottom bit of var1, on machine and associated lift
  LDY #var1
  LDA (machineptr), Y:ORA #&01:STA (machineptr), Y
  LDA (liftptr), Y:ORA #&01:STA (liftptr), Y

  ; Show message about turning machine on with key
  LDA #STR_keyinmachine:JSR findroomstr

  JMP windowrou
}

.proxkey2
{
  EQUB LIFTCONTROLROOM ;;room
  EQUB 73,120 ;;;x,y
  EQUB 4,16 ;;;w,h

  LDA #hi(machine2here):STA machineptr+1
  LDA #lo(machine2here):STA machineptr
  LDA #hi(lift2here):STA liftptr+1
  LDA #lo(lift2here):STA liftptr

  JMP proxkey1rou
}
.proxkey3
{
  EQUB LIFTCONTROLROOM ;;room
  EQUB 53,160 ;;;x,y
  EQUB 4,16 ;;;w,h

  LDA #hi(machine3here):STA machineptr+1
  LDA #lo(machine3here):STA machineptr
  LDA #hi(lift3here):STA liftptr+1
  LDA #lo(lift3here):STA liftptr

  JMP proxkey1rou
}
.proxkey4
{
  EQUB LIFTCONTROLROOM ;;room
  EQUB 71,160 ;;;x,y
  EQUB 4,16 ;;;w,h

  LDA #hi(machine4here):STA machineptr+1
  LDA #lo(machine4here):STA machineptr
  LDA #hi(lift4here):STA liftptr+1
  LDA #lo(lift4here):STA liftptr

  JMP proxkey1rou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MACHINES
.resetmachines
{
  ; Clear colour
  LDY #colour:LDA (zptr4), Y
  AND #%01111101
  STA (zptr4), Y

  ; Get machine state (0=off, 1=on)
  LDY #var1:LDA (zptr4), Y
  BEQ justdraw

  ; Merge with blanked bit 1 in colour and h-flip
  LDY #colour
  LDA #%10000010:ORA (zptr4), Y
  STA (zptr4), Y

.justdraw

  ; Draw this machine
  JMP printmoving
}

machinesrou = rethere
resetportswitch = resetmachines
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DRUNK
.checkifdrunk
{
  ; Check if Dizzy is drunk
  LDA drunk:BEQ done

  ; Yes, he's drunk, so decrement drunkeness
  SEC:SBC #&01
  STA drunk

  ; Check if divisible by 64 (frames?)
  AND #%00111111:BNE done

  ; Check which animation sequence we are currently running
  LDA sequence
  CMP #&02 ; Are we walking left or still? -> Fall over
  BCC fallover

  INC drunk
  RTS

.fallover
  JSR random:AND #&01 ; 50/50 chance for direction to go in
  PHA
  LDA #&00:STA dy
  LDA #&01:STA animation
  PLA:PHA:STA right
  EOR #&01:STA left
  PLA:CLC:ADC #&04:STA sequence ; Tumble left or right

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FILL BUCKET
turnonfullbucket = movingsize+room

.proxmtbucket
{
  EQUB BASEOFVOLCANOROOM ;;room
  EQUB 46,144 ;;;x,y
  EQUB 4,16 ;;;w,h

.proxmtbucketrou
  LDY #room:LDA #OFFMAP:STA (zptr4), Y ; Hide empty bucket
  LDY #turnonfullbucket:LDA roomno:STA (zptr4), Y ; Show full bucket

  LDA #STR_fillbucketmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;WATER BEAN STALK
.proxfullbucket
{
  EQUB ALLOTMENTROOM ;;room
  EQUB 71,160 ;;;x,y
  EQUB 8,16 ;;;w,h

.proxfullbucketrou
  LDY #room:LDA #OFFMAP:STA (zptr4), Y ; Hide full bucket

  ; Move Dizzy to the left
  LDA x:SEC:SBC #10:STA x

  ; Change manure state
  LDA #MANURE_WATERED:STA manurehere+var1

  LDA #STR_throwwateronbeanmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLANTING BEAN
.proxbean
{
  EQUB ALLOTMENTROOM ;;room
  EQUB 71,160 ;;;x,y
  EQUB 8,16 ;;;w,h

.proxbeanrou
  LDY #room:LDA #OFFMAP:STA (zptr4), Y ; Hide bean

  LDA #STR_plantbeanmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SHOP KEEPER
.shopkeeperrou
{
  ; See if we are in room 22 (market square)
  LDA roomno:CMP #MARKETSQUAREROOM:BNE done

  ; If we're at 0 do nothing
  LDA shopkeepercount:BEQ done

  ; Decrement counter
  SEC:SBC #&01:STA shopkeepercount:BNE done

  ; Make shop keeper appear in room 22 (market square)
  LDA #MARKETSQUAREROOM
  STA shopkeeperhere+room  ; Left side
  STA shopkeeperhere1+room ; Right side

  LDA #STR_shopkeeperappearsmess:JSR findroomstr
  JMP windowrou

.done
  RTS
}

.proxshopkeeper
{
  EQUB MARKETSQUAREROOM ;;room
  EQUB 66,160 ;;;x,y
  EQUB 8,16 ;;;w,h

.proxshopkeeperrou
  ; Do nothing if shop keeper isn't showing
  LDA shopkeepercount:BNE done

  ; Check if item dropped is cow
  LDY #movefrm:LDA (zptr4), Y
  CMP #SPR_COW:BNE notcow

  ; It is the cow so remove from room
  LDY #room:LDA #OFFMAP:STA (zptr4), Y

  ; Point to bean to make it appear
  LDA #hi(beanhere):STA zptr5+1
  LDA #lo(beanhere):STA zptr5

  ; Show chatter
  LDA #hi(shopkeeperhere):STA zptr4+1
  LDA #lo(shopkeeperhere):STA zptr4

  JMP talkingtopeople1

.notcow
  ; Chuck it on the crate - TODO remove (not in original)
  LDY #movex:LDA #62:STA (zptr4), Y
  LDY #movey:LDA #144:STA (zptr4), Y

  LDA shopkeeperhere+delaycounter
  CLC:ADC #&01:AND #3
  STA shopkeeperhere+delaycounter

  BEQ stopjunk

  LDA #STR_givingjunkmess:JSR findroomstr
  JMP windowrou

.stopjunk
  LDA #STR_stopgivingjunkmess:JSR findroomstr
  JMP windowrou

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LIFT
; IN roomno
; OUT A = origy
.liftorigy
{
  LDA roomno

  CMP #DRAGONSLAIRROOM:BNE keepgoing ; dragon's lair - LIFT 2
  LDA #56:BNE done

.keepgoing
  CMP #LIFTCONTROLROOM:BNE keepgoing2 ; lift control room - LIFT 4
  LDA #104:BNE done

.keepgoing2
  LDA #48 ; key1 / key3 / cloudcastle

.done
  RTS
}

.resetlift
{
  LDY #movey:LDA (zptr4), Y
  LDY #oldmovex:CMP (zptr4), Y
  BCS notfirstlift

  LDA (zptr4), Y
  LDY #movey:STA (zptr4), Y

.notfirstlift
  ; Load origy for this lift into b_reg
  JSR liftorigy:STA z80breg
  LDY #movey:LDA (zptr4), Y
  DEC z80breg
  PHA
  LDA z80breg:STA (zptr4), Y
  PLA

.drawdownlp
  PHA
  LDY #movey:LDA (zptr4), Y:CLC:ADC #&01:STA (zptr4), Y
  JSR printmoving
  PLA
  LDY #movey:CMP (zptr4), Y:BNE drawdownlp
  JSR rublift

  LDY #oldmovex:LDA (zptr4), Y:STA frmy
  STA z80breg

  LDY #oldmovey:LDA (zptr4), Y
  SEC:SBC z80breg
  CLC:ADC #42
  STA frmheight

  LDA #PLOT_AND:STA frmplot
  LDA #PAL_WHITE:STA frmattri
  JMP plotattris
}

.liftrou
{
  ; Do nothing if lift is not enabled
  LDY #var1:LDA (zptr4), Y:BNE keepgoing
  RTS
.keepgoing

  ; See if colliding with Dizzy (proximitycollide)
  ; if so, stop the lift, otherwise move it
  LDY #movex:LDA (zptr4), Y:STA cx
  LDY #movey:LDA (zptr4), Y:SEC:SBC #&02:STA cy
  LDA #8:STA cw
  LDA #48:STA ch
  JSR collidewithdizzy3:BEQ movelift

  ; See if Dizzy colliding with top of lift (proximitycollide)
  LDA #2:STA ch
  JSR collidewithdizzy3:BEQ keepgoing2
  JMP killedbycogs
.keepgoing2

  LDA dizzyx
  LDY #movex:SEC:SBC (zptr4), Y
  CLC:ADC #32
  CMP #3:BCS stopthelift

  LDA sequence:BEQ movelift

.stopthelift
  LDY #oldmovefrm:LDA #2:STA (zptr4), Y

  LDA obstructinglift
  CLC:ADC #&01:AND #63
  STA obstructinglift
  BNE keepgoing3

  LDA roomno:PHA:LDA #ROOM_STRINGS:STA roomno
  LDA #STR_obstructingliftmess:JSR findroomstr
  PLA:STA roomno
  JSR windowrou
.keepgoing3
  JMP roundmovelift

.movelift
  LDA #&00:STA obstructinglift

.roundmovelift
  LDY #oldmovefrm:LDA (zptr4), Y:BEQ justmovelift
  SEC:SBC #&01
  STA (zptr4), Y
  BNE done

.justmovelift
  LDY #var1:LDA (zptr4), Y:BEQ done
  JSR rublift

  LDY #var1:LDA (zptr4), Y
  LDY #movey:CLC:ADC (zptr4), Y:STA (zptr4), Y

  LDY #oldmovex:CMP (zptr4), Y:BEQ turnlift
  LDY #oldmovey:CMP (zptr4), Y:BNE notturnlift

.turnlift
  JSR negvar1
  LDY #oldmovefrm:LDA #50:STA (zptr4), Y

.notturnlift
.printlift
  JSR printmoving

.^rublift
  LDY #movey:LDA (zptr4), Y:PHA ; Cache movey

  CLC:ADC #40
  STA (zptr4), Y

  ; Set lift bottom
  LDY #movefrm:LDA #SPR_LIFTBOTTOM:STA (zptr4), Y

  LDY #colour:LDA (zptr4), Y:ORA #8:STA (zptr4), Y:PHA
  JSR printmoving
  PLA:AND #&F7:LDY #colour:STA (zptr4), Y
  
  PLA:LDY #movey:STA (zptr4), Y ; Restore movey

  ; Set back to lift top
  LDY #movefrm:LDA #SPR_LIFTTOP:STA (zptr4), Y

.done
  RTS

.killedbycogs
  LDA #STR_killedbyliftmess:STA deathmsg ; Set death message to show
  JMP killdizzy
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PORTCULLIS HERE
.resetportcullis
{
  LDA porthere+var1
  BNE resetrope1

.resetrope
  LDA #&00:STA porthere+var1
  LDA porthere+oldmovey:STA porthere+movey

.resetrope1
  LDA porthere+movey:PHA ; Cache current
  LDA #96-2:STA porthere+movey ; portcullis.origy-2
  PLA ; Restore previous

.drawropedownlp
  PHA
  INC porthere+movey
  INC porthere+movey
  JSR printmoving
  PLA
  CMP porthere+movey
  BNE drawropedownlp

  RTS
}

; Negate object.var1
;
; IN object pointer in zptr4
.negvar1
{
  LDY #var1

  LDA (zptr4), Y
  NEGATEACC
  STA (zptr4), Y

  RTS
}

.portcullisrou
{
  LDA porthere+var1:BEQ done

  CLC:ADC porthere+movey:STA porthere+movey
  CMP porthere+oldmovex
  BEQ turnportcullisplusdelay

  CMP porthere+oldmovey
  BNE notturnportcullis

  ; Raising portcullis delay
  LDA #&04:STA porthere+delay

.turnportcullis
  JSR negvar1
.notturnportcullis
  JSR printmoving
  JSR collidewithdizzy16
  BEQ done

  LDA #STR_killedbyportcullis:STA deathmsg ; Set death message to show
  LDA #&01:JMP killdizzy1

.turnportcullisplusdelay
  ; Lowering portcullis delay
  LDA #&01:STA porthere+delay
  BNE turnportcullis

.done
  RTS
}

.portswitchrou
{
  ; If not trying to interact, end now
  LDA pickup:BEQ done

  ; Check for collision, if not end now
  JSR collidewithdizzy16
  BEQ done

  ; Check if var1 is set (already switched), if so end now
  LDA portswitchhere+var1:BNE done

  ; Disable further interaction
  LDA #&00:STA pickup

  ; Set portcullis var1
  LDA #256-2:STA porthere+var1

  ; Set portcullis animation delay
  LDA #&06:STA porthere+delay

  ; Flag switch as used
  LDA #&01:STA portswitchhere+var1

  ; Display switch message
  LDA #STR_throwswitchmess:JSR findroomstr
  JMP windowrou

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DOZY FLOATING
.resetdozyfloat
{
  LDY #var1:LDA (zptr4), Y
  BEQ done

  JMP printmoving

.done
  RTS
}

.dozyfloatrou
{
  LDA dozyfloathere+var1
  BEQ done

  JSR printmoving

  LDA dozyfloathere+var1
  SEC:SBC #&01
  AND #&03
  BNE stillfloatdozy

  DEC dozyfloathere+movex

  LDA #&04
.stillfloatdozy
  STA dozyfloathere+var1
  SEC:SBC #&01
  CMP #&03
  BNE okbob

  LDA #&01
.okbob
  CLC:ADC #139 ; origy
  STA dozyfloathere+movey
  JSR printmoving

  LDA dozyfloathere+movex
  CMP #28
  BCS done

  LDA #&00:STA dozyfloathere+var1

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;THROWING WATER OF FIRE
.proxjug
{
  EQUB CASTLEDUNGEONROOM ;;room
  EQUB 44,150 ;;;x,y
  EQUB 6,26 ;;;w,h

.proxjugrou
  LDY #room:LDA #OFFMAP:STA (zptr4), Y ; Remove jug from room
  STA fireout ; Put fire out

  LDA #STR_throwwateronfiremess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RAT
.ratrou
{
  ; If rat is in lair, do nothing
  LDY #movex:LDA (zptr4), Y:BPL keepgoing
  RTS

.keepgoing
  ; Rub out previous
  JSR rubprintmoving

  ;  Decrement a counter
  LDY #oldmovefrm:LDA (zptr4), Y
  SEC:SBC #&01:STA (zptr4), Y
  BNE keepgoing2
  JSR ratnewdir
.keepgoing2

  ;
  LDY #var1:LDA (zptr4), Y
  LDY #movex:CLC:ADC (zptr4), Y
  STA (zptr4), Y:PHA ; cache movex
  LDA ratcount:AND #&01:BEQ notlefthandcheckrat
  PLA:PHA ; re-cache movex
  LDY #oldmovey:CMP (zptr4), Y:BNE notlefthandcheckrat
  JSR ratnewdir

.notlefthandcheckrat
  PLA
  LDY #oldmovex:CMP (zptr4), Y:BNE notrighthandcheckrat

  JSR ratnewdir
  LDA #&01:STA ratcount

.notrighthandcheckrat
  JSR printmoving

  ; Check for collision with Dizzy
  JSR collidewithdizzy16
  BEQ ratnotgotyou

  LDA #STR_ratgotyoumess:STA deathmsg ; Set death message to show
  JSR killdizzy

.ratnotgotyou
  LDY #movex:LDA (zptr4), Y

  ; Check for collision with loaf
.^ratcoll
  CMP #01:BNE done
  LDA #OFFMAP:STA loafhere+room ; Set loaf off-screen
  LDA #2:STA ratcount
  LDY #colour:LDA (zptr4), Y:BMI ratcollok
  JSR ratnewdir
.ratcollok
  LDY #oldmovefrm:LDA #255:STA (zptr4), Y
  LDA #STR_thanksforloafmess:JSR findroomstr
  JMP windowrou

  ; Choose a new direction (left/right) "randomly"
.ratnewdir
  JSR random
  AND #15
  CLC:ADC #16
  LDY #oldmovefrm:STA (zptr4), Y
  LDY #colour:LDA (zptr4), Y
  EOR #128
  STA (zptr4), Y
  JMP negvar1

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LOAF AND RAT
.proxloaf
{
  EQUB CASTLEDUNGEONROOM ;;room
  EQUB 46,64 ;;;x,y
  EQUB 40,16 ;;;w,h

.proxloafrou
  LDY #movex:LDA (zptr4), Y

  ; Store loaf position for rat to test against
  CLC:ADC #&02:STA ratcoll+1

  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;TROLL
.trollrou
{
  ; Check proximity box for troll
  LDA #hi(proxtroll):STA zptr6+1
  LDA #lo(proxtroll):STA zptr6

  JMP checkproximity1
}

.proxtroll
{
  EQUB CASTLEDUNGEONROOM ;; room
  EQUB 82, 136 ;; x, y
  EQUB 8, 32   ;; w, h

  ; When Dizzy collides with troll he gets thrown back into room
.^proxtrollrou
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ; TODO - set throw vector correctly
  LDA #dizzyx:SEC:SBC #20:STA dizzyx ; TODO - remove
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ; TODO - put back in when moving correctly
  ;
  ;LDA x:SEC:SBC #&02:STA x ; Move left a bit
  ;LDA #256-9:STA dy ; Point delta upwards (simulate jump)

  ;LDA #4:STA sequence ; Jump/tumble left
  ;LDA #1:STA animation ; Set second frame - horizontal/left on front (sprite 26)
  ;STA left ; Set left button pressed to "true"
  ;LDA #&00:STA right ; Set right button pressed to "false"
  ;LDA ff:CMP #25:BEQ done ; If current frame is leaning left (sprite 25), we're done

  ; Set up for message when in dungeon
  LDA #STR_getbackintheremess:JSR findroomstr
  LDA roomno:CMP #CASTLEDUNGEONROOM:BEQ showmessage

  ; See if the miner has already given the message
  LDY #var1:LDA (zptr4), Y:BNE done

  ; Set up for message when in mine
  LDA #STR_goawaymess:JSR findroomstr
.showmessage
  JMP windowrou

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;APPLE
.proxapple
{
  EQUB CASTLEDUNGEONROOM ;;room
  EQUB 78,152 ;;;x,y
  EQUB 4,16 ;;;w,h

.proxapplerou
  ; Make apple disappear off to the right
  LDY #movex:LDA #&FF:STA (zptr4), Y

  LDA #STR_trollgotapplemess:JSR findroomstr
  JMP chatter
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DAGGERS
.daggerrou
{
  ; Check for collision with Dizzy
  JSR collidewithdizzy16
  BEQ done

  LDA roomno
  CMP #DAISYSPRISONROOM ; Are we in the cloud prison
  BEQ roomdagok

  ; We are down the dagger pit in room (castle room 69)
  ; So put Dizzy out of the pit in room 84
  LDA #CASTLESTAIRCASEROOM:STA startroom
  LDA #56:STA startx
  LDA #176:STA starty

.roomdagok
  LDA #STR_killedbydaggersmess:STA deathmsg ; Set death message to show
  LDA #20:JMP killdizzy1
  
.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DOOR KNOCKER
.proxdoor
{
  EQUB CASTLESTAIRCASEROOM ;;room
  EQUB 34,160 ;;;x,y
  EQUB 4,16 ;;;w,h

.proxdoormess
  ; Remove door from room
  LDA #OFFMAP:STA doorhere+room

  LDA #STR_usedoorknockermess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DOOR
;
; -- TODO --
; Not needed since knocking places door out of the room, which stops it being drawn.
; Plus door.var1 is never changed
;
.resetdoor
{
  ; Don't draw door if it's been opened
  LDY #var1:LDA (zptr4), Y
  BNE done
  JMP printmoving

.done
  RTS
}

.doorrou
{
  ; Make sure Dizzy is not moving
  LDA sequence:BNE done

  ; Check proximity box for knock
  LDA #hi(proxknox):STA zptr6+1
  LDA #lo(proxknox):STA zptr6
  JMP checkproximity1

.done
  RTS
}

.proxknox
{
  EQUB CASTLESTAIRCASEROOM ;;room
  EQUB 34,160 ;;;x,y
  EQUB 4,16 ;;;w,h

  LDA doorhere+oldmovex:BNE done

  LDA #&01:STA doorhere+oldmovex

  LDA #STR_knockandentermess:JSR findroomstr
  JMP chatter

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;CROW BAR
.proxcrowbar
{
  EQUB TOPWELLROOM ;;room
  EQUB 46,144 ;;;x,y
  EQUB 8,16 ;;;w,h

.proxcrowbarrou
  ; Remove crowbar and well lid from room
  LDA #OFFMAP
  STA crowbarhere+room
  STA welllidhere+room

  LDA #STR_usecrowbarmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PICK AXE
.proxpickaxe
{
  EQUB MINESROOM ;;room
  EQUB 36,101 ;;;x,y
  EQUB 12,20 ;;;w,h

.proxpickaxerou
  ; Remove rock from room
  LDA #OFFMAP:STA rockhere+room

  LDA #STR_usepickaxemess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;EGG IN NEST
.proxegg
{
  EQUB DRAGONSLAIRROOM ;;room
  EQUB 54,150 ;;;x,y
  EQUB 4,20 ;;;w,h

.proxeggrou
  ; Make dragon happy
  LDA #&FF:STA dragonhere1+var1

  LDA #STR_puteggbackmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MINER
.minerrou
{
  ; Check proximity box for miner
  LDA #hi(proxminer):STA zptr6+1
  LDA #lo(proxminer):STA zptr6

  JMP checkproximity1
}

.proxminer
{
  EQUB MINESROOM ;; room
  EQUB 90, 120 ;; x, y
  EQUB 2, 32   ;; w, h

.proxminerou
  LDY #movex:LDA #90:STA (zptr4), Y
  LDA #OFFMAP:STA trollhere+room

  JSR proxtrollrou

  ; Set message viewed
  LDA #1:STA minerhere+var1

  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RUG TRICK
.proxrug
{
  EQUB DAISYSPRISONROOM ;;room
  EQUB 34,152 ;;;x,y
  EQUB 4,16 ;;;w,h

.proxrugrou
  ; Remove rug from room
  LDY #room:LDA #OFFMAP:STA (zptr4), Y

  ; Show two pieces of carpet covering daggers
  LDA roomno
  STA carpethere+room
  STA carpethere1+room

  LDA #STR_userugmess:JSR findroomstr
  JMP windowrou
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DAISY ROUTINE
.daisyrou
{
  ; Check for collision with Dizzy
  JSR collidewithdizzy16
  BEQ justinlift

  ; Check Dizzy is standing, not moving
  LDA sequence:BNE done

.test
  ; Stop Dizzy being drawn
  LDA #1:STA dontupdatedizzy

  ; Show message about finding Daisy
  LDA #STR_gottodaisymess:JSR findroomstr
  JSR prtmessage:JSR handoffandwait

  ; Show love hearts
  JSR theheartdemo

  ; Get back to cloud prison
  LDA #DAISYSPRISONROOM:STA roomno

  ; Remove Daisy from prison
  LDA #OFFMAP:STA daisyhere+room

  ; Place Daisy in treehouse village
  LDA #DAISYSHUTROOM:STA daisy1here+room

  ; Let Dizzy know that Daisy has gone
  LDA #STR_daisyrunsmess:JSR findroomstr
  JMP windowrou

.done
  RTS
}

.justinlift
{
  ; Place Daisy Y position so she appears on lift
  JSR rubprintmoving

  LDA daisylifthere+movey
  CLC:ADC #21
  LDY #movey:STA (zptr4), Y

.^anidaisy
  ; Animate Daisy using alternating h-flip
  LDY #colour:LDA (zptr4), Y
  EOR #ATTR_REVERSE:STA (zptr4), Y
  JMP printmoving
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DAISY WITH COINS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DAISY ROUTINE
.daisyrou1
{
  JSR collidewithdizzy16
  BNE doendmessages ; Collision

  JSR rubprintmoving
  JMP anidaisy

.doendmessages
  ; Check Dizzy is standing, not moving
  LDA sequence:BNE done

  LDA #10:STA x

  ; Check how many coins Dizzy has found
  LDA coins:CMP #30:BEQ completedit
  LDA #STR_notgotallcoins:JSR findroomstr
  JMP chatter

.completedit
  ; Mark game as completed
  LDA #&01:STA completedgame
  LDA #STR_gotallcoins:JSR findroomstr
  JSR chatter

  JMP theheartdemo

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;BRING DAISY LIFT DOWN
.switchrou1
{
  ; Turn Daisy's lift off by default
  LDA #&00:STA daisylifthere+var1

  ; See how far down Daisy's lift is
  LDA daisylifthere+movey
  CMP #100
  BCS done

  ; Draw the switch - not sure that this is needed?
  JSR printmoving

  ; If collided with Dizzy set var=1 else var1=0
  JSR collidewithdizzy16:BEQ keepgoing
  LDA #&01
.keepgoing
  LDY #var1:STA (zptr4), Y

  ; Update the colour/redraw based on on/off state of var1
  JSR resetmachines

  ; If switch is off, finish here
  LDY #var1:LDA (zptr4), Y:AND #&01:BEQ done

  ; Turn on Daisy's lift
  LDA #&01:STA daisylifthere+var1

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.domoving
{
  LDA #lo(movingdata):STA zptr4
  LDA #hi(movingdata):STA zptr4+1

  LDX #&00
.domovinglp
  STX slotno ; Cache object slot incase it gets overwritten

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

  LDX slotno ; Restore object slot

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

  STA z80breg ; Store delay

  ; Advance delaycounter
  LDY #delaycounter:LDA (zptr4), Y
  CLC:ADC #&01:STA (zptr4), Y

  ; Compare delaycounter to delay
  CMP z80breg:BCC done ; If < return

  ; Reset counter, setting Z flag so that routine is run
  LDY #delaycounter:LDA #&00:STA (zptr4), Y

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
  LDY #movex:LDA (zptr4), Y:STA cx
  LDY #movey:LDA (zptr4), Y:STA cy

  ; Get offset to frame data
  LDA #hi(frametable):STA zptr2+1
  LDA #lo(frametable):STA zptr2

  LDY #movefrm:LDA (zptr4), Y
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
  CLC:ADC #hi(ROMSBASE):STA zptr1+1

  ; Get low byte of offset
  DEY:LDA (zptr2), Y
  CLC:ADC #lo(ROMSBASE):STA zptr1
  BCC samepage
  INC zptr1+1
.samepage

  ; Page in sprites to get width/height
  PAGE_MOREDATA

  ; Get (width/4)
  LDY #&00:LDA (zptr1), Y:LSR A:LSR A:STA cw

  ; Get height
  INY:LDA (zptr1), Y:STA ch

  ; Page room data back in
  PAGE_ROOMDATA

  JMP collidewithdizzy3
}
