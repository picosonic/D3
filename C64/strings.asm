; String table pointers
.roomnames
  EQUW room0 ,room1 ,room2 ,room3 ,room4 ,room5 ,room6 ,room7
  EQUW room8 ,room9 ,room10,room11,room12,room13,room14,room15
  EQUW room16,room17,room18,room19,room20,room21,room22,room23
  EQUW room24,room25,room26,room27,room28,room29,room30,room31
  EQUW room32,room33,room34,room35,room36,room37,room38,room39
  EQUW room40,room41,room42,room43,room44,room45,room46,room47
  EQUW room48,room49,room50,room51,room52,room53,room54,room55
  EQUW room56,room57,room58,room59,room60,room61,room62,room63
  EQUW room64,room65,room66,room67,room68,room69,room70,room71
  EQUW room72,room73,room74,room75,room76,room77,room78,room79
  EQUW room80,room81,room82,room83,room84,room85,room86,room87
  EQUW room88,room89,room90,room91,room92,room93,room94,room95
  EQUW room96,room97,room98,room99,room100

  EQUW bagmess
  EQUW greenbeanmess

  EQUW &0000

  EQUW crowbarmess
  EQUW mtbucketmess
  EQUW bonemess
  EQUW pigmycowmess

  EQUW &0000

  EQUW pickaxemess
  EQUW goldeneggmess
  EQUW blackholemess
  EQUW rugmess
  EQUW keymess, keymess, keymess, keymess
  EQUW ropemess
  EQUW sleeppotionmess
  EQUW applemess
  EQUW fullwhiskeymess
  EQUW jugmess
  EQUW loafmess
  EQUW doorknockermess
  EQUW rockmess, rockmess, rockmess

  EQUW &0000, &0000, &0000, &0000, &0000, &0000, &0000, &0000
  EQUW &0000, &0000, &0000, &0000, &0000, &0000, &0000, &0000
  EQUW &0000, &0000, &0000, &0000, &0000, &0000, &0000, &0000
  EQUW &0000, &0000, &0000, &0000, &0000, &0000

  EQUW railingmess
  EQUW leavesmess
  EQUW railingmess, railingmess, railingmess
  EQUW windowmess
  EQUW leavesmess

.messages

  EQUW startmess               ; 0
  EQUW trollgotapplemess
  EQUW shopkeeperappearsmess
  EQUW givingjunkmess

  EQUW thanksforthecowmess
  EQUW dozytalking             ; 5
  EQUW kickdozyagainmess
  EQUW dylantalking
  EQUW trancemess
  EQUW denziltalking
  EQUW stereoess               ; 10
  EQUW gottodaisymess
  EQUW daisyrunsmess

  EQUW notgotallcoins
  EQUW gotallcoins

  EQUW dougtalking             ; 15
  EQUW goonmysonmess

  EQUW throwwateronfiremess
  EQUW lookatpicturemess
  EQUW throwwateronbeanmess
  EQUW plantbeanmess           ; 20
  EQUW pickupmanuremess
  EQUW throwswitchmess
  EQUW fedarmorog
  EQUW dragonasleepmess
  EQUW croctiedmess            ; 25
  EQUW rockinwatermess
  EQUW keyinmachine
  EQUW fillbucketmess
  EQUW thanksforloafmess
  EQUW puteggbackmess          ; 30
  EQUW goawaymess
  EQUW knockandentermess
  EQUW usedoorknockermess
  EQUW usecrowbarmess
  EQUW usepickaxemess          ; 35
  EQUW obstructingliftmess
  EQUW userugmess
  EQUW getbackintheremess
  EQUW holdingholemess
  EQUW dropwhiskeymess         ; 40

  EQUW deadwindow
  EQUW armorogkilledmess
  EQUW killedbyportcullis
  EQUW killedbyliftmess
  EQUW dragonkilledmess        ; 45
  EQUW dragonflameskilledmess
  EQUW killedbyflame
  EQUW killedbywater
  EQUW croceatenmess
  EQUW killedbyhawk            ; 50
  EQUW ratgotyoumess
  EQUW killedbyvolcano
  EQUW killedbydaggersmess

  EQUW youfoundcoinmess
  EQUW inventory               ; 55
  EQUW inventorywithbag
  EQUW selectitemmess
  EQUW carryingtoomuchmess
  EQUW nothingatallmess
  EQUW fullbucketmess          ; 60

; message offsets
str_startmess               = 0
str_trollgotapplemess       = 1
str_shopkeeperappearsmess   = 2
str_givingjunkmess          = 3
str_thanksforthecowmess     = 4
str_dozytalking             = 5
str_kickdozyagainmess       = 6
str_dylantalking            = 7
str_trancemess              = 8
str_denziltalking           = 9
str_stereoess               = 10
str_gottodaisymess          = 11
str_daisyrunsmess           = 12
str_notgotallcoins          = 13
str_gotallcoins             = 14
str_dougtalking             = 15
str_goonmysonmess           = 16
str_throwwateronfiremess    = 17
str_lookatpicturemess       = 18
str_throwwateronbeanmess    = 19
str_plantbeanmess           = 20
str_pickupmanuremess        = 21
str_throwswitchmess         = 22
str_fedarmorog              = 23
str_dragonasleepmess        = 24
str_croctiedmess            = 25
str_rockinwatermess         = 26
str_keyinmachine            = 27
str_fillbucketmess          = 28
str_thanksforloafmess       = 29
str_puteggbackmess          = 30
str_goawaymess              = 31
str_knockandentermess       = 32
str_usedoorknockermess      = 33
str_usecrowbarmess          = 34
str_usepickaxemess          = 35
str_obstructingliftmess     = 36
str_userugmess              = 37
str_getbackintheremess      = 38
str_holdingholemess         = 39
str_dropwhiskeymess         = 40
str_deadwindow              = 41
str_armorogkilledmess       = 42 
str_killedbyportcullis      = 43
str_killedbyliftmess        = 44
str_dragonkilledmess        = 45
str_dragonflameskilledmess  = 46
str_killedbyflame           = 47
str_killedbywater           = 48
str_croceatenmess           = 49
str_killedbyhawk            = 50
str_ratgotyoumess           = 51
str_killedbyvolcano         = 52
str_killedbydaggersmess     = 53
str_youfoundcoinmess        = 54
str_inventory               = 55
str_inventorywithbag        = 56
str_selectitemmess          = 57
str_carryingtoomuchmess     = 58
str_nothingatallmess        = 59
str_fullbucketmess          = 60

mplot   = 3
mgosub  = 4
mrep    = 5
mendrep = 6
nr      = 10

mend    = 95  ; YES
mxy     = 100 ; YES
mend2   = 160
mpen    = 200 ; YES
drawbox = 250 ; YES

.room0 EQUS "I>GRAY==OLIVER:TWINS",mend
.room1 EQUS mend
.room2 EQUS mend
.room3 EQUS mend
.room4 EQUS mend
.room5 EQUS mend
.room6 EQUS mend
.room7 EQUS mend
.room8 EQUS mend
.room9 EQUS mend
.room10 EQUS mend
.room11 EQUS mend
.room12 EQUS mend
.room13 EQUS mend
.room14 EQUS mend
.room15 EQUS mend
.room16 EQUS mend
.room17 EQUS mend
.room18 EQUS mend
.room19 EQUS mend
.room20 EQUS mend
.room21 EQUS mend
.room22 EQUS ":THE:MARKET:SQUARE::",mend
.room23 EQUS "A:STRANGE:NEW:WORLD@",mend
.room24 EQUS ":INSIDE:THE:CHURCH::",mend
.room25 EQUS mend
.room26 EQUS mend
.room27 EQUS mend
.room28 EQUS mend
.room29 EQUS mend
.room30 EQUS mend
.room31 EQUS "THE:AMAZING:ILLUSION",mend
.room32 EQUS mend
.room33 EQUS mend
.room34 EQUS mend
.room35 EQUS ":SMUGGLER;S:HIDEOUT:",mend
.room36 EQUS "THE:CASTLE;S:DUNGEON",mend
.room37 EQUS mend
.room38 EQUS mend
.room39 EQUS "GOING:DOWN:THE:WELL@",mend
.room40 EQUS ":THE:DRAGON;S:LAIR::",mend
.room41 EQUS ":THE:DESERTED:MINES:",mend
.room42 EQUS mend
.room43 EQUS mend
.room44 EQUS mend
.room45 EQUS ":LOOKING:OUT:TO:SEA:",mend
.room46 EQUS ":THE:DOCKS:AND:PIER:",mend
.room47 EQUS ":FOURWAY:WAREHOUSE::",mend
.room48 EQUS ":THE:BROKEN:BRIDGE::",mend
.room49 EQUS "::THE:GUARD:HOUSE:::",mend
.room50 EQUS ":::ARMOROG;S:DEN::::",mend
.room51 EQUS "MOAT:AND:PORTCULLIS:",mend
.room52 EQUS ":THE:ENTRANCE:HALL::",mend
.room53 EQUS "THE:SNAP=HAPPY:GATOR",mend
.room54 EQUS "THE:WIDE=EYED:DRAGON",mend
.room55 EQUS "THE:BOTTOMLESS:WELL:",mend
.room56 EQUS "THE:LIFT:CONTROL:HUT",mend
.room57 EQUS ":BASE:OF:TREE:HOUSE:",mend
.room58 EQUS "THE:SMELLY:ALLOTMENT",mend
.room59 EQUS ":THE:LARGE:OAK:TREE:",mend
.room60 EQUS "BASE:OF:THE:VOLCANO:",mend
.room61 EQUS mend
.room62 EQUS mend
.room63 EQUS "::THE:CRAFTY:CLOUD::",mend
.room64 EQUS mend
.room65 EQUS mend
.room66 EQUS mend
.room67 EQUS ":::THE:WEST:WING::::",mend
.room68 EQUS "THE:BANQUETING:HALL:",mend
.room69 EQUS ":::THE:EAST:WING::::",mend
.room70 EQUS "::::::::SKY:::::::::",mend
.room71 EQUS "KEEP:OUT@:DOZY;S:HUT",mend
.room72 EQUS "::::DENZIL;S:PAD::::",mend
.room73 EQUS ":DAISY;S:EMPTY:HUT::",mend
.room74 EQUS "THE:GIANT:BEANSTALK:",mend
.room75 EQUS "COMPLEX:CLOUD:ROUTE:",mend
.room76 EQUS "NEAR:THE:VOLCANO:TOP",mend
.room77 EQUS ":THE:ACTIVE:VOLCANO:",mend
.room78 EQUS mend
.room79 EQUS mend
.room80 EQUS mend
.room81 EQUS mend
.room82 EQUS mend
.room83 EQUS ":::THE:WEST:TOWER:::",mend
.room84 EQUS "THE:CASTLE:STAIRCASE",mend
.room85 EQUS ":::THE:EAST:TOWER:::",mend
.room86 EQUS ":THE:LONGJUMP:CLOUD:",mend
.room87 EQUS "::THE:MEETING:HALL::",mend
.room88 EQUS ":LIFT:TO:THE:ELDERS:",mend
.room89 EQUS "DIZZY;S:PARENTS;:HUT",mend
.room90 EQUS mend
.room91 EQUS "::YET:MORE:CLOUDS:::",mend
.room92 EQUS "MORE:;ORRIBLE:CLOUDS",mend
.room93 EQUS ":THE:CLOUD:CASTLE:::",mend
.room94 EQUS ":::DAISY;S:PRISON:::",mend
.room95 EQUS mend
.room96 EQUS mend
.room97 EQUS mend
.room98 EQUS mend
.room99 EQUS mend
.room100 EQUS ":::::THE:ATTIC::::::",mend

.greenbeanmess   EQUS "A:SINGLE:GREEN:BEAN",mend
.bonemess        EQUS "A:FRESH:MEATY:BONE",mend
.goldeneggmess   EQUS "A:HEAVY:DRAGON:EGG",mend
.blackholemess   EQUS "A:LARGE:ROUND:HOLE",mend
.sleeppotionmess EQUS "SOME:SLEEPING:POTION",mend
.applemess       EQUS "A:FRESH<:GREEN:APPLE",mend
.jugmess         EQUS "A:JUG:OF:WATER",mend
.loafmess        EQUS "STALE:LOAF:OF:BREAD",mend
.fullwhiskeymess EQUS "A:BOTTLE:OF:WHISKY:",mend
.ropemess        EQUS "A:PIECE:OF:ROPE",mend
.rockmess        EQUS "A:HEAVY:BOULDER",mend
;.fullwinemess    EQUS "A:BOTTLE:OF:WINE",mend
;.emptybottlemess EQUS "AN:EMPTY:BOTTLE",mend
.keymess         EQUS "A:SHINY:GOLD:KEY",mend
.mtbucketmess    EQUS "AN:EMPTY:BUCKET",mend
.fullbucketmess  EQUS "A:BUCKET:OF:WATER",mend
.leavesmess      EQUS "A:CLUMP:OF:LEAVES",mend
.pigmycowmess    EQUS "A:CUTE:PIGMY:COW",mend
.railingmess     EQUS "A:PIECE:OF:RAILING",mend
.doorknockermess EQUS "BRASS:DOOR:KNOCKER",mend
.crowbarmess     EQUS "A:STRONG:CROWBAR",mend
.pickaxemess     EQUS "A:RUSTY:PICKAXE",mend
.rugmess         EQUS "AN:OLD<:THICK:RUG",mend
.windowmess      EQUS "A:WINDOW:FRAME",mend
.bagmess         EQUS "EXIT:AND:DON;T:DROP",mend

.startmess
  EQUS mxy+19,48,mpen+3,  "FANTASY:WORLD"
  EQUS mxy+24,80,mpen+2,  "STARRING"
  EQUS mxy+20,89,         "THE:YOLKFOLK"
  EQUS mxy+20,108,mpen+5,"D",mxy+22,106,"I",mxy+24,104,"Z"
  EQUS mxy+26,102,"Z",mxy+28,100,"Y"

  EQUS mxy+35,100,"D",mxy+37,102,"A",mxy+39,104,"I"
  EQUS mxy+41,106,"S",mxy+43,108,"Y"

  EQUS mxy+9,142, "DENZIL:DYLAN"
  EQUS mxy+35,136,"DOZY"
  EQUS mxy+46,136,"GRAND"
  EQUS mxy+46,144, "DIZZY"
  EQUS mpen+6,":"
  EQUS mend,mend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PEOPLE TALKING MESSAGES

.trollgotapplemess
  EQUS mpen+7,mxy+2,48,drawbox,13,5,mpen+3
  EQUS mxy+11,72,"YOU:GIVE"
  EQUS mxy+10,80,"THE:APPLE"
  EQUS mxy+7,88,"T0:THE:TROLL",mend
  EQUS mpen+5,mxy+16,80,drawbox,11,5,mpen+6
  EQUS mxy+23,104,"&FOR:ME?"
  EQUS mxy+22,112,"YOU;RE:SO"
  EQUS mxy+22,120,"GENEROUS'",mend
  EQUS mpen+5,mxy+8,48,drawbox,20,6,mpen+6
  EQUS mxy+16,72,"&I;D:LIKE:TO:LET"
  EQUS mxy+16,80,"YOU:PASS<:BUT:IF"
  EQUS mxy+14,88,"THE:KING:FOUND:OUT"
  EQUS mxy+15,96,"HE;D:TORTURE:ME@'",mend
  EQUS mpen+5,mxy+6,112,drawbox,22,5,mpen+6
  EQUS mxy+16,136,"&BUT:YOU:COULD"
  EQUS mxy+14,144,"ESCAPE:THROUGH:THE"
  EQUS mxy+11,152,"FIRE:USING:THE:WATER'",mend,mend

.shopkeeperappearsmess
  EQUS mpen+7,mxy+2,96,drawbox,20,5,mpen+3
  EQUS mxy+10,120,"PING@:>>>:AND:AS"
  EQUS mxy+10,128,"IF:BY:MAGIC<:THE"
  EQUS mxy+8,136,"SHOPKEEPER:APPEARS",mend,mend

.givingjunkmess
  EQUS mpen+5,mxy+2,96,drawbox,25,4,mpen+6
  EQUS mxy+10,120,"&THAT;S:NO:GOOD:TO:ME"
  EQUS mxy+8,128,"GIVE:US:SOMETHIN;:ELSE'",mend,mend

;.stopgivingjunkmess
;  EQUS mpen+5,mxy+2,96,drawbox,19,4,mpen+6
;  EQUS mxy+10,120,"&STOP:GIVIN;:US"
;  EQUS mxy+11,128,"ALL:THAT:TRASH'",mend

;shoptalk        defw beanhere+room

.thanksforthecowmess
  EQUS mpen+5,mxy+2,80,drawbox,26,4,mpen+6
  EQUS mxy+8,104,"&G;DAY:DIZ<:AHH@:A:PIGMY"
  EQUS mxy+9,112, "COW:THAT;S:INTERESTIN;'",mend
.tencoinsmess
  EQUS mpen+4,mxy+10,120,drawbox,22,4,mpen+3
  EQUS mxy+20,144,"&WELL<:HOW:ABOUT"
  EQUS mxy+15,152,"10:GOLD:COINS:FOR:IT?",mend
.nottengoldcoins
  EQUS mpen+5,mxy+18,48,drawbox,18,5,mpen+6
  EQUS mxy+24,72,"&STREWTH MATE<:I"
  EQUS mxy+24,80,"SAID:INTERESTIN;"
  EQUS mxy+27,88,"NOT:VALUABLE'",mend
.fivecoinsmess
  EQUS mpen+4,mxy+2,104,drawbox,15,4,mpen+3
  EQUS mxy+11,128,"&WELL<:OK<"
  EQUS mxy+8,136,"5:GOLD:COINS'",mend
.notfivegoldcoins
  EQUS mpen+5,mxy+6,72,drawbox,24,5,mpen+6
  EQUS mxy+13,96, "&BE:SERIOUS<:IT:AIN;T"
  EQUS mxy+14,104,"WORTH:SPIT<:HERE;S:A"
  EQUS mxy+12,112,"BEAN<:THAT;S:GENEROUS'",mend
.erumbut
  EQUS mpen+4,mxy+16,112,drawbox,10,4,mpen+3
  EQUB &CC, &10, &70, &FA, &0A, &04, &CB ; ???????
  EQUS mxy+22,136,"&ER<:UM<:"
  EQUS mxy+22,144,"BUT:>>>'",mend
.throwsbean
  EQUS mpen+5,mxy+2,48,drawbox,11,5,mpen+6
  EQUS mxy+8,72,"&NOW:STOP"
  EQUS mxy+8,80,":WASTIN;"
  EQUS mxy+7,88,"MY:TIME@'"
  EQUS mpen+7,mxy+12,112,drawbox,15,5,mpen+3
  EQUS mxy+18,136,"AND:HE:THROWS"
  EQUS mxy+21,144,":THE:BEAN"
  EQUS mxy+19,152,"ON:THE:CRATE",mend
.letsfaceitmess
  EQUS mpen+7,mxy+8,80,drawbox,20,5,mpen+3
  EQUS mxy+15,104,"YOU:LEAVE:=:LET;S"
  EQUS mxy+18,112,"FACE:IT:DIZZY<"
  EQUS mxy+15,120,"YOU:CAN;T:BARTER@",mend,mend

.dozytalking
; EQUW sleepingpotionhere+room
  EQUS mpen+4,mxy+30,48,drawbox,12,4,mpen+3
  EQUS mxy+36,72, "&HEY@:DOZY"
  EQUS mxy+38,80, "GET:UP@'",mend

  EQUS mpen+7,mxy+2,80,drawbox,16,5,mpen+3
  EQUS mxy+10,104,"YOU:KICK:THE"
  EQUS mxy+8,112, "DECK:CHAIR:AND"
  EQUS mxy+11,120,"HE:WAKES:UP",mend

  EQUS mpen+5,mxy+12,112,drawbox,17,4,mpen+6
  EQUS mxy+18,136,"&OH@:WHAT;S:THE"
  EQUS mxy+20,144,"PROBLEM:DIZZY?'",mend

  EQUS mpen+4,mxy+2,48,drawbox,26,7,mpen+3
  EQUS mxy+9,72,  "&DAISY;S:BEEN:EGGNAPPED"
  EQUS mxy+8,80,  "AND:IS:BEING:HELD:IN:THE"
  EQUS mxy+10,88, "WIZARD;S:CLOUD:CASTLE<"
  EQUS mxy+12,96, "AND:NOBODY:WILL:HELP"
  EQUS mxy+17,104,"ME:RESCUE:HER@'",mend

  EQUS mpen+5,mxy+2,88,drawbox,14,6,mpen+6
  EQUS mxy+8 ,112,"&AHH<:THAT;S"
  EQUS mxy+11,120,"BAD:LUCK>"
  EQUS mxy+11,128,"I;LL:HELP"
  EQUS mxy+9,136, "YOU<:DIZZY'",mend

  EQUS mpen+5,mxy+18,112,drawbox,18,5,mpen+6
  EQUS mxy+28,136,"&HERE;S:SOME"
  EQUS mxy+24,144,"SLEEPING:POTION<"
  EQUS mxy+23,152,"THAT:SHOULD:HELP'",mend

  EQUS mpen+4,mxy+2,120,drawbox,17,4,mpen+3
  EQUS mxy+10,144,"&BUT:I;D:LIKE"
  EQUS mxy+8,152,"YOU:TO:HELP:ME'",mend

  EQUS mpen+5,mxy+2,48,drawbox,16,7,mpen+6
  EQUS mxy+9,72,"&SORRY:DIZZY<"
  EQUS mxy+10,80,"LOVE:TO:BUT"
  EQUS mxy+10,88,"IT;S:FAR:TOO"
  EQUS mxy+9,96, "NICE:A:DAY:TO"
  EQUS mxy+7,104,"RESCUE:MAIDENS'",mend

  EQUS mpen+7,mxy+8,80,drawbox,20,5,mpen+3
  EQUS mxy+14,104,"I:DON;T:THINK:HE;S"
  EQUS mxy+14,112,"GOING:TO:HELP<:AND"
  EQUS mxy+14,120,"HE;S:FALLEN:ASLEEP",mend,mend

.kickdozyagainmess
  EQUS mpen+7,mxy+10,80,drawbox,17,4,mpen+3
  EQUS mxy+18,104,"YOU:KICK:DOZY"
  EQUS mxy+16,112,"BUT:HE;S:ASLEEP",mend

.pushdozymess
  EQUS mpen+7,mxy+6,72,drawbox,22,6,mpen+3
  EQUS mxy+14,96,"WHOOPS@:YOU:KICKED"
  EQUS mxy+13,104,"TOO:HARD:AND:DOZY;S"
  EQUS mxy+11,112,"FALLEN:IN:THE:WATER"
  EQUS mxy+11,120,"AND:HE;S:STILL:ASLEEP",mend,mend

;duffmem EQUW 0

.dylantalking
; EQUW duffmem ;;poked value,so must point somewhere
  EQUS mpen+5,mxy+2,48,drawbox,18,4,mpen+6
  EQUS mxy+10,72, "&HEY:MAN<:LIKE"
  EQUS mxy+6,80, "WHAT;S:HAPPENIN:?'",mend

  EQUS mpen+4,mxy+4,96,drawbox,24,6,mpen+3
  EQUS mxy+10,120,"&PLEASE:HELP:ME:DYLAN<"
  EQUS mxy+12,128,"I;M:TRYING:TO:RESCUE"
  EQUS mxy+10,136,"DAISY:BUT:I:CAN;T:FIND"
  EQUS mxy+14,144,"THE:CLOUD:CASTLE>'",mend

  EQUS mpen+5,mxy+12,72,drawbox,19,5,mpen+6
  EQUS mxy+18,96, "&IT;S:QUITE:EASY<"
  EQUS mxy+18,104,"REMEMBER:HOW:JACK"
  EQUS mxy+18,112,"FOUND:THE:CASTLE'"
  EQUS mend,mend

.trancemess
  EQUS mpen+7,mxy+4,80,drawbox,24,4,mpen+3
  EQUS mxy+18,104,"STRANGE<:DYLAN"
  EQUS mxy+9,112,"SEEMS:TO:BE:IN:A:TRANCE",mend,mend

.denziltalking
; EQUW ropehere+room
  EQUS mpen+4,mxy+2,96,drawbox,26,5,mpen+3
  EQUS mxy+8,120,"&WHAT:ARE:YOU:DOING:HERE"
  EQUS mxy+8,128, "DENZIL:=:DON;T:YOU:KNOW"
  EQUS mxy+12,136, "IT;S:DANGEROUS?'",mend

  EQUS mpen+5,mxy+2,48,drawbox,24,6,mpen+6
  EQUS mxy+9,72,  "&HEY<:STAY:COOL<:DIZ>"
  EQUS mxy+10,80, "I:SAW:THE:KING:LEAVE"
  EQUS mxy+9,88,  "AND:THOUGHT:I;D:CHECK"
  EQUS mxy+15,96,  "OUT:THE:CASTLE>'",mend

  EQUS mpen+4,mxy+4,96,drawbox,24,7,mpen+3
  EQUS mxy+10,120, "&BUT:DAISY:AND:I:WERE"
  EQUS mxy+12,128, "CAUGHT>:I:WAS:THROWN"
  EQUS mxy+13,136, "IN:THE:DUNGEONS:AND"
  EQUS mxy+11,144, "DAISY;S:BEEN:TAKEN:TO"
  EQUS mxy+12,152, "THE:WIZARD;S:CASTLE'",mend

  EQUS mpen+5,mxy+2,48,drawbox,26,7,mpen+6
  EQUS mxy+14,72,"&OH@:WE:WONDERED"
  EQUS mxy+13,80, "WHERE:YOU:HAD:GONE>"
  EQUS mxy+11,88,"I;M:TOO:BUSY:TO:HELP<"
  EQUS mxy+12,96,"BUT:HERE;S:THE:ROPE"
  EQUS mxy+9,104,"YOU:LENT:ME:LAST:WEEK>'"

  EQUS mend,mend

.stereoess
  EQUS mpen+7,mxy+8,80,drawbox,19,5,mpen+3
  EQUS mxy+13,104,"DENZIL;S:TURNED:UP"
  EQUS mxy+16,112,"HIS:STEREO:AND"
  EQUS mxy+16,120,"IS:IGNORING:YOU",mend,mend


;daisytalking    ;;;;;;;;;;;;;defw beanhere+room
;;;     EQUS mend,mend

.gottodaisymess
  EQUS mpen+5,mxy+2,48,drawbox,17,5,mpen+6
  EQUS mxy+8,72,"&OH@:MY:HERO@:I"
  EQUS mxy+8,80,"KNEW:YOU;D:COME"
  EQUS mxy+8,88,"TO:MY:RECSUE@'",mend,mend
.daisyrunsmess
  EQUS mpen+7,mxy+4,64,drawbox,24,9,mpen+3
  EQUS mxy+13,88, "WELL<:DAISY:DOESN;T"
  EQUS mxy+10,96, "HANG:AROUND<:SHE;S:RUN"
  EQUS mxy+11,104,"HOME:AND:WANTS:YOU:TO"
  EQUS mxy+9,112, "BRING:HER:30:GOLD:COINS"
  EQUS mxy+11,120,"SO:THAT:YOU:CAN:BUY:A"
  EQUS mxy+10,128,"HOME:TOGETHER:AND:LIVE"
  EQUS mxy+14,136,"HAPPILY:EVER:AFTER",mend,mend

.notgotallcoins
  EQUS mpen+5,mxy+2,48,drawbox,21,6,mpen+6
  EQUS mxy+10,72, "&OH:DIZZY@:YOU;RE"
  EQUS mxy+8,80,  "SO:BRAVE:AND:CLEVER"
  EQUS mxy+9,88,  "AND:NOW:WE:CAN:BUY"
  EQUS mxy+9,96,  "THAT:TREE:COTTAGE'",mend

  EQUS mpen+4,mxy+6,112,drawbox,24,5,mpen+3
  EQUS mxy+12,136, "&ER<:UM<:WELL:ACTUALLY"
  EQUS mxy+13,144, "I:WAS:WONDERING:IF:WE"
  EQUS mxy+12,152, "NEEDED:ALL:30:COINS?'",mend

  EQUS mpen+5,mxy+6,64,drawbox,21,4,mpen+6
  EQUS mxy+12,88,"&YOU:DISAPPOINT:ME<"
  EQUS mxy+14,96, "OF:COURSE:WE:DO@'",mend

  EQUS mpen+7,mxy+8,80,drawbox,21,5,mpen+3
  EQUS mxy+15,104,"BACK:YOU:GO:DIZZY>"
  EQUS mxy+15,112,"SHE;S:A:REAL:SLAVE"
  EQUS mxy+13,120,"DRIVER<:BUT:WORTH:IT"
  EQUS mend,mend

.gotallcoins
  EQUS mpen+5,mxy+2,48,drawbox,24,3,mpen+6
  EQUS mxy+8,72, "&WOW@:YOU;VE:GOT:THEM'",mend

  EQUS mpen+4,mxy+4,128,drawbox,24,3,mpen+3
  EQUS mxy+10,152, "&WELL<:IT:WAS:NOTHING'",mend

  EQUS mpen+7,mxy+20,88,drawbox,7,3,mpen+3,mpen+7
  EQUS mxy+26,112,"LIAR@",mend

  EQUS mpen+7,mxy+2,80,"H",drawbox,23,5,mpen+3
  EQUS mxy+10,104,"AND:SO:WE:SAY:GOODBYE"
  EQUS mxy+12,112,"TO:THE:HAPPY:COUPLE"
  EQUS mxy+16,120,"UNTIL:>>>>>",mend

  EQUS mpen+7,mxy+8,72,drawbox,20,10,mpen+3
  EQUS mxy+13,96,"WELL<WHO:KNOWS:WHAT"
  EQUS mxy+15,104,"MIGHT:HAPPEN:NEXT?",mpen+4
  EQUS mxy+16,120,"WE:HOPE:YOU:HAVE"
  EQUS mxy+15,128,"ENJOYED:THIS:GAME",mpen+2
  EQUS mxy+14,140,"THAT;S:ALL:FOLKS@",mpen+5
  EQUS mxy+16,152,"THE:OLIVER:TWINS", mpen+7
  EQUS mxy+20,160,"AND:IAN:GRAY"

  EQUS mend,mend

.dougtalking
;  EQUW crowbarhere+room
  EQUS mpen+5,mxy+2,48,drawbox,25,6,mpen+6
  EQUS mxy+9,7, "&AFTERNOON:YOUNG:DIZZY"
  EQUS mxy+14,80,"YOU:LOOK:FRANTIC<"
  EQUS mxy+8,88, "ANYTHING:YOUR:OLD:GRAND"
  EQUS mxy+9,96, "DIZZY:CAN:DO:TO:HELP?'",mend

  EQUS mpen+4,mxy+6,104,drawbox,24,6,mpen+3
  EQUS mxy+15,128,"&HAVEN;T:YOU:HEARD?"
  EQUS mxy+13,136,"DAISY;S:BEING:HELD:IN"
  EQUS mxy+14,144,"THE:CLOUD:CASTLE:AND"
  EQUS mxy+11,152,"I;M:TRYING:TO:SAVE:HER'",mend

  EQUS mpen+5,mxy+12,48,drawbox,21,4,mpen+6
  EQUS mxy+18,72,"&JUST:WAIT:HERE:AND"
  EQUS mxy+21,80,"I;LL:GET:MY:HAT'",mend

  EQUS mpen+4,mxy+2,96,drawbox,25,5,mpen+3
  EQUS mxy+9,120,"&WHAT@:WELL:THANKS:FOR"
  EQUS mxy+8,128,"OFFERING<:BUT:I:THINK"
  EQUS mxy+8,136,"YOU:SHOULD:STAY:HERE>'",mend

  EQUS mpen+5,mxy+4,64,drawbox,24,6,mpen+6
  EQUS mxy+13,88, "&WELL<:IF:YOU:THINK"
  EQUS mxy+10,96, "IT;S:BEST<:BUT:PLEASE"
  EQUS mxy+14,104,"TAKE:THIS:CROWBAR>"
  EQUS mxy+11,112,"I:REMEMBER:WHEN>>>>'",mend

  EQUS mpen+7,mxy+6,80,drawbox,22,5,mpen+3
  EQUS mxy+13,104,"YOU:DECIDE:TO:LEAVE"
  EQUS mxy+12,112,"AS:HE:STARTS:TO:TELL"
  EQUS mxy+12,120,"YOU:HIS:LIFE:STORY"

  EQUS mend,mend

.goonmysonmess
  EQUS mpen+5,mxy+2,48,drawbox,21,5,mpen+6
  EQUS mxy+10,72,"OH:NO@:HE;S:STILL"
  EQUS mxy+10,80,"WAFFLING:ON:ABOUT"
  EQUS mxy+8,88, "HIS:PAST:ADVENTURES",mend,mend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MESSAGES FOR DOING THINGS

.throwwateronfiremess
  EQUS mpen+7,mxy+2,48,drawbox,21,6,mpen+3
  EQUS mxy+10,72, "YOU:THROW:THE:JUG"
  EQUS mxy+10,80,"OF:WATER:ONTO:THE"
  EQUS mxy+8,88, "FIRE:AND:THE:FLAMES"
  EQUS mxy+7,96, "ARE:QUICKLY:QUENCHED",mend,mend

.lookatpicturemess
  EQUS mpen+7,mxy+2,96,drawbox,23,6,mpen+3
  EQUS mxy+11,120, "YOU:LOOK:UP:AT:THE"
  EQUS mxy+9,128,  "PICTURE=:IT;S:YOU:IN"
  EQUS mxy+10,136, "YOUR:LAST:ADVENTURE",mpen+5
  EQUS mxy+8,144,  "TREASURE:ISLAND:DIZZY",mend,mend

.throwwateronbeanmess
  EQUS mpen+7,mxy+2,48,drawbox,26,8,mpen+3
  EQUS mxy+8,72,  "YOU:THROW:YOUR:BUCKET:OF"
  EQUS mxy+13,80, "WATER:ONTO:THE:BEAN",mpen+5
  EQUS mxy+11,88, "YOU:JUMP:CLEAR:AS:THE"
  EQUS mxy+10,96, "GROUND:RUMBLES:AND:A"
  EQUS mxy+12,104,"BEANSTALK:SPIRALS:UP"
  EQUS mxy+14,112,"THROUGH:THE:CLOUDS",mend,mend

.plantbeanmess
  EQUS mpen+7,mxy+6,48,drawbox,22,5,mpen+3
  EQUS mxy+12,72,"THIS:TIME:YOU:DECIDE"
  EQUS mxy+15,80,"TO:PLANT:THE:BEAN"
  EQUS mxy+15,88,"IN:THE:DRY:MANURE"
  EQUS mpen+2,mxy+2,112,drawbox,16,4,mpen+6
  EQUS mxy+8,136,":>>>:BUT:IT:IS"
  EQUS mxy+8,144,"UNABLE:TO:GROW",mend,mend

.pickupmanuremess
  EQUS mpen+7,mxy+2,48,drawbox,26,5,mpen+3
  EQUS mxy+6,72,"OH@:HOW:DISGUSTING@YOU:TRY"
  EQUS mxy+7,80,"TO:PICK:UP:THE:MANURE:BUT"
  EQUS mxy+8,88,"IT:SLIPS:FROM:YOUR:HANDS",mend,mend


.throwswitchmess
  EQUS mpen+7,mxy+2,48,drawbox,15,5,mpen+3
  EQUS mxy+8,72,"YOU:THROW:THE"
  EQUS mxy+8,80,"LEVER:TO:;ON;"
  EQUS mxy+8,88,"BUT:IT:BREAKS",mend,mend

.fedarmorog
  EQUS mpen+7,mxy+2,48,drawbox,18,4,mpen+3
  EQUS mxy+8,72,"THAT:BONE:SHOULD"
  EQUS mxy+10,80,"KEEP:HIM:BUSY@",mend,mend

.dragonasleepmess
  EQUS mpen+7,mxy+2,48,drawbox,21,6,mpen+3
  EQUS mxy+8,72,"YOU:SMASH:THE:FLASK"
  EQUS mxy+10,80,"OF:POTION:AND:THE"
  EQUS mxy+9,88,"DRAGON:INHALES:THE"
  EQUS mxy+8,96,"INTOXICATING:VAPOUR",mend,mend


.croctiedmess
  EQUS mpen+7,mxy+2,48,drawbox,19,5,mpen+3
  EQUS mxy+11,72,"YOU:NIMBLY:TIE"
  EQUS mxy+10,80,"THE:ROPE:AROUND"
  EQUS mxy+8,88, "THE:;GATOR;S:JAWS",mend,mend

.rockinwatermess
  EQUS mpen+7,mxy+2,112,drawbox,26,5,mpen+3
  EQUS mxy+6,136,"YOU:PUSH:THE:ROCK:INTO:THE"
  EQUS mxy+6,144,"RIVER:AND:IT:DISPLACES:THE"
  EQUS mxy+8,152,"WATER<:RAISING:THE:LEVEL",mend,mend
.keyinmachine
  EQUS mpen+7,mxy+2,48,drawbox,24,5,mpen+3
  EQUS mxy+8,72,"YOU:TRY:THE:KEY:IN:THE"
  EQUS mxy+13,80,"LOCK:AND:IT:FITS@"
  EQUS mxy+8,88,"SO:YOU:TURN:IT:TO:;ON;",mend,mend

.fillbucketmess
  EQUS mpen+7,mxy+2,48,drawbox,21,4,mpen+3
  EQUS mxy+8,72,"YOU:FILL:YOUR:EMPTY"
  EQUS mxy+10,80,"BUCKET:WITH:WATER",mend,mend

.thanksforloafmess
  EQUS mpen+7,mxy+2,48,drawbox,18,5,mpen+3
  EQUS mxy+8,72, "THE:RAVENOUS:RAT"
  EQUS mxy+11,80,"EATS:THE:LOAF"
  EQUS mxy+11,88,"AND:RUNS:AWAY",mend,mend
.puteggbackmess
  EQUS mpen+7,mxy+2,48,drawbox,20,6,mpen+3
  EQUS mxy+11,72,"YOU:PUT:THE:EGG"
  EQUS mxy+8,80, "BACK:INTO:THE:NEST"
  EQUS mxy+12,88,"AND:THE:DRAGON"
  EQUS mxy+8,96, "ALLOWS:YOU:TO:PASS",mend,mend

.goawaymess
  EQUS mpen+5,mxy+2,48,drawbox,26,5,mpen+6
  EQUS mxy+10,72,"&OH:NO@:NOT:YOU:AGAIN@"
  EQUS mxy+12,80, "GO:AWAY@:I;M:HIDING<"
  EQUS mxy+8,88, "AND:IT;S:ALL:YOUR:FAULT'",mend,mend


.knockandentermess
  EQUS mpen+2,mxy+2,96,drawbox,17,3,mpen+6
  EQUS mxy+8,120, "KNOCK:AND:ENTER",mend,mend

  EQUS mpen+7,mxy+6,40,drawbox,22,5,mpen+3
  EQUS mxy+14,7, "THAT;S:EASIER:SAID"
  EQUS mxy+11,80, "THAN:DONE:WHEN:YOU;RE"
  EQUS mxy+11,88, "WEARING:BOXING:GLOVES",mend,mend

.usedoorknockermess
  EQUS mpen+7,mxy+2,48,drawbox,20,5,mpen+3
  EQUS mxy+12,72,"USING:THE:DOOR"
  EQUS mxy+8,80,"KNOCKER<:YOU:KNOCK"
  EQUS mxy+8,88,"AND:THE:DOOR:OPENS",mend,mend

.usecrowbarmess
  EQUS mpen+7,mxy+2,48,drawbox,19,5,mpen+3
  EQUS mxy+8,72,"USING:THE:CROWBAR"
  EQUS mxy+8,80,"YOU:FORCE:THE:LID"
  EQUS mxy+13,88,"OFF:THE:WELL",mend,mend
.usepickaxemess
  EQUS mpen+7,mxy+2,48,drawbox,22,4,mpen+3
  EQUS mxy+9,72,"YOU:USE:THE:PICKAXE"
  EQUS mxy+8,80,"TO:BREAK:UP:THE:ROCK",mend,mend

.obstructingliftmess
  EQUS mpen+2,mxy+14,80,drawbox,14,4,mpen+6
  EQUS mxy+21,104,"STAND:CLEAR"
  EQUS mxy+21,112,"OF:THE:LIFT",mend,mend

.userugmess
  EQUS mpen+7,mxy+10,80,drawbox,17,6,mpen+3
  EQUS mxy+18,104,"YOU:THROW:THE"
  EQUS mxy+17,112,"RUG:ACROSS:THE"
  EQUS mxy+16,120,"DAGGERS<:MAKING"
  EQUS mxy+22,128,"THEM:SAFE",mend,mend

.getbackintheremess
  EQUS mpen+5,mxy+2,48,drawbox,21,4,mpen+6
  EQUS mxy+10,72,  "&OY@:WHERE:DO:YOU"
  EQUS mxy+7,80,  "THINK:YOU;RE:GOING?'",mend,mend

.holdingholemess
  EQUS mpen+2,mxy+2,48,drawbox,16,7,mpen+6
  EQUS mxy+8,72,"WHOOPS@:",mpen+4,"YOU;VE"
  EQUS mxy+9,80,"GOT:A:HOLE:IN"
  EQUS mxy+10,88,"YOUR:BAG:AND"
  EQUS mxy+8,96,"EVERYTHING:HAS"
  EQUS mxy+10,104,"DROPPED:OUT@",mend,mend

.dropwhiskeymess
  EQUS mpen+2,mxy+2,48,drawbox,14,7,6
  EQUS mxy+8,72,  "YOU:FIND:THE"
  EQUS mxy+9,80,  "WHISKY:TOO"
  EQUS mxy+9,88,  "TEMPTING:TO"
  EQUS mxy+9,96,  "DROP:AND:SO"
  EQUS mxy+11,104,"DRINK:IT@",mend,mend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ALL DEAD MESSAGES

.deadwindow
  EQUS mpen+6,mxy+10,64,drawbox,18,6
  EQUS mxy+16,112,mpen+2,"YOU:LOSE:A:LIFE@",mpen+5,mend+mend2
.armorogkilledmess
  EQUS mxy+18,88,"ARMOROG:CAUGHT"
  EQUS mxy+17,100,"YOU:TRESPASSING"
  EQUS mend+mend2

.killedbyportcullis
  EQUS mxy+16,88,"YOU:WERE:STABBED"
  EQUS mxy+16,96,"BY:THE:SPIKES:OF"
  EQUS mxy+18,104,"THE:PORTCULLIS"
  EQUS mend+mend2

.killedbyliftmess
  EQUS mxy+17,88,"YOU:GOT:TRAPPED"
  EQUS mxy+18,96,"IN:THE:COGS:ON"
  EQUS mxy+17,104,"TOP:OF:THE:LIFT"
  EQUS mend+mend2-1

.dragonkilledmess
  EQUS mxy+16,88, "THE:DRAGON:BITES"
  EQUS mxy+16,96, "YOU:AND:YOU:KEEL"
  EQUS mxy+20,104,"OVER:AND:DIE"
  EQUS mend+mend2-1

.dragonflameskilledmess
  EQUS mxy+17,88, "YOU:ARE:ROASTED"
  EQUS mxy+17,96, "BY:THE:DRAGON;S"
  EQUS mxy+20,104,"FIREY:BREATH"
  EQUS mend+mend2-1

.killedbyflame
  EQUS mxy+18,88,"YOU:WERE:BURNT"
  EQUS mxy+19,100,"BY:THE:FLAMES"
  EQUS mend+mend2-1

.killedbywater
  EQUS mxy+17,88, "YOU:FELL:IN:THE"
  EQUS mxy+15,100,"WATER:AND:DROWNED"
  EQUS mend+mend2-1

.croceatenmess
  EQUS mxy+19,88,"THE:GATOR:HAS"
  EQUS mxy+19,96,"YOU:FOR:LUNCH"
  EQUS mend+mend2-1

.killedbyhawk
  EQUS mxy+18,88,"THE:DIZZY=HAWK"
  EQUS mxy+21,96,"SWOOPS:DOWN"
  EQUS mxy+19,104,"AND:KILLS:YOU"
  EQUS mend+mend2-1

.ratgotyoumess
  EQUS mxy+20,88,"THE:RAT:GOES"
  EQUS mxy+20,96,"STRAIGHT:FOR"
  EQUS mxy+23,104,"YOUR:NECK"
  EQUS mend+mend2-1

.killedbyvolcano
  EQUS mxy+18,88, "YOU:WERE:BURNT"
  EQUS mxy+17,96, "BY:THE:HOT:LAVA"
  EQUS mxy+18,104,"IN:THE:VOLCANO"
  EQUS mend+mend2-1

.killedbydaggersmess
  EQUS mxy+14,88, "YOU;RE:SKEWERED:BY"
  EQUS mxy+15,100,"THE:SHARP:DAGGERS"
  EQUS mend+mend2-1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ODD MESSAGES

.youfoundcoinmess
  EQUS mpen+5,mxy+16,64,drawbox,12,5,mpen+3
  EQUS mxy+22,88,"WELL:DONE@",mpen+6
  EQUS mxy+23,96,"YOU:FOUND"
  EQUS mxy+26,104,"A:COIN",mend,mend

.inventory
  EQUS mpen+4,mxy+6,56,drawbox,22,6,mxy+16,76
.carrymess
  EQUS mpen+5,"YOU:ARE:CARRYING",mpen+2,mend+mend2-1
.inventorywithbag
  EQUS mpen+4,mxy+6,48,drawbox,22,8,mxy+16,68
  EQUS mpen+5,"YOU:ARE:CARRYING",mpen+2,mend+mend2-1

.selectitemmess
  EQUS mpen+7,mxy+14,136,drawbox,14,2,mpen+5
  EQUS mxy+18,152,"CHOOSE:ITEM:TO"
  EQUS mxy+21,160,"USE:OR:DROP",mend+mend2-1

.carryingtoomuchmess
  EQUS mpen+7,mxy+12,136,drawbox,16,2,mpen+5
  EQUS mxy+16,152,"YOU:ARE:CARRYING"
  EQUS mxy+16,160,"TOO:MUCH:TO:HOLD",mend+mend2

.nothingatallmess
  EQUS mxy+26,96,mpen+7
  EQUS "NOTHING", mend+mend2
