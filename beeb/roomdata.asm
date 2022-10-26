ORG &00

INCLUDE "os.asm"
INCLUDE "consts.asm"

.roomdata_start

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room0
{
EQUW roomdata-room0 ; 0
EQUW roomname-room0 ; 1
EQUW startmess-room0 ; 2

.roomname
EQUB "SPC:OR:FIRE:TO:START", PRT_END

.startmess
EQUB PRT_XY+19,49,PRT_PEN+3, "FANTASY:WORLD"

EQUB PRT_XY+24,80,PRT_PEN+2, "STARRING"
EQUB PRT_XY+20,89, "THE:YOLKFOLK"
EQUB PRT_XY+20,108,PRT_PEN+5,"D",PRT_XY+22,106,"I",PRT_XY+24,104,"Z"
EQUB PRT_XY+26,102,"Z",PRT_XY+28,100,"Y"

EQUB PRT_XY+35,100,"D",PRT_XY+37,102,"A",PRT_XY+39,104,"I"
EQUB PRT_XY+41,106,"S",PRT_XY+43,108,"Y"

EQUB PRT_XY+9,142, "DENZIL:DYLAN"
EQUB PRT_XY+35,136, "DOZY"
EQUB PRT_XY+46,136, "GRAND"
EQUB PRT_XY+46,144, "DIZZY"
EQUB PRT_PEN+6,":"

EQUB PRT_END

.roomdata
INCBIN "rooms/room0.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room1
{
EQUW roomdata-room1 ; 0
EQUW roomname-room1 ; 1

.roomname
EQUB PRT_END

.roomdata
INCBIN "rooms/room1.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room2
{
EQUW roomdata-room2 ; 0
EQUW roomname-room2 ; 1

.roomname
EQUB PRT_END

.roomdata
INCBIN "rooms/room2.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room3
{
EQUW roomdata-room3 ; 0
EQUW roomname-room3 ; 1

.roomname
EQUB PRT_END

.roomdata
INCBIN "rooms/room3.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room4
.room5
.room6
.room7
.room8
.room9
.room10
.room11
.room12
.room13
.room14
.room15
.room16
.room17
.room18
.room19
.room20
.room21

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room22
{
EQUW roomdata-room22 ; 0
EQUW roomname-room22 ; 1

.roomname
EQUB ":THE:MARKET:SQUARE::", PRT_END

.roomdata
INCBIN "rooms/room22.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room23
{
EQUW roomdata-room23 ; 0
EQUW roomname-room23 ; 1

.roomname
EQUB "A:STRANGE:NEW:WORLD@", PRT_END

.roomdata
INCBIN "rooms/room23.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room24
{
EQUW roomdata-room24 ; 0
EQUW roomname-room24 ; 1

.roomname
EQUB ":INSIDE:THE:CHURCH::", PRT_END

.roomdata
INCBIN "rooms/room24.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room25
.room26
.room27
.room28
.room29
.room30

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room31
{
EQUW roomdata-room31 ; 0
EQUW roomname-room31 ; 1

.roomname
EQUB "THE:AMAZING:ILLUSION", PRT_END

.roomdata
INCBIN "rooms/room31.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room32
.room33
.room34

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room35
{
EQUW roomdata-room35 ; 0
EQUW roomname-room35 ; 1

.roomname
EQUB ":SMUGGLER;S:HIDEOUT:", PRT_END

.roomdata
INCBIN "rooms/room35.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room36
{
EQUW roomdata-room36 ; 0
EQUW roomname-room36 ; 1
EQUW trollgotapplemess-room36 ; 2

.roomname
EQUB "THE:CASTLE;S:DUNGEON", PRT_END

.trollgotapplemess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,13,5,PRT_PEN+3
EQUB PRT_XY+11,72,"YOU:GIVE"
EQUB PRT_XY+10,80,"THE:APPLE"
EQUB PRT_XY+7,88,"TO:THE:TROLL",PRT_END

EQUB PRT_PEN+5,PRT_XY+16,80,PRT_DRAWBOX,11,5,PRT_PEN+6
EQUB PRT_XY+23,104,"&FOR:ME?"
EQUB PRT_XY+22,112,"YOU;RE:SO"
EQUB PRT_XY+22,120,"GENEROUS'",PRT_END

EQUB PRT_PEN+5,PRT_XY+8,48,PRT_DRAWBOX,20,6,PRT_PEN+6
EQUB PRT_XY+16,72,"&I;D:LIKE:TO:LET"
EQUB PRT_XY+16,80,"YOU:PASS<:BUT:IF"
EQUB PRT_XY+14,88,"THE:KING:FOUND:OUT"
EQUB PRT_XY+15,96,"HE;D:TORTURE:ME@'",PRT_END

EQUB PRT_PEN+5,PRT_XY+6,112,PRT_DRAWBOX,22,5,PRT_PEN+6
EQUB PRT_XY+13,136,"&HOWEVER<:YOU:COULD"
EQUB PRT_XY+14,144,"ESCAPE:THROUGH:THE"
EQUB PRT_XY+11,152,"FIRE:USING:THE:WATER'",PRT_END,PRT_END

.roomdata
INCBIN "rooms/room36.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room37
.room38

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room39
{
EQUW roomdata-room39 ; 0
EQUW roomname-room39 ; 1

.roomname
EQUB "GOING:DOWN:THE:WELL@", PRT_END

.roomdata
INCBIN "rooms/room39.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room40
{
EQUW roomdata-room40 ; 0
EQUW roomname-room40 ; 1

.roomname
EQUB ":THE:DRAGON;S:LAIR::", PRT_END

.roomdata
INCBIN "rooms/room40.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room41
{
EQUW roomdata-room41 ; 0
EQUW roomname-room41 ; 1

.roomname
EQUB ":THE:DESERTED:MINES:", PRT_END

.roomdata
INCBIN "rooms/room41.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room42
.room43
.room44

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room45
{
EQUW roomdata-room45 ; 0
EQUW roomname-room45 ; 1

.roomname
EQUB ":LOOKING:OUT:TO:SEA:", PRT_END

.roomdata
INCBIN "rooms/room45.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room46
{
EQUW roomdata-room46 ; 0
EQUW roomname-room46 ; 1

.roomname
EQUB ":THE:DOCKS:AND:PIER:", PRT_END

.roomdata
INCBIN "rooms/room46.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room47
{
EQUW roomdata-room47 ; 0
EQUW roomname-room47 ; 1

.roomname
EQUB ":FOURWAY:WAREHOUSE::", PRT_END

.roomdata
INCBIN "rooms/room47.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room48
{
EQUW roomdata-room48 ; 0
EQUW roomname-room48 ; 1

.roomname
EQUB ":THE:BROKEN:BRIDGE::", PRT_END

.roomdata
INCBIN "rooms/room48.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room49
{
EQUW roomdata-room49 ; 0
EQUW roomname-room49 ; 1

.roomname
EQUB "::THE:GUARD:HOUSE:::", PRT_END

.roomdata
INCBIN "rooms/room49.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room50
{
EQUW roomdata-room50 ; 0
EQUW roomname-room50 ; 1

.roomname
EQUB ":::ARMOROG;S:DEN::::", PRT_END

.roomdata
INCBIN "rooms/room50.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room51
{
EQUW roomdata-room51 ; 0
EQUW roomname-room51 ; 1

.roomname
EQUB "MOAT:AND:PORTCULLIS:", PRT_END

.roomdata
INCBIN "rooms/room51.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room52
{
EQUW roomdata-room52 ; 0
EQUW roomname-room52 ; 1

.roomname
EQUB ":THE:ENTRANCE:HALL::", PRT_END

.roomdata
INCBIN "rooms/room52.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room53
{
EQUW roomdata-room53 ; 0
EQUW roomname-room53 ; 1

.roomname
EQUB "THE:SNAP:HAPPY:GATOR", PRT_END

.roomdata
INCBIN "rooms/room53.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room54
{
EQUW roomdata-room54 ; 0
EQUW roomname-room54 ; 1

.roomname
EQUB "THE:WIDE=EYED:DRAGON", PRT_END

.roomdata
INCBIN "rooms/room54.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room55
{
EQUW roomdata-room55 ; 0
EQUW roomname-room55 ; 1

.roomname
EQUB "THE:BOTTOMLESS:WELL:", PRT_END

.roomdata
INCBIN "rooms/room55.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room56
{
EQUW roomdata-room56 ; 0
EQUW roomname-room56 ; 1

.roomname
EQUB "THE:LIFT:CONTROL:HUT", PRT_END

.roomdata
INCBIN "rooms/room56.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room57
{
EQUW roomdata-room57 ; 0
EQUW roomname-room57 ; 1

.roomname
EQUB ":BASE:OF:TREE:HOUSE:", PRT_END

.roomdata
INCBIN "rooms/room57.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room58
{
EQUW roomdata-room58 ; 0
EQUW roomname-room58 ; 1

.roomname
EQUB "THE:SMELLY:ALLOTMENT", PRT_END

.roomdata
INCBIN "rooms/room58.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room59
{
EQUW roomdata-room59 ; 0
EQUW roomname-room59 ; 1

.roomname
EQUB ":THE:LARGE:OAK:TREE:", PRT_END

.roomdata
INCBIN "rooms/room59.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room60
{
EQUW roomdata-room60 ; 0
EQUW roomname-room60 ; 1

.roomname
EQUB "BASE:OF:THE:VOLCANO:", PRT_END

.roomdata
INCBIN "rooms/room60.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room61
.room62

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room63
{
EQUW roomdata-room63 ; 0
EQUW roomname-room63 ; 1

.roomname
EQUB "::THE:CRAFTY:CLOUD::", PRT_END

.roomdata
INCBIN "rooms/room63.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room64
.room65
.room66

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room67
{
EQUW roomdata-room67 ; 0
EQUW roomname-room67 ; 1

.roomname
EQUB ":::THE:WEST:WING::::", PRT_END

.roomdata
INCBIN "rooms/room67.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room68
{
EQUW roomdata-room68 ; 0
EQUW roomname-room68 ; 1

.roomname
EQUB "::THE:BANQUET:HALL::", PRT_END

.roomdata
INCBIN "rooms/room68.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room69
{
EQUW roomdata-room69 ; 0
EQUW roomname-room69 ; 1

.roomname
EQUB ":::THE:EAST:WING::::", PRT_END

.roomdata
INCBIN "rooms/room69.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room70

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room71
{
EQUW roomdata-room71 ; 0
EQUW roomname-room71 ; 1

.roomname
EQUB "KEEP:OUT@:DOZY;S:HUT", PRT_END

.roomdata
INCBIN "rooms/room71.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room72
{
EQUW roomdata-room72 ; 0
EQUW roomname-room72 ; 1

.roomname
EQUB "::::DENZIL;S:PAD::::", PRT_END

.roomdata
INCBIN "rooms/room72.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room73
{
EQUW roomdata-room73 ; 0
EQUW roomname-room73 ; 1

.roomname
EQUB ":DAISY;S:EMPTY:HUT::", PRT_END

.roomdata
INCBIN "rooms/room73.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room74
{
EQUW roomdata-room74 ; 0
EQUW roomname-room74 ; 1

.roomname
EQUB "THE:GIANT:BEANSTALK:", PRT_END

.roomdata
INCBIN "rooms/room74.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room75
{
EQUW roomdata-room75 ; 0
EQUW roomname-room75 ; 1

.roomname
EQUB "COMPLEX:CLOUD:ROUTE:", PRT_END

.roomdata
INCBIN "rooms/room75.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room76
{
EQUW roomdata-room76 ; 0
EQUW roomname-room76 ; 1

.roomname
EQUB "NEAR:THE:VOLCANO:TOP", PRT_END

.roomdata
INCBIN "rooms/room76.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room77
{
EQUW roomdata-room77 ; 0
EQUW roomname-room77 ; 1

.roomname
EQUB ":THE:ACTIVE:VOLCANO:", PRT_END

.roomdata
INCBIN "rooms/room77.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room78
.room79
.room80
.room81
.room82

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room83
{
EQUW roomdata-room83 ; 0
EQUW roomname-room83 ; 1

.roomname
EQUB ":::THE:WEST:TOWER:::", PRT_END

.roomdata
INCBIN "rooms/room83.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room84
{
EQUW roomdata-room84 ; 0
EQUW roomname-room84 ; 1

.roomname
EQUB "THE:CASTLE:STAIRCASE", PRT_END

.roomdata
INCBIN "rooms/room84.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room85
{
EQUW roomdata-room85 ; 0
EQUW roomname-room85 ; 1

.roomname
EQUB ":::THE:EAST:TOWER:::", PRT_END

.roomdata
INCBIN "rooms/room85.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room86
{
EQUW roomdata-room86 ; 0
EQUW roomname-room86 ; 1

.roomname
EQUB ":THE:LONGJUMP:CLOUD:", PRT_END

.roomdata
INCBIN "rooms/room86.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room87
{
EQUW roomdata-room87 ; 0
EQUW roomname-room87 ; 1

.roomname
EQUB "::THE:MEETING:HALL::", PRT_END

.roomdata
INCBIN "rooms/room87.bin"
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room88
{
EQUW roomdata-room88 ; 0
EQUW roomname-room88 ; 1

.roomname
EQUB ":LIFT:TO:THE:ELDERS:", PRT_END

.roomdata
INCBIN "rooms/room88.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room89
{
EQUW roomdata-room89 ; 0
EQUW roomname-room89 ; 1

.roomname
EQUB "DIZZY;S:PARENTS:HUT:", PRT_END

.roomdata
INCBIN "rooms/room89.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room90

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room91
{
EQUW roomdata-room91 ; 0
EQUW roomname-room91 ; 1

.roomname
EQUB "::YET:MORE:CLOUDS:::", PRT_END

.roomdata
INCBIN "rooms/room91.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room92
{
EQUW roomdata-room92 ; 0
EQUW roomname-room92 ; 1

.roomname
EQUB "MORE:;ORRIBLE:CLOUDS", PRT_END

.roomdata
INCBIN "rooms/room92.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room93
{
EQUW roomdata-room93 ; 0
EQUW roomname-room93 ; 1

.roomname
EQUB "::THE:CLOUD:CASTLE::", PRT_END

.roomdata
INCBIN "rooms/room93.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room94
{
EQUW roomdata-room94 ; 0
EQUW roomname-room94 ; 1

.roomname
EQUB ":::DAISY;S:PRISON:::", PRT_END

.roomdata
INCBIN "rooms/room94.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room95
.room96
.room97
.room98
.room99

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room100
{
EQUW roomdata-room100 ; 0
EQUW roomname-room100 ; 1

.roomname
EQUB ":::::THE:ATTIC::::::", PRT_END

.roomdata
INCBIN "rooms/room100.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room101

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.roomdata_end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.roomtable_start
{
EQUW room0
EQUW room1
EQUW room2
EQUW room3
EQUW room4
EQUW room5
EQUW room6
EQUW room7
EQUW room8
EQUW room9
EQUW room10
EQUW room11
EQUW room12
EQUW room13
EQUW room14
EQUW room15
EQUW room16
EQUW room17
EQUW room18
EQUW room19
EQUW room20
EQUW room21
EQUW room22
EQUW room23
EQUW room24
EQUW room25
EQUW room26
EQUW room27
EQUW room28
EQUW room29
EQUW room30
EQUW room31
EQUW room32
EQUW room33
EQUW room34
EQUW room35
EQUW room36
EQUW room37
EQUW room38
EQUW room39
EQUW room40
EQUW room41
EQUW room42
EQUW room43
EQUW room44
EQUW room45
EQUW room46
EQUW room47
EQUW room48
EQUW room49
EQUW room50
EQUW room51
EQUW room52
EQUW room53
EQUW room54
EQUW room55
EQUW room56
EQUW room57
EQUW room58
EQUW room59
EQUW room60
EQUW room61
EQUW room62
EQUW room63
EQUW room64
EQUW room65
EQUW room66
EQUW room67
EQUW room68
EQUW room69
EQUW room70
EQUW room71
EQUW room72
EQUW room73
EQUW room74
EQUW room75
EQUW room76
EQUW room77
EQUW room78
EQUW room79
EQUW room80
EQUW room81
EQUW room82
EQUW room83
EQUW room84
EQUW room85
EQUW room86
EQUW room87
EQUW room88
EQUW room89
EQUW room90
EQUW room91
EQUW room92
EQUW room93
EQUW room94
EQUW room95
EQUW room96
EQUW room97
EQUW room98
EQUW room99
EQUW room100
EQUW room101
}
.roomtable_end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

SAVE "RMDATA", roomdata_start, roomdata_end
SAVE "RMTABLE", roomtable_start, roomtable_end
