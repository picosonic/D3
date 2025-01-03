; Constants

; Bits in a byte
BITSPERBYTE = 8

; Pixel resolution
MAXX = 256
MAXY = 192
BYTESPERLINE = (MAXX*2)

; Hardware specific
MODE8BASE  = &5000

; Sideways RAM banks
SWR_SLOTS = 16
SWR_PAGE = &1100
SWR_ROOMDATA = &11FF
SWR_MOREDATA = &11FE
ROM_SIZE16KB = 16*1024
SWR_CACHE = ROMSBASE-ROM_SIZE16KB

MACRO PAGE_ROOMDATA
  SEI:LDA SWR_ROOMDATA:STA ROMSEL:STA ROMSEL_CACHE:CLI
ENDMACRO

MACRO PAGE_MOREDATA
  SEI:LDA SWR_MOREDATA:STA ROMSEL:STA ROMSEL_CACHE:CLI
ENDMACRO

MACRO NEGATEACC
  EOR #&FF:CLC:ADC #&01
ENDMACRO

PLAYAREA = MODE8BASE+((5+1)*BYTESPERLINE)

MAIN_LOAD_ADDR = DFS_OPEN_FILE_BUFFER1 ; We don't need to open any files, so load where 1st file buffer starts
EXO_LOAD_ADDR = DFS_PAGE

; Pixel positions
NEGATIVE_OFFSET = 32
BORDER_WIDTH = 8
BORDER_LEFT = (((NEGATIVE_OFFSET + BORDER_WIDTH) + 128) / 4)
BORDER_RIGHT = (((MAXX-BORDER_WIDTH) + 128) / 4)

; Colours (as per Spectrum offsets)
PAL_BLACK = 0
PAL_BLUE = 1
PAL_RED = 2
PAL_MAGENTA = 3
PAL_GREEN = 4
PAL_CYAN = 5
PAL_YELLOW = 6
PAL_WHITE = 7

; Attribute related
ATTR_GRID = 8

ATTR_NOTSOLID = &40 ; Set means not solid
ATTR_REVERSE = &80 ; Set means h-flip

; Message printing control codes
PRT_END = 0
PRT_XY = 128
PRT_PLOT = 3
PRT_GOSUB = 4
PRT_REP = 5
PRT_ENDREP = 6
PRT_DRAWBOX = 9
PRT_NR = 10
PRT_PEN = 16

; Room related
ROOM_EMPTY = 70
BIGGESTROOM = 919 ; In bytes - Room 22

TITLEROOM = 0
BEANSTALKROOM = 1
FIREROOM = 2
HEARTSROOM = 3
UNDERAUSROOM = 7

MARKETSQUAREROOM = 22
STRANGENEWROOM = 23
CHURCHROOM = 24
ILLUSIONROOM = 31

SMUGGLERSROOM = 35
CASTLEDUNGEONROOM = 36
WELLROOM = 39
DRAGONSLAIRROOM = 40
MINESROOM = 41
OUTTOSEAROOM = 45
DOCKSROOM = 46
WAREHOUSE = 47

BROKENBRIDGEROOM = 48
GUARDHOUSEROOM = 49
ARMOROGROOM = 50
MOATROOM = 51
ENTRANCEHALLROOM = 52
GATORROOM = 53
WIDEEYEDDRAGONROOM = 54
TOPWELLROOM = 55
LIFTCONTROLROOM = 56
BASETREEHOUSEROOM = 57
ALLOTMENTROOM = 58
OAKTREEROOM = 59
BASEOFVOLCANOROOM = 60
CRAFTYCLOUDROOM = 63

WESTWINGROOM = 67
BANQUETHALLROOM = 68
EASTWINGROOM = 69
DOZYSHUTROOM = 71
DENZILSPADROOM = 72
DAISYSHUTROOM = 73
GIANTBEANSTALKROOM = 74
CLOUDROUTEROOM = 75
NEARVOLCANOROOM = 76
ACTIVEVOLCANOROOM = 77

WESTTOWERROOM = 83
CASTLESTAIRCASEROOM = 84
EASTTOWERROOM = 85
LONGJUMPCLOUDROOM = 86
MEETINGHALLROOM = 87
LIFTTOELDERSROOM = 88
DIZZYSPARENTSHUTROOM = 89
YETMORECLOUDSROOM = 91
MOREORRIBLECLOUDSROOM = 92
CLOUDCASTLE = 93
DAISYSPRISONROOM = 94

ATTICROOM = 100

GAMESTARTROOM = CASTLEDUNGEONROOM

DIZZY_WIDTH = (3*8)

; External sprite id list
INCLUDE "sprites.asm"

; Frame plotting modes
PLOT_AND = &00
PLOT_OR = &08
PLOT_XOR = &10
PLOT_NULL = &18 ; Invalid - don't plot

; Dizzy input equivalent bit flags
PAD_JUMP   = &01
PAD_RIGHT  = &02
PAD_LEFT   = &04
PAD_FIRE   = &08
PAD_DOWN   = &10
PAD_UP     = &20
PAD_DEBUG  = &40

; Armorog state machine
ARMOROG_SLEEPING = 0
ARMOROG_COUNTDOWN = 1
ARMOROG_RUNNING = 2
ARMOROG_GUARDING = 3
ARMOROG_HAPPY = 4

; Manure state machine
MANURE_IDLE = 0
MANURE_PICKUP = 1
MANURE_WATERED = 2

; Hawk state machine
HAWK_FLYING = 0
HAWK_DIVING = 1

; Dragon(s) head default position
DRAGON_HEAD_X = 68
DRAGON_HEAD_Y = 152

; String offsets
STR_roomname = 1

; Room 0
STR_startmess = 2

; Room 22
STR_shopkeeperappearsmess = 2
STR_givingjunkmess = 3
STR_stopgivingjunkmess = 4
STR_thanksforthecowmess = 5
STR_tencoinsmess = 6
STR_nottengoldcoins = 7
STR_fivecoinsmess = 8
STR_notfivegoldcoins = 9
STR_erumbut = 10
STR_throwsbean = 11
STR_letsfaceitmess = 12

; Room 36
STR_trollgotapplemess = 2
STR_throwwateronfiremess = 3
STR_getbackintheremess = 4
STR_thanksforloafmess = 5

; Room 40
STR_puteggbackmess = 2

; Room 41
STR_usepickaxemess = 2
STR_goawaymess = 3

; Room 45
STR_dozytalking = 2
STR_kickdozyagainmess = 3
STR_pushdozymess = 4

; Room 48
STR_rockinwatermess = 2

; Room 50
STR_fedarmorog = 2

; Room 51
STR_throwswitchmess = 2

; Room 52
;STR_lookatpicturemess = 2

; Room 53
STR_croctiedmess = 2

; Room 54
STR_dragonasleepmess = 2

; Room 55
STR_usecrowbarmess = 2

; Room 56
STR_keyinmachine = 2

; Room 58
STR_throwwateronbeanmess = 2
STR_plantbeanmess = 3
STR_pickupmanuremess = 4

; Room 59
STR_dylantalking = 2
STR_trancemess = 3

; Room 60
STR_fillbucketmess = 2

; Room 68
STR_denziltalking = 2
STR_stereoess = 3

; Room 73
STR_notgotallcoins = 2
STR_gotallcoins = 3

; Room 77
STR_killedbyvolcano = 2

; Room 84
STR_knockandentermess = 2
STR_usedoorknockermess = 3

; Room 88
STR_dougtalking = 2
STR_goonmysonmess = 3

; Room 94
STR_userugmess = 2
STR_gottodaisymess = 3
STR_daisyrunsmess = 4

; Room 101 - special room
ROOM_STRINGS = 101
STR_deadwindow = 2
STR_killedbyliftmess = 3
STR_killedbyflame = 4
STR_killedbywater = 5
STR_killedbydaggersmess = 6
STR_killedbyhawk = 7
STR_croceatenmess = 8
STR_killedbyportcullis = 9
STR_ratgotyoumess = 10
STR_armorogkilledmess = 11
STR_dragonkilledmess = 12
STR_dragonflameskilledmess = 13
STR_obstructingliftmess = 14
STR_dropwhiskeymess = 15
STR_holdingholemess = 16
STR_youfoundcoinmess = 17
