; Constants

; Hardware specific
MODE8BASE  = &5000

PLAYAREA = MODE8BASE+(12*256)

MAIN_LOAD_ADDR = DFS_OPEN_FILE_BUFFER2 ; We only need 1 concurrent open file, so load where 2nd file buffer starts
EXO_LOAD_ADDR = DFS_PAGE

; Colours (as per Spectrum offsets)
PAL_BLACK = 0
PAL_RED = 2
PAL_GREEN = 4
PAL_WHITE = 7

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
BIGGESTROOM = 342
