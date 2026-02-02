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
EQUB "SPC:OR:FIw:s:oART", PRT_END

.startmess
EQUB PRT_XY+19,49,PRT_PEN+3, "FyTASY:WORLD"

EQUB PRT_XY+24,80,PRT_PEN+2, "oARRd"
EQUB PRT_XY+20,89, "a:YOLKFOLK"
EQUB PRT_XY+20,108,PRT_PEN+5,"D",PRT_XY+22,106,"I",PRT_XY+24,104,"Z"
EQUB PRT_XY+26,102,"Z",PRT_XY+28,100,"Y"

EQUB PRT_XY+35,100,"D",PRT_XY+37,102,"A",PRT_XY+39,104,"I"
EQUB PRT_XY+41,106,"S",PRT_XY+43,108,"Y"

EQUB PRT_XY+9,142, "DrZIL:DYLy"
EQUB PRT_XY+35,136, "DOZY"
EQUB PRT_XY+46,136, "GRc"
EQUB PRT_XY+46,144, "g"
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
EQUB ":a:MARKET:SQUAw::", PRT_END

.shopkeeperappearsmess
EQUB PRT_PEN+7,PRT_XY+2,96,PRT_DRAWBOX,20,5,PRT_PEN+3
EQUB PRT_XY+10,120,"Pd@:>>>:c:AS"
EQUB PRT_XY+10,128,"IF:BY:MAGIC<:a"
EQUB PRT_XY+8,136,"SHOPKEEPt:APPEARS",PRT_END

.givingjunkmess
EQUB PRT_PEN+5,PRT_XY+2,96,PRT_DRAWBOX,25,4,PRT_PEN+6
EQUB PRT_XY+10,120,"&hu:NO:GOOD:s:ME"
EQUB PRT_XY+8,128,"GIV;:US:SOMEki;:ELSE'",PRT_END

.stopgivingjunkmess
EQUB PRT_PEN+5,PRT_XY+2,96,PRT_DRAWBOX,19,4,PRT_PEN+6
EQUB PRT_XY+10,120,"&SsP:GIVi;:US"
EQUB PRT_XY+11,128,"p:h:TRASH'",PRT_END

.thanksforthecowmess
EQUB PRT_PEN+5,PRT_XY+2,80,PRT_DRAWBOX,26,4,PRT_PEN+6
EQUB PRT_XY+8,104,"&G;DAY:DIZ<:AHH@:A:PIGMY"
EQUB PRT_XY+9,112, "COW:hu:iTtEoi;'",PRT_END

.tencoinsmess
EQUB PRT_PEN+4,PRT_XY+10,120,PRT_DRAWBOX,22,4,PRT_PEN+3
EQUB PRT_XY+18,144,"&f<:HOWu:ABxT"
EQUB PRT_XY+15,152,"10:GOLD:COiS:FOR:v'",PRT_END

.nottengoldcoins
EQUB PRT_PEN+5,PRT_XY+18,48,PRT_DRAWBOX,18,5,PRT_PEN+6
EQUB PRT_XY+24,72,"&owWk:MATE<:I"
EQUB PRT_XY+24,80,"SAID:iTtEoi;"
EQUB PRT_XY+27,88,"NOT:VALUABLE'",PRT_END

.fivecoinsmess
EQUB PRT_PEN+4,PRT_XY+2,104,PRT_DRAWBOX,15,4,PRT_PEN+3
EQUB PRT_XY+11,128,"&f<:OK<"
EQUB PRT_XY+8,136,"5:GOLD:COiS'",PRT_END

.notfivegoldcoins
EQUB PRT_PEN+5,PRT_XY+6,72,PRT_DRAWBOX,24,5,PRT_PEN+6
EQUB PRT_XY+13,96, "&BE:StIxS<:v:Ai;T"
EQUB PRT_XY+14,104,"WORk:SPv<:jwu:A"
EQUB PRT_XY+12,112,"BEy<:hu:GrtxS'",PRT_END

.erumbut
EQUB PRT_PEN+4,PRT_XY+16,112,PRT_DRAWBOX,10,4,PRT_PEN+3
EQUB PRT_XY+22,136,"&t<:UM<"
EQUB PRT_XY+22,144,"e:>>>'",PRT_END

.throwsbean
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,11,5,PRT_PEN+6
EQUB PRT_XY+8,72,"&NOW:SsP"
EQUB PRT_XY+8,80,":WAoi;"
EQUB PRT_XY+7,88,":MY:TIME'"
EQUB PRT_PEN+7,PRT_XY+12,112,PRT_DRAWBOX,15,5,PRT_PEN+3
EQUB PRT_XY+18,136,"c:j:kmWS"
EQUB PRT_XY+21,144,":a:BEy"
EQUB PRT_XY+19,152,"q:a:CRATE",PRT_END

.letsfaceitmess
EQUB PRT_PEN+7,PRT_XY+8,80,PRT_DRAWBOX,20,5,PRT_PEN+3
EQUB PRT_XY+15,104,"b:LEAVE:=:LETu"
EQUB PRT_XY+18,112,"FACE:v:g<"
EQUB PRT_XY+15,120,"b:Cy;T:BARTt@",PRT_END,PRT_END

.roomdata
INCBIN "rooms/room22.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room23
{
EQUW roomdata-room23 ; 0
EQUW roomname-room23 ; 1

.roomname
EQUB "A:oRyGE:NEW:WORLD@", PRT_END

.roomdata
INCBIN "rooms/room23.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room24
{
EQUW roomdata-room24 ; 0
EQUW roomname-room24 ; 1

.roomname
EQUB ":iSIDE:a:CHURCH::", PRT_END

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
EQUB "a:AMAZd:ILLUSIq", PRT_END

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
EQUB ":SMUGGLtu:HIDExT:", PRT_END

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
EQUW thanksforloafmess-room36 ; 5

.roomname
EQUB "azbu:DUNGEq", PRT_END

.trollgotapplemess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,13,5,PRT_PEN+3
EQUB PRT_XY+11,72,"b:GIVE"
EQUB PRT_XY+10,80,"a:APPLE"
EQUB PRT_XY+7,88,"s:a:TmLL",PRT_END

EQUB PRT_PEN+5,PRT_XY+16,80,PRT_DRAWBOX,11,5,PRT_PEN+6
EQUB PRT_XY+23,104,"&FOR:ME?"
EQUB PRT_XY+22,112,"b;w:SO"
EQUB PRT_XY+22,120,"GrtxS'",PRT_END

EQUB PRT_PEN+5,PRT_XY+8,48,PRT_DRAWBOX,20,6,PRT_PEN+6
EQUB PRT_XY+16,72,"&I;D:LIKE:s:LET"
EQUB PRT_XY+16,80,"b:PASS<:e:IF"
EQUB PRT_XY+14,88,"a:Kd:FxND:xT"
EQUB PRT_XY+15,96,"j;D:sRTUw:ME@'",PRT_END

EQUB PRT_PEN+5,PRT_XY+6,112,PRT_DRAWBOX,22,5,PRT_PEN+6
EQUB PRT_XY+13,136,"&HOWEVt<:b:CxLD"
EQUB PRT_XY+14,144,"ESCAPE:kRxGH:a"
EQUB PRT_XY+11,152,"FIw:USd:a:zc'",PRT_END,PRT_END

.throwwateronfiremess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,6,PRT_PEN+3
EQUB PRT_XY+10,72, "b:kmW:a:JUG"
EQUB PRT_XY+10,80,"OF:zc:qs:a"
EQUB PRT_XY+8,88, "FIw:c:a:FLAMES"
EQUB PRT_XY+7,96, "Aw:QUICKLY:QUrCjD",PRT_END

.getbackintheremess
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,21,4,PRT_PEN+6
EQUB PRT_XY+10,72,  "&OY@:Wjw:DO:b"
EQUB PRT_XY+7,80,  "kiK:b;w:GOd@'",PRT_END

.thanksforloafmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,18,5,PRT_PEN+3
EQUB PRT_XY+8,72, "a:RAVrxS:RAT"
EQUB PRT_XY+11,80,"EATS:a:LOAF"
EQUB PRT_XY+11,88,"c:RUNS:AWAY",PRT_END

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
EQUB "GOd:DOWN:a:f@", PRT_END

.roomdata
INCBIN "rooms/room39.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room40
{
EQUW roomdata-room40 ; 0
EQUW roomname-room40 ; 1
EQUW puteggbackmess-room40 ; 2

.roomname
EQUB ":a:zau:LAIR::", PRT_END

.puteggbackmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,20,6,PRT_PEN+3
EQUB PRT_XY+11,72,"b:PUT:a:EGG"
EQUB PRT_XY+8,80, "BACK:is:a:NEo"
EQUB PRT_XY+12,88,"c:a:za"
EQUB PRT_XY+8,96, "pOWS:b:s:PASS",PRT_END

.roomdata
INCBIN "rooms/room40.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room41
{
EQUW roomdata-room41 ; 0
EQUW roomname-room41 ; 1
EQUW usepickaxemess-room41 ; 2
EQUW goawaymess-room41 ; 3

.roomname
EQUB ":a:DEStTED:MiES:", PRT_END

.usepickaxemess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,22,4,PRT_PEN+3
EQUB PRT_XY+9,72,"b:USE:a:PICKAXE"
EQUB PRT_XY+8,80,"s:BwAK:UP:a:mCK",PRT_END

.goawaymess
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,26,5,PRT_PEN+6
EQUB PRT_XY+10,72,"&OH:NO@:NOT:b:AGAi>"
EQUB PRT_XY+12,80, "GO:AWAY>:I;M:HIDd<"
EQUB PRT_XY+8,88, "c:vu:p:bR:FAULT'",PRT_END

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
EQUW dooytalking-room45 ; 2
EQUW kickdooyagainmess-room45 ; 3
EQUW pushdooymess-room45 ; 4

.roomname
EQUB ":LOOKd:xT:s:SEA:", PRT_END

.dooytalking
EQUB PRT_PEN+4,PRT_XY+30,48,PRT_DRAWBOX,12,4,PRT_PEN+3
EQUB PRT_XY+36,72, "&jY@:DOZY"
EQUB PRT_XY+38,80, "GET:UP@'",PRT_END

EQUB PRT_PEN+7,PRT_XY+2,80,PRT_DRAWBOX,16,5,PRT_PEN+3
EQUB PRT_XY+10,104,"b:KICK:a"
EQUB PRT_XY+8,112, "DECK:CHAIR:c"
EQUB PRT_XY+11,120,"j:WAKES:UP",PRT_END

EQUB PRT_PEN+5,PRT_XY+12,112,PRT_DRAWBOX,17,4,PRT_PEN+6
EQUB PRT_XY+18,136,"&OH@:WHATu:a"
EQUB PRT_XY+20,144,"PmBLEM:g'",PRT_END

EQUB PRT_PEN+4,PRT_XY+2,48,PRT_DRAWBOX,26,7,PRT_PEN+3
EQUB PRT_XY+9,72,  "&lu:BEr:EGGNAPPED"
EQUB PRT_XY+8,80,  "c:IS:BEd:jLD:i:a"
EQUB PRT_XY+10,88, "WIZARDu:nzb<"
EQUB PRT_XY+12,96, "c:NOBODY:WILL:jLP"
EQUB PRT_XY+17,104,"ME:wSCUE:jR@'",PRT_END

EQUB PRT_PEN+5,PRT_XY+2,88,PRT_DRAWBOX,14,6,PRT_PEN+6
EQUB PRT_XY+8 ,112,"&AHH<:hu"
EQUB PRT_XY+11,120,"BAD:LUCK>"
EQUB PRT_XY+11,128,"I;LL:jLP"
EQUB PRT_XY+10,136, "b:g'",PRT_END

EQUB PRT_PEN+5,PRT_XY+18,112,PRT_DRAWBOX,18,5,PRT_PEN+6
EQUB PRT_XY+28,136,"&jwu:SOME"
EQUB PRT_XY+24,144,"SLEEPd:POTIq<"
EQUB PRT_XY+23,152,"h:SHxLD:jLP'",PRT_END

EQUB PRT_PEN+4,PRT_XY+2,120,PRT_DRAWBOX,17,4,PRT_PEN+3
EQUB PRT_XY+10,144,"&e:I;D:LIKE"
EQUB PRT_XY+8,152,"b:s:jLP:ME'",PRT_END

EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,16,7,PRT_PEN+6
EQUB PRT_XY+9,72,"&SORRY:g<"
EQUB PRT_XY+10,80,"LOVE:s<:e"
EQUB PRT_XY+10,88,"vu:FAR:sO"
EQUB PRT_XY+9,96, "NICE:A:DAY:s"
EQUB PRT_XY+7,104,"wSCUE:MAIDrS'",PRT_END

EQUB PRT_PEN+7,PRT_XY+8,80,PRT_DRAWBOX,20,5,PRT_PEN+3
EQUB PRT_XY+14,104,"I:Dq;T:kiK:ju"
EQUB PRT_XY+14,112,"GOd:s:jLP<:c"
EQUB PRT_XY+14,120,"ju:Fpr:ASLEEP",PRT_END,PRT_END

.kickdooyagainmess
EQUB PRT_PEN+7,PRT_XY+10,80,PRT_DRAWBOX,17,4,PRT_PEN+3
EQUB PRT_XY+18,104,"b:KICK:DOZY"
EQUB PRT_XY+16,112,"e:ju:ASLEEP",PRT_END

.pushdooymess
EQUB PRT_PEN+7,PRT_XY+6,72,PRT_DRAWBOX,22,6,PRT_PEN+3
EQUB PRT_XY+14,96,"WHOOPS@:b:KICKED"
EQUB PRT_XY+13,104,"sO:HARD:c:DOZYu"
EQUB PRT_XY+11,112,"Fpr:is:a:zc"
EQUB PRT_XY+11,120,"c:ju:oILL:ASLEEP",PRT_END

.roomdata
INCBIN "rooms/room45.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room46
{
EQUW roomdata-room46 ; 0
EQUW roomname-room46 ; 1

.roomname
EQUB ":a:DOCKS:c:PIt:", PRT_END

.roomdata
INCBIN "rooms/room46.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room47
{
EQUW roomdata-room47 ; 0
EQUW roomname-room47 ; 1

.roomname
EQUB ":FxRWAY:WAwHxSE::", PRT_END

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
EQUB ":a:BmKr:BRIDGE::", PRT_END

.rockinwatermess
EQUB PRT_PEN+7,PRT_XY+2,112,PRT_DRAWBOX,26,5,PRT_PEN+3
EQUB PRT_XY+6,136,"b:PUSH:a:mCK:is:a"
EQUB PRT_XY+6,144,"RIVt:c:v:DISPLACES:a"
EQUB PRT_XY+8,152,"zc<:RAISd:a:LEVEL",PRT_END

.roomdata
INCBIN "rooms/room48.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room49
{
EQUW roomdata-room49 ; 0
EQUW roomname-room49 ; 1

.roomname
EQUB "::a:GUARD:HxSE:::", PRT_END

.roomdata
INCBIN "rooms/room49.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room50
{
EQUW roomdata-room50 ; 0
EQUW roomname-room50 ; 1
EQUW fedarmorog-room50 ; 2

.roomname
EQUB ":::ARMOmGu:Dr::::", PRT_END

.fedarmorog
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,18,4,PRT_PEN+3
EQUB PRT_XY+8,72,"h:BqE:SHxLD"
EQUB PRT_XY+10,80,"KEEP:HIM:BUSY@",PRT_END

.roomdata
INCBIN "rooms/room50.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room51
{
EQUW roomdata-room51 ; 0
EQUW roomname-room51 ; 1
EQUW throwswitchmess-room51 ; 2

.roomname
EQUB "MOAT:c:PORTCULLIS:", PRT_END

.throwswitchmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,15,5,PRT_PEN+3
EQUB PRT_XY+8,72,"b:kmW:a"
EQUB PRT_XY+8,80,"LEVt:s:;q;"
EQUB PRT_XY+8,88,"e:v:BwAKS",PRT_END

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
EQUB ":a:rTRyCE:Hp::", PRT_END

;.lookatpicturemess
;EQUB PRT_PEN+7,PRT_XY+2,96,PRT_DRAWBOX,23,6,PRT_PEN+3
;EQUB PRT_XY+11,120, "b:LOOK:UP:AT:a"
;EQUB PRT_XY+9,128,  "PICTUw>:vu:b:i"
;EQUB PRT_XY+10,136, "bR:LAo:ADVrTUw",PRT_PEN+5
;EQUB PRT_XY+8,144,  "TwASUw:ISLc:g",PRT_END

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
EQUB "a:SNAP:HAPPY:GAsR", PRT_END

.croctiedmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,19,5,PRT_PEN+3
EQUB PRT_XY+11,72,"b:NIMBLY:TIE"
EQUB PRT_XY+10,80,"a:mPE:ARxND"
EQUB PRT_XY+8,88, "a:GAsRu:SNxT",PRT_END

.roomdata
INCBIN "rooms/room53.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room54
{
EQUW roomdata-room54 ; 0
EQUW roomname-room54 ; 1
EQUW dragonasleepmess-room54 ; 2

.roomname
EQUB "a:WIDE=EYED:za", PRT_END

.dragonasleepmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,6,PRT_PEN+3
EQUB PRT_XY+8,72,"b:SMASH:a:FLASK"
EQUB PRT_XY+10,80,"OF:POTIq:c:a"
EQUB PRT_XY+9,88,"za:iHALES:a"
EQUB PRT_XY+8,96,"isXICATd:VAPxR",PRT_END

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
EQUB "a:BOTsMLESS:f:", PRT_END

.usecrowbarmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,19,5,PRT_PEN+3
EQUB PRT_XY+8,72,"USd:a:CmWBAR"
EQUB PRT_XY+8,80,"b:FORCE:a:LID"
EQUB PRT_XY+13,88,"OFF:a:f",PRT_END

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
EQUB "a:LIFT:CqTmL:HUT", PRT_END

.keyinmachine
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,24,5,PRT_PEN+3
EQUB PRT_XY+8,72,"b:TRY:a:KEY:i:a"
EQUB PRT_XY+13,80,"LOCK:c:v:FvS@"
EQUB PRT_XY+8,88,"SO:b:TURN:v:s:;q;",PRT_END

.roomdata
INCBIN "rooms/room56.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room57
{
EQUW roomdata-room57 ; 0
EQUW roomname-room57 ; 1

.roomname
EQUB ":BASE:OF:TwE:HxSE:", PRT_END

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
EQUB "a:SMELLY:pOTMrT", PRT_END

.throwwateronbeanmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,26,8,PRT_PEN+3
EQUB PRT_XY+8,72,  "b:kmW:bR:BUCKET:OF"
EQUB PRT_XY+13,80, "zc:qs:a:BEy",PRT_PEN+5
EQUB PRT_XY+11,88, "b:JUMP:CLEAR:AS:a"
EQUB PRT_XY+10,96, "GRxND:RUMBLES:c:a"
EQUB PRT_XY+12,104,"BEyoALK:SPIRALS:UP"
EQUB PRT_XY+14,112,"kRxGH:a:nS",PRT_END

.plantbeanmess
EQUB PRT_PEN+7,PRT_XY+6,48,PRT_DRAWBOX,22,5,PRT_PEN+3
EQUB PRT_XY+12,72,"kIS:TIME:b:DECIDE"
EQUB PRT_XY+15,80,"s:PLyT:a:BEy"
EQUB PRT_XY+15,88,"i:a:DRY:MyUw"
EQUB PRT_PEN+2,PRT_XY+2,112,PRT_DRAWBOX,16,4,PRT_PEN+6
EQUB PRT_XY+8,136,":>>>:e:v:IS"
EQUB PRT_XY+8,144,"UNABLE:s:GmW",PRT_END

.pickupmanuremess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,26,5,PRT_PEN+3
EQUB PRT_XY+6,72,"OH@:HOW:DISGUod@b:TRY"
EQUB PRT_XY+7,80,"s:PICK:UP:a:MyUw:e"
EQUB PRT_XY+8,88,"v:SLIPS:FmM:bR:HcS",PRT_END

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
EQUB ":a:LARGE:OAK:TwE:", PRT_END

.dylantalking
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,18,4,PRT_PEN+6
EQUB PRT_XY+10,72, "&jY:My<:LIKE"
EQUB PRT_XY+7,80, "WHATu:HAPPri;'",PRT_END

EQUB PRT_PEN+4,PRT_XY+4,96,PRT_DRAWBOX,24,6,PRT_PEN+3
EQUB PRT_XY+10,120,"&PLEASE:jLP:ME:DYLy<"
EQUB PRT_XY+12,128,"I;M:TRYd:s:wSCUE"
EQUB PRT_XY+10,136,"l:e:I:Cy;T:FiD"
EQUB PRT_XY+14,144,"a:nzb>'",PRT_END

EQUB PRT_PEN+5,PRT_XY+12,72,PRT_DRAWBOX,19,5,PRT_PEN+6
EQUB PRT_XY+18,96, "&vu:QUvE:EASY<"
EQUB PRT_XY+18,104,"wMEMBt:HOW:JACK"
EQUB PRT_XY+18,112,"FxND:azb'"
EQUB PRT_END,PRT_END

.trancemess
EQUB PRT_PEN+7,PRT_XY+4,80,PRT_DRAWBOX,24,4,PRT_PEN+3
EQUB PRT_XY+14,104,"HOW:oRyGE<:DYLy"
EQUB PRT_XY+9,112,"SEEMS:s:BE:i:A:TRyCE",PRT_END

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
EQUB "BASE:OF:a:VOLCyO:", PRT_END

.fillbucketmess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,4,PRT_PEN+3
EQUB PRT_XY+8,72,"b:FILL:bR:EMPTY"
EQUB PRT_XY+10,80,"BUCKET:WvH:zc",PRT_END

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
EQUB "::a:CRAFTY:n::", PRT_END

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
EQUB ":::a:WEo:Wd::::", PRT_END

.roomdata
INCBIN "rooms/room67.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room68
{
EQUW roomdata-room68 ; 0
EQUW roomname-room68 ; 1
EQUW denoiltalking-room68 ; 2
EQUW stereoess-room68 ; 3

.roomname
EQUB "::a:ByQUET:Hp::", PRT_END

.denoiltalking
EQUB PRT_PEN+4,PRT_XY+2,96,PRT_DRAWBOX,26,5,PRT_PEN+3
EQUB PRT_XY+8,120,"&WHAT:Aw:b:DOd:jw"
EQUB PRT_XY+10,128, "DrZIL<:Dq;T:b:KNOW"
EQUB PRT_XY+12,136, "vu:DyGtxS:jw'",PRT_END

EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,24,6,PRT_PEN+6
EQUB PRT_XY+9,72,  "&jY<:oAY:COOL<:DIZ>"
EQUB PRT_XY+10,80, "I:SAW:a:Kd:LEAVE"
EQUB PRT_XY+9,88,  "c:kxGHT:I;D:CjCK"
EQUB PRT_XY+15,96,  "xT:azb'",PRT_END

EQUB PRT_PEN+4,PRT_XY+4,96,PRT_DRAWBOX,24,7,PRT_PEN+3
EQUB PRT_XY+10,120, "&e<:l:c:I:WtE"
EQUB PRT_XY+12,128, "CAUGHT>:I:WAS:kmWN"
EQUB PRT_XY+13,136, "i:a:DUNGEqS:c"
EQUB PRT_XY+11,144, "lu:BEr:TAKr:s"
EQUB PRT_XY+12,152, "a:WIZARDuzb'",PRT_END

EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,26,7,PRT_PEN+6
EQUB PRT_XY+10,72,"&OH@:WE;D:p:WqDtED"
EQUB PRT_XY+9,80, "Wjw:b:TWO:HAD:GqE>"
EQUB PRT_XY+11,88,"I;M:sO:BUSY:s:jLP<"
EQUB PRT_XY+12,96,"e:jwu:bR:mPE"
EQUB PRT_XY+9,104,"b:LrT:ME:LAo:WEEK>'"

EQUB PRT_END,PRT_END

.stereoess
EQUB PRT_PEN+7,PRT_XY+8,80,PRT_DRAWBOX,19,5,PRT_PEN+3
EQUB PRT_XY+13,104,"DrZILu:TURNED:UP"
EQUB PRT_XY+18,112,"HIS:otEO:UP"
EQUB PRT_XY+16,120,"IS:IGNORd:b",PRT_END

.roomdata
INCBIN "rooms/room68.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room69
{
EQUW roomdata-room69 ; 0
EQUW roomname-room69 ; 1

.roomname
EQUB ":::a:EAo:Wd::::", PRT_END

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
EQUB "KEEP:xT@:DOZYu:HUT", PRT_END

.roomdata
INCBIN "rooms/room71.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room72
{
EQUW roomdata-room72 ; 0
EQUW roomname-room72 ; 1

.roomname
EQUB "::::DrZILu:PAD::::", PRT_END

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
EQUB ":lu:EMPTY:HUT::", PRT_END

.notgotallcoins
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,21,6,PRT_PEN+6
EQUB PRT_XY+10,72, "&OH@:g:b;w"
EQUB PRT_XY+8,80,  "SO:BRAVE:c:CLEVt"
EQUB PRT_XY+9,88,  "c:NOW:WE:Cy:BUY"
EQUB PRT_XY+9,96,  "h:TwE:COTTAGE'",PRT_END

EQUB PRT_PEN+4,PRT_XY+6,112,PRT_DRAWBOX,24,5,PRT_PEN+3
EQUB PRT_XY+12,136, "&t<:UM<:f:ACTUpY"
EQUB PRT_XY+13,144, "I:WAS:WqDtd:IF:WE"
EQUB PRT_XY+14,152, "NEEDED:p:30:COiS'",PRT_END

EQUB PRT_PEN+5,PRT_XY+6,64,PRT_DRAWBOX,21,4,PRT_PEN+6
EQUB PRT_XY+12,88,"&b:DISAPPOiT:ME<"
EQUB PRT_XY+14,96, "OF:CxRSE:WE:DO@'",PRT_END

EQUB PRT_PEN+7,PRT_XY+8,80,PRT_DRAWBOX,21,5,PRT_PEN+3
EQUB PRT_XY+15,104,"BACK:b:GO:g>"
EQUB PRT_XY+15,112,"Sju:A:wAL:SLAVE"
EQUB PRT_XY+13,120,"DRIVt;:e:WORk:v"
EQUB PRT_END,PRT_END

.gotallcoins
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,24,3,PRT_PEN+6
EQUB PRT_XY+8,72, "&WOW@:b;VE:GOT:aM'",PRT_END

EQUB PRT_PEN+4,PRT_XY+4,128,PRT_DRAWBOX,24,3,PRT_PEN+3
EQUB PRT_XY+10,152, "&f<:v:WAS:NOkd'",PRT_END

EQUB PRT_PEN+7,PRT_XY+20,88,PRT_DRAWBOX,7,3,PRT_PEN+3
EQUB PRT_XY+26,112,"LIAR@",PRT_END

EQUB PRT_PEN+7,PRT_XY+4,80,PRT_DRAWBOX,23,5,PRT_PEN+3
EQUB PRT_XY+10,104,"c:SO:WE:SAY:GOODBYE"
EQUB PRT_XY+12,112,"s:a:HAPPY:CxPLE"
EQUB PRT_XY+16,120,"UNTIL:>>>>>",PRT_END

EQUB PRT_PEN+7,PRT_XY+8,72,PRT_DRAWBOX,20,10,PRT_PEN+3
EQUB PRT_XY+13,96,"f:WHO:KNOWS:WHAT"
EQUB PRT_XY+15,104,"MIGHT:HAPPr:NEXT",PRT_PEN+4
EQUB PRT_XY+16,120,"WE:HOPE:b:HAVE"
EQUB PRT_XY+15,128,"rJOYED:kIS:GAME",PRT_PEN+2
EQUB PRT_XY+16,140,"hu:p:FOLKS",PRT_PEN+5
EQUB PRT_XY+16,152,"a:OLIVt:TWiS"

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
EQUB "a:GIyT:BEyoALK:", PRT_END

.roomdata
INCBIN "rooms/room74.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room75
{
EQUW roomdata-room75 ; 0
EQUW roomname-room75 ; 1

.roomname
EQUB "COMPLEX:n:RxTE:", PRT_END

.roomdata
INCBIN "rooms/room75.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room76
{
EQUW roomdata-room76 ; 0
EQUW roomname-room76 ; 1

.roomname
EQUB "NEAR:a:VOLCyO:sP", PRT_END

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
EQUB ":a:ACTIVE:VOLCyO:", PRT_END

.killedbyvolcano
EQUB PRT_XY+18,88, "b:WtE:BURNT"
EQUB PRT_XY+17,96, "BY:a:HOT:LAVA"
EQUB PRT_XY+18,104,"i:a:VOLCyO"
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
EQUB ":::a:WEo:sWt:::", PRT_END

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
EQUB "azb:oAIRCASE", PRT_END

.knockandentermess
EQUB PRT_PEN+2,PRT_XY+2,96,PRT_DRAWBOX,17,3,PRT_PEN+6
EQUB PRT_XY+8,120, "KNOCK:c:rTt",PRT_END

EQUB PRT_PEN+7,PRT_XY+6,48,PRT_DRAWBOX,22,5,PRT_PEN+3
EQUB PRT_XY+14,72, "hu:EASIt:SAID"
EQUB PRT_XY+11,80, "ky:DqE:WjN:b;w"
EQUB PRT_XY+11,88, "WEARd:BOXd:GLOVES",PRT_END,PRT_END

.usedoorknockermess
EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,20,5,PRT_PEN+3
EQUB PRT_XY+12,72,"USd:a:DOOR"
EQUB PRT_XY+8,80,"KNOCKt<:b:KNOCK"
EQUB PRT_XY+8,88,"c:a:DOOR:OPrS",PRT_END

.roomdata
INCBIN "rooms/room84.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room85
{
EQUW roomdata-room85 ; 0
EQUW roomname-room85 ; 1

.roomname
EQUB ":::a:EAo:sWt:::", PRT_END

.roomdata
INCBIN "rooms/room85.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room86
{
EQUW roomdata-room86 ; 0
EQUW roomname-room86 ; 1

.roomname
EQUB ":a:LqGJUMP:n:", PRT_END

.roomdata
INCBIN "rooms/room86.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room87
{
EQUW roomdata-room87 ; 0
EQUW roomname-room87 ; 1

.roomname
EQUB "::a:MEETd:Hp::", PRT_END

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
EQUB ":LIFT:s:a:ELDtS:", PRT_END

.dougtalking
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,25,6,PRT_PEN+6
EQUB PRT_XY+9,72, "&AFTtNOq:bNG:g"
EQUB PRT_XY+14,80,"b:LOOK:FRyTIC<"
EQUB PRT_XY+8,88, "yYkd:bR:OLD:GRc"
EQUB PRT_XY+9,96, "g:Cy:DO:s:jLP?'",PRT_END

EQUB PRT_PEN+4,PRT_XY+6,104,PRT_DRAWBOX,24,6,PRT_PEN+3
EQUB PRT_XY+15,128,"&HAVr;T:b:jARD<"
EQUB PRT_XY+13,136,"lu:BEd:jLD:i"
EQUB PRT_XY+14,144,"a:nzb:c"
EQUB PRT_XY+11,152,"I;M:TRYd:s:SAVE:jR'",PRT_END

EQUB PRT_PEN+5,PRT_XY+12,48,PRT_DRAWBOX,21,4,PRT_PEN+6
EQUB PRT_XY+18,72,"&JUo:WAv:jw:c"
EQUB PRT_XY+21,80,"I;LL:GET:MY:HAT'",PRT_END

EQUB PRT_PEN+4,PRT_XY+2,96,PRT_DRAWBOX,25,5,PRT_PEN+3
EQUB PRT_XY+9,120,"&WHAT@:f:kyKS:FOR"
EQUB PRT_XY+8,128,"OFFtd:s:jLP<:e:I"
EQUB PRT_XY+9,136,"kiK:b:SHxLD:oAY'",PRT_END

EQUB PRT_PEN+5,PRT_XY+4,64,PRT_DRAWBOX,24,6,PRT_PEN+6
EQUB PRT_XY+13,88, "&f<:IF:b:kiK"
EQUB PRT_XY+10,96, "vu:BEo<:e:PLEASE<"
EQUB PRT_XY+14,104,"TAKE:kIS:CmWBAR>"
EQUB PRT_XY+11,112,"I:wMEMBt:WjN>>>>>'",PRT_END

EQUB PRT_PEN+7,PRT_XY+6,80,PRT_DRAWBOX,22,5,PRT_PEN+3
EQUB PRT_XY+13,104,"b:DECIDE:s:LEAVE"
EQUB PRT_XY+12,112,"AS:j:oARTS:s:TELL"
EQUB PRT_XY+12,120,"b:HIS:LIFE:HISsRY",PRT_END

EQUB PRT_END,PRT_END

.goonmysonmess
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,21,5,PRT_PEN+6
EQUB PRT_XY+10,72,"OH:NO@:ju:oILL"
EQUB PRT_XY+10,80,"WAFFLd:q:ABxT"
EQUB PRT_XY+8,88, "HIS:PAo:ADVrTUwS",PRT_END

.roomdata
INCBIN "rooms/room88.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room89
{
EQUW roomdata-room89 ; 0
EQUW roomname-room89 ; 1

.roomname
EQUB "gu:PARrTS:HUT:", PRT_END

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
EQUB "::YET:MOw:nS:::", PRT_END

.roomdata
INCBIN "rooms/room91.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room92
{
EQUW roomdata-room92 ; 0
EQUW roomname-room92 ; 1

.roomname
EQUB "MOw:;ORRIBLE:nS", PRT_END

.roomdata
INCBIN "rooms/room92.bin"
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.room93
{
EQUW roomdata-room93 ; 0
EQUW roomname-room93 ; 1

.roomname
EQUB "::a:nzb::", PRT_END

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
EQUB ":::lu:PRISq:::", PRT_END

.userugmess
EQUB PRT_PEN+7,PRT_XY+10,80,PRT_DRAWBOX,17,6,PRT_PEN+3
EQUB PRT_XY+18,104,"b:kmW:a"
EQUB PRT_XY+17,112,"RUG:ACmSS:a"
EQUB PRT_XY+16,120,"DAGGtS<:MAKd"
EQUB PRT_XY+22,128,"aM:SAFE",PRT_END

.gottodaisymess
EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,17,5,PRT_PEN+6
EQUB PRT_XY+8,72,"&OH@:MY:jm<:I"
EQUB PRT_XY+8,80,"KNEW:b;D:COME"
EQUB PRT_XY+9,88,"s:MY:wSCUE@'",PRT_END

.daisyrunsmess
EQUB PRT_PEN+7,PRT_XY+4,64,PRT_DRAWBOX,24,9,PRT_PEN+3
EQUB PRT_XY+13,88, "f<:l:DOESN;T"
EQUB PRT_XY+10,96, "HyG:ARxND<:Sju:RUN"
EQUB PRT_XY+11,104,"HOME:c:WyTS:b:s"
EQUB PRT_XY+9,112, "BRd:jR:30:GOLD:COiS"
EQUB PRT_XY+11,120,"SO:h:b:Cy:BUY:A"
EQUB PRT_XY+10,128,"HOME:sGEaR:c:LIVE"
EQUB PRT_XY+14,136,"HAPPILY:EVt:AFTt",PRT_END

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
EQUB ":::::a:ATTIC::::::", PRT_END

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
EQUW killedbyhawk-room101 ; 7
EQUW croceatenmess-room101 ; 8
EQUW killedbyportcullis-room101 ; 9
EQUW ratgotyoumess-room101 ; 10
EQUW armorogkilledmess-room101 ; 11
EQUW dragonkilledmess-room101 ; 12
EQUW dragonflameskilledmess-room101 ; 13
EQUW obstructingliftmess-room101 ; 14
EQUW dropwhiskeymess-room101 ; 15
EQUW holdingholemess-room101 ; 16
EQUW youfoundcoinmess-room101 ; 17

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.roomname ; DUMMY
EQUB "PICOSONIC 2026", PRT_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Generic dead messages

.deadwindow
EQUB PRT_PEN+6,PRT_XY+10,64,PRT_DRAWBOX,18,6
EQUB PRT_XY+16,112,PRT_PEN+2,"b:LOSE:A:LIFE@",PRT_PEN+5,PRT_END

.killedbyliftmess
EQUB PRT_XY+17,88,"b:GOT:TRAPPED"
EQUB PRT_XY+18,96,"i:a:COGS:q"
EQUB PRT_XY+17,104,"sP:OF:a:LIFT"
EQUB PRT_END

.killedbyflame
EQUB PRT_XY+18,88,"b:WtE:BURNT"
EQUB PRT_XY+19,100,"BY:a:FLAMES"
EQUB PRT_END

.killedbywater
EQUB PRT_XY+17,88, "b:FELL:i:a"
EQUB PRT_XY+15,100,"zc:c:DmWNED"
EQUB PRT_END

.killedbydaggersmess
EQUB PRT_XY+14,88, "b;w:SKEWtED:BY"
EQUB PRT_XY+15,100,"a:SHARP:DAGGtS"
EQUB PRT_END

.croceatenmess
EQUB PRT_XY+19,88,"a:GAsR:HAS"
EQUB PRT_XY+19,100,"b:FOR:LUNCH"
EQUB PRT_END

.killedbyportcullis
EQUB PRT_XY+16,88,"b:WtE:oABBED"
EQUB PRT_XY+16,96,"BY:a:SPIKES:OF"
EQUB PRT_XY+18,104,"a:PORTCULLIS"
EQUB PRT_END

.killedbyhawk
EQUB PRT_XY+18,88,"a:g:HAWK"
EQUB PRT_XY+21,96,"SWOOPS:DOWN"
EQUB PRT_XY+19,104,"c:KILLS:b"
EQUB PRT_END

.ratgotyoumess
EQUB PRT_XY+20,88,"a:RAT:GOES"
EQUB PRT_XY+20,96,"oRAIGHT:FOR"
EQUB PRT_XY+23,104,"bR:NECK"
EQUB PRT_END

.armorogkilledmess
EQUB PRT_XY+18,88,"ARMOmG:CAUGHT"
EQUB PRT_XY+17,100,"b:TwSPASSd"
EQUB PRT_END

.dragonkilledmess
EQUB PRT_XY+16,88, "a:za:BvES"
EQUB PRT_XY+16,96, "b:c:b:KEEL"
EQUB PRT_XY+20,104,"OVt:c:DIE"
EQUB PRT_END

.dragonflameskilledmess
EQUB PRT_XY+17,88, "b:Aw:mAoED"
EQUB PRT_XY+17,96, "BY:a:zau"
EQUB PRT_XY+20,104,"FItY:BwAk"
EQUB PRT_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;Generic messages

.obstructingliftmess
EQUB PRT_PEN+2,PRT_XY+14,80,PRT_DRAWBOX,14,4,PRT_PEN+6
EQUB PRT_XY+21,104,"oc:CLEAR"
EQUB PRT_XY+21,112,"OF:a:LIFT",PRT_END

.dropwhiskeymess
EQUB PRT_PEN+2,PRT_XY+2,48,PRT_DRAWBOX,14,7,PRT_PEN+6
EQUB PRT_XY+8,72,  "b:FiD:a"
EQUB PRT_XY+9,80,  "WHISKEY:sO"
EQUB PRT_XY+9,88,  "TEMPTd:s"
EQUB PRT_XY+9,96,  "DmP:c:SO"
EQUB PRT_XY+11,104,"DRiK:v@",PRT_END

.holdingholemess
EQUB PRT_PEN+2,PRT_XY+2,48,PRT_DRAWBOX,16,7,PRT_PEN+6
EQUB PRT_XY+8,72,"WHOOPS@:",PRT_PEN+4,"b;VE"
EQUB PRT_XY+9,80,"GOT:A:HOLE:i"
EQUB PRT_XY+10,88,"bR:BAG:c"
EQUB PRT_XY+8,96,"EVtYkd:HAS"
EQUB PRT_XY+10,104,"DmPPED:xT@",PRT_END

.youfoundcoinmess
EQUB PRT_PEN+5,PRT_XY+16,64,PRT_DRAWBOX,12,5,PRT_PEN+3
EQUB PRT_XY+22,88,"f:DqE@",PRT_PEN+6
EQUB PRT_XY+23,96,"b:FxND"
EQUB PRT_XY+26,104,"A:COi",PRT_END

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
