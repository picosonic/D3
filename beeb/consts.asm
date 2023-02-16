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
SWR_PAGE = &1100
SWR_ROOMDATA = &11FF
SWR_MOREDATA = &11FE

MACRO PAGE_ROOMDATA
  SEI:LDA SWR_ROOMDATA:STA ROMSEL:STA ROMSEL_CACHE:CLI
ENDMACRO

MACRO PAGE_MOREDATA
  SEI:LDA SWR_MOREDATA:STA ROMSEL:STA ROMSEL_CACHE:CLI
ENDMACRO

PLAYAREA = MODE8BASE+((5+1)*BYTESPERLINE)

MAIN_LOAD_ADDR = DFS_OPEN_FILE_BUFFER1 ; We don't need to open any files, so load where 1st file buffer starts
EXO_LOAD_ADDR = DFS_PAGE

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
BIGGESTROOM = 919 ; Room 22
TITLEROOM = 0
BEANSTALKROOM = 1
FIREROOM = 2
HEARTSROOM = 3
STARTROOM = 36
ALLOTMENTROOM = 58

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
STR_goawaymess = 5
STR_thanksforloafmess = 6
STR_ratgotyoumess = 7

; Room 40
STR_puteggbackmess = 2
STR_dragonkilledmess = 3

; Room 41
STR_usepickaxemess = 2

; Room 45
STR_dozytalking = 2
STR_kickdozyagainmess = 3
STR_pushdozymess = 4

; Room 48
STR_rockinwatermess = 2

; Room 49
STR_killedbyhawk = 2

; Room 50
STR_fedarmorog = 2
STR_armorogkilledmess = 3

; Room 51
STR_throwswitchmess = 2
STR_killedbyportcullis = 3

; Room 52
;STR_lookatpicturemess = 2

; Room 53
STR_croctiedmess = 2

; Room 54
STR_dragonasleepmess = 2
STR_dragonflameskilledmess = 3

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
STR_croceatenmess = 7
STR_obstructingliftmess = 8
STR_dropwhiskeymess = 9
STR_holdingholemess = 10
STR_youfoundcoinmess = 11