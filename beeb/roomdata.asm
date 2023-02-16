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
EQUW shopkeeperappearsmess-room22 ; 2
EQUW givingjunkmess-room22 ; 3
EQUW stopgivingjunkmess-room22 ; 4
EQUW thanksforthecowmess-room22 ; 5
EQUW tencoinsmess-room22; 6
EQUW nottengoldcoins-room22; 7
EQUW fivecoinsmess-room22; 8
EQUW notfivegoldcoins-room22; 9
EQUW erumbut-room22; 10
EQUW throwsbean-room22; 11
EQUW letsfaceitmess-room22; 12

.roomname
EQUB ":THE:MARKET:SQUARE::", PRT_END

.shopkeeperappearsmess
EQUB PRT_PEN+7,PRT_XY+2,96,PRT_DRAWBOX,20,5,PRT_PEN+3
EQUB PRT_XY+10,120,"PING@:>>>:AND:AS"
EQUB PRT_XY+10,128,"IF:BY:MAGIC<:THE"
EQUB PRT_XY+8,136,"SHOPKEEPER:APPEARS",PRT_END

.givingjunkmess
EQUB PRT_PEN+5,PRT_XY+2,96,PRT_DRAWBOX,25,4,PRT_PEN+6
EQUB PRT_XY+10,120,"&THAT;S:NO:GOOD:TO:ME"
EQUB PRT_XY+8,128,"GIV;:US:SOMETHIN;:ELSE'",PRT_END

.stopgivingjunkmess
EQUB PRT_PEN+5,PRT_XY+2,96,PRT_DRAWBOX,19,4,PRT_PEN+6
EQUB PRT_XY+10,120,"&STOP:GIVIN;:US"
EQUB PRT_XY+11,128,"ALL:THAT:TRASH'",PRT_END

.thanksforthecowmess
EQUB PRT_PEN+5,PRT_XY+2,80,PRT_DRAWBOX,26,4,PRT_PEN+6
EQUB PRT_XY+8,104,"&G;DAY:DIZ<:AHH@:A:PIGMY"
EQUB PRT_XY+9,112, "COW:THAT;S:INTERESTIN;'",PRT_END

.tencoinsmess
EQUB PRT_PEN+4,PRT_XY+10,120,PRT_DRAWBOX,22,4,PRT_PEN+3
EQUB PRT_XY+18,144,"&WELL<:HOW;S:ABOUT"
EQUB PRT_XY+15,152,"10:GOLD:COINS:FOR:IT'",PRT_END

.nottengoldcoins
EQUB PRT_PEN+5,PRT_XY+18,48,PRT_DRAWBOX,18,5,PRT_PEN+6
EQUB PRT_XY+24,72,"&STREWTH:MATE<:I"
EQUB PRT_XY+24,80,"SAID:INTERESTIN;"
EQUB PRT_XY+27,88,"NOT:VALUABLE'",PRT_END

.fivecoinsmess
EQUB PRT_PEN+4,PRT_XY+2,104,PRT_DRAWBOX,15,4,PRT_PEN+3
EQUB PRT_XY+11,128,"&WELL<:OK<"
EQUB PRT_XY+8,136,"5:GOLD:COINS'",PRT_END

.notfivegoldcoins
EQUB PRT_PEN+5,PRT_XY+6,72,PRT_DRAWBOX,24,5,PRT_PEN+6
EQUB PRT_XY+13,96, "&BE:SERIOUS<:IT:AIN;T"
EQUB PRT_XY+14,104,"WORTH:SPIT<:HERE;S:A"
EQUB PRT_XY+12,112,"BEAN<:THAT;S:GENEROUS'",PRT_END

.erumbut
EQUB PRT_PEN+4,PRT_XY+16,112,PRT_DRAWBOX,10,4,PRT_PEN+3
EQUB PRT_XY+22,136,"&ER<:UM<"
EQUB PRT_XY+22,144,"BUT:>>>'",PRT_END

.throwsbean
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,11,5,PRT_PEN+6
EQUB PRT_XY+8,72,"&NOW:STOP"
EQUB PRT_XY+8,80,":WASTIN;"
EQUB PRT_XY+7,88,":MY:TIME'"
EQUB PRT_PEN+7,PRT_XY+12,112,PRT_DRAWBOX,15,5,PRT_PEN+3
EQUB PRT_XY+18,136,"AND:HE:THROWS"
EQUB PRT_XY+21,144,":THE:BEAN"
EQUB PRT_XY+19,152,"ON:THE:CRATE",PRT_END

.letsfaceitmess
EQUB PRT_PEN+7,PRT_XY+8,80,PRT_DRAWBOX,20,5,PRT_PEN+3
EQUB PRT_XY+15,104,"YOU:LEAVE:=:LET;S"
EQUB PRT_XY+18,112,"FACE:IT:DIZZY<"
EQUB PRT_XY+15,120,"YOU:CAN;T:BARTER@",PRT_END,PRT_END

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
EQUW throwwateronfiremess-room36 ; 3
EQUW getbackintheremess-room36 ; 4
EQUW goawaymess-room36 ; 5
EQUW thanksforloafmess-room36 ; 6
EQUW ratgotyoumess-room36 ; 7

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

.throwwateronfiremess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,6,PRT_PEN+3
EQUB PRT_XY+10,72, "YOU:THROW:THE:JUG"
EQUB PRT_XY+10,80,"OF:WATER:ONTO:THE"
EQUB PRT_XY+8,88, "FIRE:AND:THE:FLAMES"
EQUB PRT_XY+7,96, "ARE:QUICKLY:QUENCHED",PRT_END

.getbackintheremess
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,21,4,PRT_PEN+6
EQUB PRT_XY+10,72,  "&OY@:WHERE:DO:YOU"
EQUB PRT_XY+7,80,  "THINK:YOU;RE:GOING@'",PRT_END

.goawaymess
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,26,5,PRT_PEN+6
EQUB PRT_XY+10,72,"&OH:NO@:NOT:YOU:AGAIN>"
EQUB PRT_XY+12,80, "GO:AWAY>:I;M:HIDING<"
EQUB PRT_XY+8,88, "AND:IT;S:ALL:YOUR:FAULT'",PRT_END

.thanksforloafmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,18,5,PRT_PEN+3
EQUB PRT_XY+8,72, "THE:RAVENOUS:RAT"
EQUB PRT_XY+11,80,"EATS:THE:LOAF"
EQUB PRT_XY+11,88,"AND:RUNS:AWAY",PRT_END

.ratgotyoumess
EQUB PRT_XY+20,88,"THE:RAT:GOES"
EQUB PRT_XY+20,96,"STRAIGHT:FOR"
EQUB PRT_XY+23,104,"YOUR:NECK"
EQUB PRT_END

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
EQUW puteggbackmess-room40 ; 2
EQUW dragonkilledmess-room40 ; 3

.roomname
EQUB ":THE:DRAGON;S:LAIR::", PRT_END

.puteggbackmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,20,6,PRT_PEN+3
EQUB PRT_XY+11,72,"YOU:PUT:THE:EGG"
EQUB PRT_XY+8,80, "BACK:INTO:THE:NEST"
EQUB PRT_XY+12,88,"AND:THE:DRAGON"
EQUB PRT_XY+8,96, "ALLOWS:YOU:TO:PASS",PRT_END

.dragonkilledmess
EQUB PRT_XY+16,88, "THE:DRAGON:BITES"
EQUB PRT_XY+16,96, "YOU:AND:YOU:KEEL"
EQUB PRT_XY+20,104,"OVER:AND:DIE"
EQUB PRT_END

.roomdata
INCBIN "rooms/room40.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room41
{
EQUW roomdata-room41 ; 0
EQUW roomname-room41 ; 1
EQUW usepickaxemess-room41 ; 2

.roomname
EQUB ":THE:DESERTED:MINES:", PRT_END

.usepickaxemess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,22,4,PRT_PEN+3
EQUB PRT_XY+9,72,"YOU:USE:THE:PICKAXE"
EQUB PRT_XY+8,80,"TO:BREAK:UP:THE:ROCK",PRT_END

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
EQUW dozytalking-room45 ; 2
EQUW kickdozyagainmess-room45 ; 3
EQUW pushdozymess-room45 ; 4

.roomname
EQUB ":LOOKING:OUT:TO:SEA:", PRT_END

.dozytalking
EQUB PRT_PEN+4,PRT_XY+30,48,PRT_DRAWBOX,12,4,PRT_PEN+3
EQUB PRT_XY+36,72, "&HEY@:DOZY"
EQUB PRT_XY+38,80, "GET:UP@'",PRT_END

EQUB PRT_PEN+7,PRT_XY+2,80,PRT_DRAWBOX,16,5,PRT_PEN+3
EQUB PRT_XY+10,104,"YOU:KICK:THE"
EQUB PRT_XY+8,112, "DECK:CHAIR:AND"
EQUB PRT_XY+11,120,"HE:WAKES:UP",PRT_END

EQUB PRT_PEN+5,PRT_XY+12,112,PRT_DRAWBOX,17,4,PRT_PEN+6
EQUB PRT_XY+18,136,"&OH@:WHAT;S:THE"
EQUB PRT_XY+20,144,"PROBLEM:DIZZY'",PRT_END

EQUB PRT_PEN+4,PRT_XY+2,48,PRT_DRAWBOX,26,7,PRT_PEN+3
EQUB PRT_XY+9,72,  "&DAISY;S:BEEN:EGGNAPPED"
EQUB PRT_XY+8,80,  "AND:IS:BEING:HELD:IN:THE"
EQUB PRT_XY+10,88, "WIZARD;S:CLOUD:CASTLE<"
EQUB PRT_XY+12,96, "AND:NOBODY:WILL:HELP"
EQUB PRT_XY+17,104,"ME:RESCUE:HER@'",PRT_END

EQUB PRT_PEN+5,PRT_XY+2,88,PRT_DRAWBOX,14,6,PRT_PEN+6
EQUB PRT_XY+8 ,112,"&AHH<:THAT;S"
EQUB PRT_XY+11,120,"BAD:LUCK>"
EQUB PRT_XY+11,128,"I;LL:HELP"
EQUB PRT_XY+10,136, "YOU:DIZZY'",PRT_END

EQUB PRT_PEN+5,PRT_XY+18,112,PRT_DRAWBOX,18,5,PRT_PEN+6
EQUB PRT_XY+28,136,"&HERE;S:SOME"
EQUB PRT_XY+24,144,"SLEEPING:POTION<"
EQUB PRT_XY+23,152,"THAT:SHOULD:HELP'",PRT_END

EQUB PRT_PEN+4,PRT_XY+2,120,PRT_DRAWBOX,17,4,PRT_PEN+3
EQUB PRT_XY+10,144,"&BUT:I;D:LIKE"
EQUB PRT_XY+8,152,"YOU:TO:HELP:ME'",PRT_END

EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,16,7,PRT_PEN+6
EQUB PRT_XY+9,72,"&SORRY:DIZZY<"
EQUB PRT_XY+10,80,"LOVE:TO<:BUT"
EQUB PRT_XY+10,88,"IT;S:FAR:TOO"
EQUB PRT_XY+9,96, "NICE:A:DAY:TO"
EQUB PRT_XY+7,104,"RESCUE:MAIDENS'",PRT_END

EQUB PRT_PEN+7,PRT_XY+8,80,PRT_DRAWBOX,20,5,PRT_PEN+3
EQUB PRT_XY+14,104,"I:DON;T:THINK:HE;S"
EQUB PRT_XY+14,112,"GOING:TO:HELP<:AND"
EQUB PRT_XY+14,120,"HE;S:FALLEN:ASLEEP",PRT_END,PRT_END

.kickdozyagainmess
EQUB PRT_PEN+7,PRT_XY+10,80,PRT_DRAWBOX,17,4,PRT_PEN+3
EQUB PRT_XY+18,104,"YOU:KICK:DOZY"
EQUB PRT_XY+16,112,"BUT:HE;S:ASLEEP",PRT_END

.pushdozymess
EQUB PRT_PEN+7,PRT_XY+6,72,PRT_DRAWBOX,22,6,PRT_PEN+3
EQUB PRT_XY+14,96,"WHOOPS@:YOU:KICKED"
EQUB PRT_XY+13,104,"TOO:HARD:AND:DOZY;S"
EQUB PRT_XY+11,112,"FALLEN:INTO:THE:WATER"
EQUB PRT_XY+11,120,"AND:HE;S:STILL:ASLEEP",PRT_END

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
EQUW rockinwatermess-room48 ; 2

.roomname
EQUB ":THE:BROKEN:BRIDGE::", PRT_END

.rockinwatermess
EQUB PRT_PEN+7,PRT_XY+2,112,PRT_DRAWBOX,26,5,PRT_PEN+3
EQUB PRT_XY+6,136,"YOU:PUSH:THE:ROCK:INTO:THE"
EQUB PRT_XY+6,144,"RIVER:AND:IT:DISPLACES:THE"
EQUB PRT_XY+8,152,"WATER<:RAISING:THE:LEVEL",PRT_END

.roomdata
INCBIN "rooms/room48.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room49
{
EQUW roomdata-room49 ; 0
EQUW roomname-room49 ; 1
EQUW killedbyhawk-room49 ; 2

.roomname
EQUB "::THE:GUARD:HOUSE:::", PRT_END

.killedbyhawk
EQUB PRT_XY+18,88,"THE:DIZZY:HAWK"
EQUB PRT_XY+21,96,"SWOOPS:DOWN"
EQUB PRT_XY+19,104,"AND:KILLS:YOU"
EQUB PRT_END

.roomdata
INCBIN "rooms/room49.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room50
{
EQUW roomdata-room50 ; 0
EQUW roomname-room50 ; 1
EQUW fedarmorog-room50 ; 2
EQUW armorogkilledmess-room50 ; 3

.roomname
EQUB ":::ARMOROG;S:DEN::::", PRT_END

.fedarmorog
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,18,4,PRT_PEN+3
EQUB PRT_XY+8,72,"THAT:BONE:SHOULD"
EQUB PRT_XY+10,80,"KEEP:HIM:BUSY@",PRT_END

.armorogkilledmess
EQUB PRT_XY+18,88,"ARMOROG:CAUGHT"
EQUB PRT_XY+17,100,"YOU:TRESPASSING"
EQUB PRT_END

.roomdata
INCBIN "rooms/room50.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room51
{
EQUW roomdata-room51 ; 0
EQUW roomname-room51 ; 1
EQUW throwswitchmess-room51 ; 2
EQUW killedbyportcullis-room51 ; 3

.roomname
EQUB "MOAT:AND:PORTCULLIS:", PRT_END

.throwswitchmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,15,5,PRT_PEN+3
EQUB PRT_XY+8,72,"YOU:THROW:THE"
EQUB PRT_XY+8,80,"LEVER:TO:;ON;"
EQUB PRT_XY+8,88,"BUT:IT:BREAKS",PRT_END

.killedbyportcullis
EQUB PRT_XY+16,88,"YOU:WERE:STABBED"
EQUB PRT_XY+16,96,"BY:THE:SPIKES:OF"
EQUB PRT_XY+18,104,"THE:PORTCULLIS"
EQUB PRT_END

.roomdata
INCBIN "rooms/room51.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room52
{
EQUW roomdata-room52 ; 0
EQUW roomname-room52 ; 1
;EQUW lookatpicturemess-room52 ; 2

.roomname
EQUB ":THE:ENTRANCE:HALL::", PRT_END

;.lookatpicturemess
;EQUB PRT_PEN+7,PRT_XY+2,96,PRT_DRAWBOX,23,6,PRT_PEN+3
;EQUB PRT_XY+11,120, "YOU:LOOK:UP:AT:THE"
;EQUB PRT_XY+9,128,  "PICTURE>:IT;S:YOU:IN"
;EQUB PRT_XY+10,136, "YOUR:LAST:ADVENTURE",PRT_PEN+5
;EQUB PRT_XY+8,144,  "TREASURE:ISLAND:DIZZY",PRT_END

.roomdata
INCBIN "rooms/room52.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room53
{
EQUW roomdata-room53 ; 0
EQUW roomname-room53 ; 1
EQUW croctiedmess-room53 ; 2

.roomname
EQUB "THE:SNAP:HAPPY:GATOR", PRT_END

.croctiedmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,19,5,PRT_PEN+3
EQUB PRT_XY+11,72,"YOU:NIMBLY:TIE"
EQUB PRT_XY+10,80,"THE:ROPE:AROUND"
EQUB PRT_XY+8,88, "THE:GATOR;S:SNOUT",PRT_END

.roomdata
INCBIN "rooms/room53.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room54
{
EQUW roomdata-room54 ; 0
EQUW roomname-room54 ; 1
EQUW dragonasleepmess-room54 ; 2
EQUW dragonflameskilledmess-room54 ; 3

.roomname
EQUB "THE:WIDE=EYED:DRAGON", PRT_END

.dragonasleepmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,6,PRT_PEN+3
EQUB PRT_XY+8,72,"YOU:SMASH:THE:FLASK"
EQUB PRT_XY+10,80,"OF:POTION:AND:THE"
EQUB PRT_XY+9,88,"DRAGON:INHALES:THE"
EQUB PRT_XY+8,96,"INTOXICATING:VAPOUR",PRT_END

.dragonflameskilledmess
EQUB PRT_XY+17,88, "YOU:ARE:ROASTED"
EQUB PRT_XY+17,96, "BY:THE:DRAGON;S"
EQUB PRT_XY+20,104,"FIERY:BREATH"
EQUB PRT_END

.roomdata
INCBIN "rooms/room54.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room55
{
EQUW roomdata-room55 ; 0
EQUW roomname-room55 ; 1
EQUW usecrowbarmess-room55 ; 2

.roomname
EQUB "THE:BOTTOMLESS:WELL:", PRT_END

.usecrowbarmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,19,5,PRT_PEN+3
EQUB PRT_XY+8,72,"USING:THE:CROWBAR"
EQUB PRT_XY+8,80,"YOU:FORCE:THE:LID"
EQUB PRT_XY+13,88,"OFF:THE:WELL",PRT_END

.roomdata
INCBIN "rooms/room55.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room56
{
EQUW roomdata-room56 ; 0
EQUW roomname-room56 ; 1
EQUW keyinmachine-room56 ; 2

.roomname
EQUB "THE:LIFT:CONTROL:HUT", PRT_END

.keyinmachine
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,24,5,PRT_PEN+3
EQUB PRT_XY+8,72,"YOU:TRY:THE:KEY:IN:THE"
EQUB PRT_XY+13,80,"LOCK:AND:IT:FITS@"
EQUB PRT_XY+8,88,"SO:YOU:TURN:IT:TO:;ON;",PRT_END

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
EQUW throwwateronbeanmess-room58 ; 2
EQUW plantbeanmess-room58 ; 3
EQUW pickupmanuremess-room58 ; 4

.roomname
EQUB "THE:SMELLY:ALLOTMENT", PRT_END

.throwwateronbeanmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,26,8,PRT_PEN+3
EQUB PRT_XY+8,72,  "YOU:THROW:YOUR:BUCKET:OF"
EQUB PRT_XY+13,80, "WATER:ONTO:THE:BEAN",PRT_PEN+5
EQUB PRT_XY+11,88, "YOU:JUMP:CLEAR:AS:THE"
EQUB PRT_XY+10,96, "GROUND:RUMBLES:AND:THE"
EQUB PRT_XY+12,104,"BEANSTALK:SPIRALS:UP"
EQUB PRT_XY+14,112,"THROUGH:THE:CLOUDS",PRT_END

.plantbeanmess
EQUB PRT_PEN+7,PRT_XY+6,48,PRT_DRAWBOX,22,5,PRT_PEN+3
EQUB PRT_XY+12,72,"THIS:TIME:YOU:DECIDE"
EQUB PRT_XY+15,80,"TO:PLANT:THE:BEAN"
EQUB PRT_XY+15,88,"IN:THE:DRY:MANURE"
EQUB PRT_PEN+2,PRT_XY+2,112,PRT_DRAWBOX,16,4,PRT_PEN+6
EQUB PRT_XY+8,136,":>>>:BUT:IT:IS"
EQUB PRT_XY+8,144,"UNABLE:TO:GROW",PRT_END

.pickupmanuremess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,26,5,PRT_PEN+3
EQUB PRT_XY+6,72,"OH@:HOW:DISGUSTING@YOU:TRY"
EQUB PRT_XY+7,80,"TO:PICK:UP:THE:MANURE:BUT"
EQUB PRT_XY+8,88,"IT:SLIPS:FROM:YOUR:HANDS",PRT_END

.roomdata
INCBIN "rooms/room58.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room59
{
EQUW roomdata-room59 ; 0
EQUW roomname-room59 ; 1
EQUW dylantalking-room59 ; 2
EQUW trancemess-room59 ; 3

.roomname
EQUB ":THE:LARGE:OAK:TREE:", PRT_END

.dylantalking
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,18,4,PRT_PEN+6
EQUB PRT_XY+10,72, "&HEY:MAN<:LIKE"
EQUB PRT_XY+7,80, "WHAT;S:HAPPENIN;'",PRT_END

EQUB PRT_PEN+4,PRT_XY+4,96,PRT_DRAWBOX,24,6,PRT_PEN+3
EQUB PRT_XY+10,120,"&PLEASE:HELP:ME:DYLAN<"
EQUB PRT_XY+12,128,"I;M:TRYING:TO:RESCUE"
EQUB PRT_XY+10,136,"DAISY:BUT:I:CAN;T:FIND"
EQUB PRT_XY+14,144,"THE:CLOUD:CASTLE>'",PRT_END

EQUB PRT_PEN+5,PRT_XY+12,72,PRT_DRAWBOX,19,5,PRT_PEN+6
EQUB PRT_XY+18,96, "&IT;S:QUITE:EASY<"
EQUB PRT_XY+18,104,"REMEMBER:HOW:JACK"
EQUB PRT_XY+18,112,"FOUND:THE:CASTLE'"
EQUB PRT_END,PRT_END

.trancemess
EQUB PRT_PEN+7,PRT_XY+4,80,PRT_DRAWBOX,24,4,PRT_PEN+3
EQUB PRT_XY+14,104,"HOW:STRANGE<:DYLAN"
EQUB PRT_XY+9,112,"SEEMS:TO:BE:IN:A:TRANCE",PRT_END

.roomdata
INCBIN "rooms/room59.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room60
{
EQUW roomdata-room60 ; 0
EQUW roomname-room60 ; 1
EQUW fillbucketmess-room60 ; 2

.roomname
EQUB "BASE:OF:THE:VOLCANO:", PRT_END

.fillbucketmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,4,PRT_PEN+3
EQUB PRT_XY+8,72,"YOU:FILL:YOUR:EMPTY"
EQUB PRT_XY+10,80,"BUCKET:WITH:WATER",PRT_END

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
EQUW denziltalking-room68 ; 2
EQUW stereoess-room68 ; 3

.roomname
EQUB "::THE:BANQUET:HALL::", PRT_END

.denziltalking
EQUB PRT_PEN+4,PRT_XY+2,96,PRT_DRAWBOX,26,5,PRT_PEN+3
EQUB PRT_XY+8,120,"&WHAT:ARE:YOU:DOING:HERE"
EQUB PRT_XY+10,128, "DENZIL<:DON;T:YOU:KNOW"
EQUB PRT_XY+12,136, "IT;S:DANGEROUS:HERE'",PRT_END

EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,24,6,PRT_PEN+6
EQUB PRT_XY+9,72,  "&HEY<:STAY:COOL<:DIZ>"
EQUB PRT_XY+10,80, "I:SAW:THE:KING:LEAVE"
EQUB PRT_XY+9,88,  "AND:THOUGHT:I;D:CHECK"
EQUB PRT_XY+15,96,  "OUT:THE:CASTLE'",PRT_END

EQUB PRT_PEN+4,PRT_XY+4,96,PRT_DRAWBOX,24,7,PRT_PEN+3
EQUB PRT_XY+10,120, "&BUT<:DAISY:AND:I:WERE"
EQUB PRT_XY+12,128, "CAUGHT>:I:WAS:THROWN"
EQUB PRT_XY+13,136, "IN:THE:DUNGEONS:AND"
EQUB PRT_XY+11,144, "DAISY;S:BEEN:TAKEN:TO"
EQUB PRT_XY+12,152, "THE:WIZARD;S:CASTLE'",PRT_END

EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,26,7,PRT_PEN+6
EQUB PRT_XY+10,72,"&OH@:WE;D:ALL:WONDERED"
EQUB PRT_XY+9,80, "WHERE:YOU:TWO:HAD:GONE>"
EQUB PRT_XY+11,88,"I;M:TOO:BUSY:TO:HELP<"
EQUB PRT_XY+12,96,"BUT:HERE;S:YOUR:ROPE"
EQUB PRT_XY+9,104,"YOU:LENT:ME:LAST:WEEK>'"

EQUB PRT_END,PRT_END

.stereoess
EQUB PRT_PEN+7,PRT_XY+8,80,PRT_DRAWBOX,19,5,PRT_PEN+3
EQUB PRT_XY+13,104,"DENZIL;S:TURNED:UP"
EQUB PRT_XY+18,112,"HIS:STEREO:UP"
EQUB PRT_XY+16,120,"IS:IGNORING:YOU",PRT_END

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
EQUW notgotallcoins-room73 ; 2
EQUW gotallcoins-room73 ; 3

.roomname
EQUB ":DAISY;S:EMPTY:HUT::", PRT_END

.notgotallcoins
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,21,6,PRT_PEN+6
EQUB PRT_XY+10,72, "&OH@:DIZZY:YOU;RE"
EQUB PRT_XY+8,80,  "SO:BRAVE:AND:CLEVER"
EQUB PRT_XY+9,88,  "AND:NOW:WE:CAN:BUY"
EQUB PRT_XY+9,96,  "THAT:TREE:COTTAGE'",PRT_END

EQUB PRT_PEN+4,PRT_XY+6,112,PRT_DRAWBOX,24,5,PRT_PEN+3
EQUB PRT_XY+12,136, "&ER<:UM<:WELL:ACTUALLY"
EQUB PRT_XY+13,144, "I:WAS:WONDERING:IF:WE"
EQUB PRT_XY+14,152, "NEEDED:ALL:30:COINS'",PRT_END

EQUB PRT_PEN+5,PRT_XY+6,64,PRT_DRAWBOX,21,4,PRT_PEN+6
EQUB PRT_XY+12,88,"&YOU:DISAPPOINT:ME<"
EQUB PRT_XY+14,96, "OF:COURSE:WE:DO@'",PRT_END

EQUB PRT_PEN+7,PRT_XY+8,80,PRT_DRAWBOX,21,5,PRT_PEN+3
EQUB PRT_XY+15,104,"BACK:YOU:GO:DIZZY>"
EQUB PRT_XY+15,112,"SHE;S:A:REAL:SLAVE"
EQUB PRT_XY+13,120,"DRIVER;:BUT:WORTH:IT"
EQUB PRT_END,PRT_END

.gotallcoins
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,24,3,PRT_PEN+6
EQUB PRT_XY+8,72, "&WOW@:YOU;VE:GOT:THEM'",PRT_END

EQUB PRT_PEN+4,PRT_XY+4,128,PRT_DRAWBOX,24,3,PRT_PEN+3
EQUB PRT_XY+10,152, "&WELL<:IT:WAS:NOTHING'",PRT_END

EQUB PRT_PEN+7,PRT_XY+20,88,PRT_DRAWBOX,7,3,PRT_PEN+3
EQUB PRT_XY+26,112,"LIAR@",PRT_END

EQUB PRT_PEN+7,PRT_XY+4,80,PRT_DRAWBOX,23,5,PRT_PEN+3
EQUB PRT_XY+10,104,"AND:SO:WE:SAY:GOODBYE"
EQUB PRT_XY+12,112,"TO:THE:HAPPY:COUPLE"
EQUB PRT_XY+16,120,"UNTIL:>>>>>",PRT_END

EQUB PRT_PEN+7,PRT_XY+8,72,PRT_DRAWBOX,20,10,PRT_PEN+3
EQUB PRT_XY+13,96,"WELL:WHO:KNOWS:WHAT"
EQUB PRT_XY+15,104,"MIGHT:HAPPEN:NEXT",PRT_PEN+4
EQUB PRT_XY+16,120,"WE:HOPE:YOU:HAVE"
EQUB PRT_XY+15,128,"ENJOYED:THIS:GAME",PRT_PEN+2
EQUB PRT_XY+16,140,"THAT;S:ALL:FOLKS",PRT_PEN+5
EQUB PRT_XY+16,152,"THE:OLIVER:TWINS"

EQUB PRT_END,PRT_END

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
EQUW killedbyvolcano-room77 ; 2

.roomname
EQUB ":THE:ACTIVE:VOLCANO:", PRT_END

.killedbyvolcano
EQUB PRT_XY+18,88, "YOU:WERE:BURNT"
EQUB PRT_XY+17,96, "BY:THE:HOT:LAVA"
EQUB PRT_XY+18,104,"IN:THE:VOLCANO"
EQUB PRT_END

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
EQUW knockandentermess-room84 ; 2
EQUW usedoorknockermess-room84 ; 3

.roomname
EQUB "THE:CASTLE:STAIRCASE", PRT_END

.knockandentermess
EQUB PRT_PEN+2,PRT_XY+2,96,PRT_DRAWBOX,17,3,PRT_PEN+6
EQUB PRT_XY+8,120, "KNOCK:AND:ENTER",PRT_END

EQUB PRT_PEN+7,PRT_XY+6,48,PRT_DRAWBOX,22,5,PRT_PEN+3
EQUB PRT_XY+14,72, "THAT;S:EASIER:SAID"	
EQUB PRT_XY+11,80, "THAN:DONE:WHEN:YOU;RE"
EQUB PRT_XY+11,88, "WEARING:BOXING:GLOVES",PRT_END,PRT_END

.usedoorknockermess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,20,5,PRT_PEN+3
EQUB PRT_XY+12,72,"USING:THE:DOOR"
EQUB PRT_XY+8,80,"KNOCKER<:YOU:KNOCK"
EQUB PRT_XY+8,88,"AND:THE:DOOR:OPENS",PRT_END

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
EQUW dougtalking-room88 ; 2
EQUW goonmysonmess-room88 ; 3

.roomname
EQUB ":LIFT:TO:THE:ELDERS:", PRT_END

.dougtalking
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,25,6,PRT_PEN+6
EQUB PRT_XY+9,72, "&AFTERNOON:YOUNG:DIZZY"
EQUB PRT_XY+14,80,"YOU:LOOK:FRANTIC<"
EQUB PRT_XY+8,88, "ANYTHING:YOUR:OLD:GRAND"
EQUB PRT_XY+9,96, "DIZZY:CAN:DO:TO:HELP?'",PRT_END

EQUB PRT_PEN+4,PRT_XY+6,104,PRT_DRAWBOX,24,6,PRT_PEN+3
EQUB PRT_XY+15,128,"&HAVEN;T:YOU:HEARD<"
EQUB PRT_XY+13,136,"DAISY;S:BEING:HELD:IN"
EQUB PRT_XY+14,144,"THE:CLOUD:CASTLE:AND"
EQUB PRT_XY+11,152,"I;M:TRYING:TO:SAVE:HER'",PRT_END

EQUB PRT_PEN+5,PRT_XY+12,48,PRT_DRAWBOX,21,4,PRT_PEN+6
EQUB PRT_XY+18,72,"&JUST:WAIT:HERE:AND"
EQUB PRT_XY+21,80,"I;LL:GET:MY:HAT'",PRT_END

EQUB PRT_PEN+4,PRT_XY+2,96,PRT_DRAWBOX,25,5,PRT_PEN+3
EQUB PRT_XY+9,120,"&WHAT@:WELL:THANKS:FOR"
EQUB PRT_XY+8,128,"OFFERING:TO:HELP<:BUT:I"
EQUB PRT_XY+9,136,"THINK:YOU:SHOULD:STAY'",PRT_END

EQUB PRT_PEN+5,PRT_XY+4,64,PRT_DRAWBOX,24,6,PRT_PEN+6
EQUB PRT_XY+13,88, "&WELL<:IF:YOU:THINK"
EQUB PRT_XY+10,96, "IT;S:BEST<:BUT:PLEASE<"
EQUB PRT_XY+14,104,"TAKE:THIS:CROWBAR>"
EQUB PRT_XY+11,112,"I:REMEMBER:WHEN>>>>>'",PRT_END

EQUB PRT_PEN+7,PRT_XY+6,80,PRT_DRAWBOX,22,5,PRT_PEN+3
EQUB PRT_XY+13,104,"YOU:DECIDE:TO:LEAVE"
EQUB PRT_XY+12,112,"AS:HE:STARTS:TO:TELL"
EQUB PRT_XY+12,120,"YOU:HIS:LIFE:HISTORY",PRT_END

EQUB PRT_END,PRT_END

.goonmysonmess
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,21,5,PRT_PEN+6
EQUB PRT_XY+10,72,"OH:NO@:HE;S:STILL"
EQUB PRT_XY+10,80,"WAFFLING:ON:ABOUT"
EQUB PRT_XY+8,88, "HIS:PAST:ADVENTURES",PRT_END

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
EQUW userugmess-room94 ; 2
EQUW gottodaisymess-room94 ; 3
EQUW daisyrunsmess-room94 ; 4

.roomname
EQUB ":::DAISY;S:PRISON:::", PRT_END

.userugmess
EQUB PRT_PEN+7,PRT_XY+10,80,PRT_DRAWBOX,17,6,PRT_PEN+3
EQUB PRT_XY+18,104,"YOU:THROW:THE"
EQUB PRT_XY+17,112,"RUG:ACROSS:THE"
EQUB PRT_XY+16,120,"DAGGERS<:MAKING"
EQUB PRT_XY+22,128,"THEM:SAFE",PRT_END

.gottodaisymess
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,17,5,PRT_PEN+6
EQUB PRT_XY+8,72,"&OH@:MY:HERO<:I"
EQUB PRT_XY+8,80,"KNEW:YOU;D:COME"
EQUB PRT_XY+9,88,"TO:MY:RESCUE@'",PRT_END

.daisyrunsmess
EQUB PRT_PEN+7,PRT_XY+4,64,PRT_DRAWBOX,24,9,PRT_PEN+3
EQUB PRT_XY+13,88, "WELL<:DAISY:DOESN;T"
EQUB PRT_XY+10,96, "HANG:AROUND<:SHE;S:RUN"
EQUB PRT_XY+11,104,"HOME:AND:WANTS:YOU:TO"
EQUB PRT_XY+9,112, "BRING:HER:30:GOLD:COINS"
EQUB PRT_XY+11,120,"SO:THAT:YOU:CAN:BUY:A"
EQUB PRT_XY+10,128,"HOME:TOGETHER:AND:LIVE"
EQUB PRT_XY+14,136,"HAPPILY:EVER:AFTER",PRT_END

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
{
EQUW roomdata-room101 ; 0
EQUW roomname-room101 ; 1
EQUW deadwindow-room101 ; 2
EQUW killedbyliftmess-room101 ; 3
EQUW killedbyflame-room101 ; 4
EQUW killedbywater-room101 ; 5
EQUW killedbydaggersmess-room101 ; 6
EQUW croceatenmess-room101 ; 7
EQUW obstructingliftmess-room101 ; 8
EQUW dropwhiskeymess-room101 ; 9
EQUW holdingholemess-room101 ; 10
EQUW youfoundcoinmess-room101 ; 11

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.roomname ; DUMMY
EQUB "PICOSONIC 2023", PRT_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Generic dead messages

.deadwindow
EQUB PRT_PEN+6,PRT_XY+10,64,PRT_DRAWBOX,18,6
EQUB PRT_XY+16,112,PRT_PEN+2,"YOU:LOSE:A:LIFE@",PRT_PEN+5,PRT_END

.killedbyliftmess
EQUB PRT_XY+17,88,"YOU:GOT:TRAPPED"
EQUB PRT_XY+18,96,"IN:THE:COGS:ON"
EQUB PRT_XY+17,104,"TOP:OF:THE:LIFT"
EQUB PRT_END

.killedbyflame
EQUB PRT_XY+18,88,"YOU:WERE:BURNT"
EQUB PRT_XY+19,100,"BY:THE:FLAMES"
EQUB PRT_END

.killedbywater
EQUB PRT_XY+17,88, "YOU:FELL:IN:THE"
EQUB PRT_XY+15,100,"WATER:AND:DROWNED"
EQUB PRT_END

.killedbydaggersmess
EQUB PRT_XY+14,88, "YOU;RE:SKEWERED:BY"
EQUB PRT_XY+15,100,"THE:SHARP:DAGGERS"
EQUB PRT_END

.croceatenmess
EQUB PRT_XY+19,88,"THE:GATOR:HAS"
EQUB PRT_XY+19,100,"YOU:FOR:LUNCH"
EQUB PRT_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Generic messages

.obstructingliftmess
EQUB PRT_PEN+2,PRT_XY+14,80,PRT_DRAWBOX,14,4,PRT_PEN+6
EQUB PRT_XY+21,104,"STAND:CLEAR"
EQUB PRT_XY+21,112,"OF:THE:LIFT",PRT_END

.dropwhiskeymess
EQUB PRT_PEN+2,PRT_XY+2,48,PRT_DRAWBOX,14,7,PRT_PEN+6
EQUB PRT_XY+8,72,  "YOU:FIND:THE"
EQUB PRT_XY+9,80,  "WHISKEY:TOO"
EQUB PRT_XY+9,88,  "TEMPTING:TO"
EQUB PRT_XY+9,96,  "DROP:AND:SO"
EQUB PRT_XY+11,104,"DRINK:IT@",PRT_END

.holdingholemess
EQUB PRT_PEN+2,PRT_XY+2,48,PRT_DRAWBOX,16,7,PRT_PEN+6
EQUB PRT_XY+8,72,"WHOOPS@:",PRT_PEN+4,"YOU;VE"
EQUB PRT_XY+9,80,"GOT:A:HOLE:IN"
EQUB PRT_XY+10,88,"YOUR:BAG:AND"
EQUB PRT_XY+8,96,"EVERYTHING:HAS"
EQUB PRT_XY+10,104,"DROPPED:OUT@",PRT_END

.youfoundcoinmess
  EQUB PRT_PEN+5,PRT_XY+16,64,PRT_DRAWBOX,12,5,PRT_PEN+3
  EQUB PRT_XY+22,88,"WELL:DONE@",PRT_PEN+6
  EQUB PRT_XY+23,96,"YOU:FOUND"
  EQUB PRT_XY+26,104,"A:COIN",PRT_END

.roomdata
}

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

SAVE "RMDATA", roomdata_start, roomdata_end
SAVE "RMTABLE", roomtable_start, roomtable_end