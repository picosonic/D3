;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PEOPLE TALKING MESSAGES
; Room 36
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

; Room 22
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

.shoptalk
  EQUW beanhere+room

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

; Room 45
.dozytalking
  EQUW sleepingpotionhere+room
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

; Room 59
.duffmem
  EQUB 0

.dylantalking
  EQUW duffmem ;;poked value,so must point somewhere
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

; Room 68 
.denziltalking
  EQUW ropehere+room
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
 
.daisytalking ;;;;;;;;;;;;;defw beanhere+room
;;;  EQUB PRT_END,PRT_END

; Room 94
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

; Room 73
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

; Room 73
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

; Room 88
.dougtalking
  EQUW crowbarhere+room

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MESSAGES FOR DOING THINGS

; Room 36
.throwwateronfiremess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,6,PRT_PEN+3
  EQUB PRT_XY+10,72, "YOU:THROW:THE:JUG"
  EQUB PRT_XY+10,80,"OF:WATER:ONTO:THE"
  EQUB PRT_XY+8,88, "FIRE:AND:THE:FLAMES"
  EQUB PRT_XY+7,96, "ARE:QUICKLY:QUENCHED",PRT_END

; Room 52
.lookatpicturemess
  EQUB PRT_PEN+7,PRT_XY+2,96,PRT_DRAWBOX,23,6,PRT_PEN+3
  EQUB PRT_XY+11,120, "YOU:LOOK:UP:AT:THE"
  EQUB PRT_XY+9,128,  "PICTURE>:IT;S:YOU:IN"
  EQUB PRT_XY+10,136, "YOUR:LAST:ADVENTURE",PRT_PEN+5
  EQUB PRT_XY+8,144,  "TREASURE:ISLAND:DIZZY",PRT_END

; Room 58
.throwwateronbeanmess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,26,8,PRT_PEN+3
  EQUB PRT_XY+8,72,  "YOU:THROW:YOUR:BUCKET:OF"
  EQUB PRT_XY+13,80, "WATER:ONTO:THE:BEAN",PRT_PEN+5
  EQUB PRT_XY+11,88, "YOU:JUMP:CLEAR:AS:THE"
  EQUB PRT_XY+10,96, "GROUND:RUMBLES:AND:THE"
  EQUB PRT_XY+12,104,"BEANSTALK:SPIRALS:UP"
  EQUB PRT_XY+14,112,"THROUGH:THE:CLOUDS",PRT_END

; Room 58
.plantbeanmess
  EQUB PRT_PEN+7,PRT_XY+6,48,PRT_DRAWBOX,22,5,PRT_PEN+3
  EQUB PRT_XY+12,72,"THIS:TIME:YOU:DECIDE"
  EQUB PRT_XY+15,80,"TO:PLANT:THE:BEAN"
  EQUB PRT_XY+15,88,"IN:THE:DRY:MANURE"
  EQUB PRT_PEN+2,PRT_XY+2,112,PRT_DRAWBOX,16,4,PRT_PEN+6
  EQUB PRT_XY+8,136,":>>>:BUT:IT:IS"
  EQUB PRT_XY+8,144,"UNABLE:TO:GROW",PRT_END

; Room 58
.pickupmanuremess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,26,5,PRT_PEN+3
  EQUB PRT_XY+6,72,"OH@:HOW:DISGUSTING@YOU:TRY"
  EQUB PRT_XY+7,80,"TO:PICK:UP:THE:MANURE:BUT"
  EQUB PRT_XY+8,88,"IT:SLIPS:FROM:YOUR:HANDS",PRT_END

; Room 51
.throwswitchmess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,15,5,PRT_PEN+3
  EQUB PRT_XY+8,72,"YOU:THROW:THE"
  EQUB PRT_XY+8,80,"LEVER:TO:;ON;"
  EQUB PRT_XY+8,88,"BUT:IT:BREAKS",PRT_END

; Room 50
.fedarmorog
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,18,4,PRT_PEN+3
  EQUB PRT_XY+8,72,"THAT:BONE:SHOULD"
  EQUB PRT_XY+10,80,"KEEP:HIM:BUSY@",PRT_END

; Room 54
.dragonasleepmess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,6,PRT_PEN+3
  EQUB PRT_XY+8,72,"YOU:SMASH:THE:FLASK"
  EQUB PRT_XY+10,80,"OF:POTION:AND:THE"
  EQUB PRT_XY+9,88,"DRAGON:INHALES:THE"
  EQUB PRT_XY+8,96,"INTOXICATING:VAPOUR",PRT_END

; Room 53
.croctiedmess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,19,5,PRT_PEN+3
  EQUB PRT_XY+11,72,"YOU:NIMBLY:TIE"
  EQUB PRT_XY+10,80,"THE:ROPE:AROUND"
  EQUB PRT_XY+8,88, "THE:GATOR;S:SNOUT",PRT_END

; Room 48
.rockinwatermess
  EQUB PRT_PEN+7,PRT_XY+2,112,PRT_DRAWBOX,26,5,PRT_PEN+3
  EQUB PRT_XY+6,136,"YOU:PUSH:THE:ROCK:INTO:THE"
  EQUB PRT_XY+6,144,"RIVER:AND:IT:DISPLACES:THE"
  EQUB PRT_XY+8,152,"WATER<:RAISING:THE:LEVEL",PRT_END

; Room 56
.keyinmachine
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,24,5,PRT_PEN+3
  EQUB PRT_XY+8,72,"YOU:TRY:THE:KEY:IN:THE"
  EQUB PRT_XY+13,80,"LOCK:AND:IT:FITS@"
  EQUB PRT_XY+8,88,"SO:YOU:TURN:IT:TO:;ON;",PRT_END

; Room 60
.fillbucketmess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,21,4,PRT_PEN+3
  EQUB PRT_XY+8,72,"YOU:FILL:YOUR:EMPTY"
  EQUB PRT_XY+10,80,"BUCKET:WITH:WATER",PRT_END

; Room 36
.thanksforloafmess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,18,5,PRT_PEN+3
  EQUB PRT_XY+8,72, "THE:RAVENOUS:RAT"
  EQUB PRT_XY+11,80,"EATS:THE:LOAF"
  EQUB PRT_XY+11,88,"AND:RUNS:AWAY",PRT_END

; Room 40
.puteggbackmess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,20,6,PRT_PEN+3
  EQUB PRT_XY+11,72,"YOU:PUT:THE:EGG"
  EQUB PRT_XY+8,80, "BACK:INTO:THE:NEST"
  EQUB PRT_XY+12,88,"AND:THE:DRAGON"
  EQUB PRT_XY+8,96, "ALLOWS:YOU:TO:PASS",PRT_END

; Room 36
.goawaymess
  EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,26,5,PRT_PEN+6
  EQUB PRT_XY+10,72,"&OH:NO@:NOT:YOU:AGAIN>"
  EQUB PRT_XY+12,80, "GO:AWAY>:I;M:HIDING<"
  EQUB PRT_XY+8,88, "AND:IT;S:ALL:YOUR:FAULT'",PRT_END

; Room 84
.knockandentermess
  EQUB PRT_PEN+2,PRT_XY+2,96,PRT_DRAWBOX,17,3,PRT_PEN+6
  EQUB PRT_XY+8,120, "KNOCK:AND:ENTER",PRT_END

  EQUB PRT_PEN+7,PRT_XY+6,48,PRT_DRAWBOX,22,5,PRT_PEN+3
  EQUB PRT_XY+14,72, "THAT;S:EASIER:SAID" 
  EQUB PRT_XY+11,80, "THAN:DONE:WHEN:YOU;RE"
  EQUB PRT_XY+11,88, "WEARING:BOXING:GLOVES",PRT_END,PRT_END

; Room 84
.usedoorknockermess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,20,5,PRT_PEN+3
  EQUB PRT_XY+12,72,"USING:THE:DOOR"
  EQUB PRT_XY+8,80,"KNOCKER<:YOU:KNOCK"
  EQUB PRT_XY+8,88,"AND:THE:DOOR:OPENS",PRT_END

; Room 55
.usecrowbarmess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,19,5,PRT_PEN+3
  EQUB PRT_XY+8,72,"USING:THE:CROWBAR"
  EQUB PRT_XY+8,80,"YOU:FORCE:THE:LID"
  EQUB PRT_XY+13,88,"OFF:THE:WELL",PRT_END

; Room 41
.usepickaxemess
  EQUB PRT_PEN+7,PRT_XY+2,48,PRT_DRAWBOX,22,4,PRT_PEN+3
  EQUB PRT_XY+9,72,"YOU:USE:THE:PICKAXE"
  EQUB PRT_XY+8,80,"TO:BREAK:UP:THE:ROCK",PRT_END

; Room 40 / 56 / 71 / 88 / 94
.obstructingliftmess
  EQUB PRT_PEN+2,PRT_XY+14,80,PRT_DRAWBOX,14,4,PRT_PEN+6
  EQUB PRT_XY+21,104,"STAND:CLEAR"
  EQUB PRT_XY+21,112,"OF:THE:LIFT",PRT_END

; Room 94
.userugmess
  EQUB PRT_PEN+7,PRT_XY+10,80,PRT_DRAWBOX,17,6,PRT_PEN+3
  EQUB PRT_XY+18,104,"YOU:THROW:THE"
  EQUB PRT_XY+17,112,"RUG:ACROSS:THE"
  EQUB PRT_XY+16,120,"DAGGERS<:MAKING"
  EQUB PRT_XY+22,128,"THEM:SAFE",PRT_END

; Any room
.dropwhiskeymess
  EQUB PRT_PEN+2,PRT_XY+2,48,PRT_DRAWBOX,14,7,PRT_PEN+6
  EQUB PRT_XY+8,72,  "YOU:FIND:THE"
  EQUB PRT_XY+9,80,  "WHISKEY:TOO"
  EQUB PRT_XY+9,88,  "TEMPTING:TO"
  EQUB PRT_XY+9,96,  "DROP:AND:SO"
  EQUB PRT_XY+11,104,"DRINK:IT@",PRT_END

; Room 36
.getbackintheremess
  EQUB PRT_PEN+5,PRT_XY+2,48,PRT_DRAWBOX,21,4,PRT_PEN+6
  EQUB PRT_XY+10,72,  "&OY@:WHERE:DO:YOU"
  EQUB PRT_XY+7,80,  "THINK:YOU;RE:GOING@'",PRT_END

; Room 72
.holdingholemess
  EQUB PRT_PEN+2,PRT_XY+2,48,PRT_DRAWBOX,16,7,PRT_PEN+6
  EQUB PRT_XY+8,72,"WHOOPS@:",PRT_PEN+4,"YOU;VE"
  EQUB PRT_XY+9,80,"GOT:A:HOLE:IN"
  EQUB PRT_XY+10,88,"YOUR:BAG:AND"
  EQUB PRT_XY+8,96,"EVERYTHING:HAS"
  EQUB PRT_XY+10,104,"DROPPED:OUT@",PRT_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ALL DEAD MESSAGES

 ; Any room
.deadwindow
  EQUB PRT_PEN+6,PRT_XY+10,64,PRT_DRAWBOX,18,6
  EQUB PRT_XY+16,112,PRT_PEN+2,"YOU:LOSE:A:LIFE@",PRT_PEN+5,PRT_END

; Room 50
.armorogkilledmess
  EQUB PRT_XY+18,88,"ARMOROG:CAUGHT"
  EQUB PRT_XY+17,100,"YOU:TRESPASSING"
  EQUB PRT_END

; Room 51
.killedbyportcullis
  EQUB PRT_XY+16,88,"YOU:WERE:STABBED"
  EQUB PRT_XY+16,96,"BY:THE:SPIKES:OF"
  EQUB PRT_XY+18,104,"THE:PORTCULLIS"
  EQUB PRT_END

; Room 40 / 56 / 71 / 88 / 94
.killedbyliftmess
  EQUB PRT_XY+17,88,"YOU:GOT:TRAPPED"
  EQUB PRT_XY+18,96,"IN:THE:COGS:ON"
  EQUB PRT_XY+17,104,"TOP:OF:THE:LIFT"
  EQUB PRT_END

; Room 40
.dragonkilledmess
  EQUB PRT_XY+16,88, "THE:DRAGON:BITES"
  EQUB PRT_XY+16,96, "YOU:AND:YOU:KEEL"
  EQUB PRT_XY+20,104,"OVER:AND:DIE"
  EQUB PRT_END

; Room 54
.dragonflameskilledmess
  EQUB PRT_XY+17,88, "YOU:ARE:ROASTED"
  EQUB PRT_XY+17,96, "BY:THE:DRAGON;S"
  EQUB PRT_XY+20,104,"FIERY:BREATH"
  EQUB PRT_END

; Room (36 until extinguished) / 68 / 69
;   lamps (24 / 36 / 36 / 51 / 52 / 53 / 68 / 69 / 71 / 72 / 73 / 83 / 84 / 85 / 88 / 93)
.killedbyflame
  EQUB PRT_XY+18,88,"YOU:WERE:BURNT"
  EQUB PRT_XY+19,100,"BY:THE:FLAMES"
  EQUB PRT_END

; Room 35 / 45 / (gap in pier 46) / 48 / 53
.killedbywater
  EQUB PRT_XY+17,88, "YOU:FELL:IN:THE"
  EQUB PRT_XY+15,100,"WATER:AND:DROWNED"
  EQUB PRT_END

; Room 53
.croceatenmess
  EQUB PRT_XY+19,88,"THE:GATOR:HAS"
  EQUB PRT_XY+19,100,"YOU:FOR:LUNCH"
  EQUB PRT_END

; Room 49
.killedbyhawk
  EQUB PRT_XY+18,88,"THE:DIZZY:HAWK"
  EQUB PRT_XY+21,96,"SWOOPS:DOWN"
  EQUB PRT_XY+19,104,"AND:KILLS:YOU"
  EQUB PRT_END

; Room 36
.ratgotyoumess
  EQUB PRT_XY+20,88,"THE:RAT:GOES"
  EQUB PRT_XY+20,96,"STRAIGHT:FOR"
  EQUB PRT_XY+23,104,"YOUR:NECK"
  EQUB PRT_END

; Room 77
.killedbyvolcano  EQUB PRT_XY+18,88, "YOU:WERE:BURNT"
  EQUB PRT_XY+17,96, "BY:THE:HOT:LAVA"
  EQUB PRT_XY+18,104,"IN:THE:VOLCANO"
  EQUB PRT_END

; Room 69 / 94
.killedbydaggersmess
  EQUB PRT_XY+14,88, "YOU;RE:SKEWERED:BY"
  EQUB PRT_XY+15,100,"THE:SHARP:DAGGERS"
  EQUB PRT_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ODD MESSAGES

.youfoundcoinmess
  EQUB PRT_PEN+5,PRT_XY+16,64,PRT_DRAWBOX,12,5,PRT_PEN+3
  EQUB PRT_XY+22,88,"WELL:DONE@",PRT_PEN+6
  EQUB PRT_XY+23,96,"YOU:FOUND"
  EQUB PRT_XY+26,104,"A:COIN",PRT_END
 
.inventory
  EQUB PRT_PEN+4,PRT_XY+6,56,PRT_DRAWBOX,22,6,PRT_XY+16,76
.carrymess
  EQUB PRT_PEN+5,"YOU:ARE:CARRYING",PRT_PEN+2,PRT_END
.inventorywithbag  EQUB PRT_PEN+4,PRT_XY+6,48,PRT_DRAWBOX,22,8,PRT_XY+16,68,PRT_GOSUB
  EQUW carrymess
  EQUB PRT_END

.selectitemmess
  EQUB PRT_PEN+7,PRT_XY+14,136,PRT_DRAWBOX,14,2,PRT_PEN+5
  EQUB PRT_XY+18,152,"CHOOSE:ITEM:TO"
  EQUB PRT_XY+21,160,"USE:OR:DROP",PRT_END

.carryingtoomuchmess
  EQUB PRT_PEN+7,PRT_XY+12,136,PRT_DRAWBOX,16,2,PRT_PEN+5
  EQUB PRT_XY+16,152,"YOU:ARE:CARRYING"
  EQUB PRT_XY+16,160,"TOO:MUCH:TO:HOLD",PRT_END

.nothingatallmess
  EQUB PRT_XY+22,96,PRT_PEN+7
  EQUB "N",PRT_XY+25,96,"O",PRT_XY+28,96,"T",PRT_XY+31,96
  EQUB "H",PRT_XY+34,96,"I",PRT_XY+37,96,"N",PRT_XY+40,96,"G",PRT_END


.nothingheremess  EQUB PRT_END
.bagmess  EQUB "EXIT:AND:DON;T:DROP",PRT_END
.greenbeanmess  EQUB "A:SINGLE:GREEN:BEAN",PRT_END
.bonemess  EQUB "A:FRESH:MEATY:BONE",PRT_END
.goldeneggmess  EQUB "A:HEAVY:DRAGON:EGG",PRT_END
.blackholemess  EQUB "A:LARGE:ROUND:HOLE",PRT_END
.sleeppotionmess  EQUB "SOME:SLEEPING:POTION",PRT_END
.applemess  EQUB "A:FRESH:GREEN:APPLE",PRT_END
.jugmess  EQUB "A:JUG:OF:COLD:WATER",PRT_END
.loafmess  EQUB "STALE:LOAF:OF:BREAD",PRT_END
.fullwhiskeymess  EQUB "A:BOTTLE:OF:WHISKEY",PRT_END
.ropemess  EQUB "A:PIECE:OF:ROPE",PRT_END


.rockmess  EQUB "A:HEAVY:BOULDER",PRT_END
.fullwinemess  EQUB "A:BOTTLE:OF:WINE",PRT_END
.emptybottlemess  EQUB "AN:EMPTY:BOTTLE",PRT_END
.keymess  EQUB "A:SHINY:GOLD:KEY",PRT_END
.mtbucketmess  EQUB "AN:EMPTY:BUCKET",PRT_END
.fullbucketmess  EQUB "A:BUCKET:OF:WATER",PRT_END
.leavesmess  EQUB "A:CLUMP:OF:LEAVES",PRT_END
.pigmycowmess  EQUB "A:CUTE:PIGMY:COW",PRT_END
.railingmess  EQUB "A:PIECE:OF:RAILING",PRT_END
.doorknockermess  EQUB "BRASS:DOOR:KNOCKER",PRT_END
.crowbarmess  EQUB "A:STRONG:CROWBAR",PRT_END
.pickaxemess  EQUB "A:RUSTY:OLD:PICKAXE",PRT_END
.rugmess  EQUB "AN:OLD:THICK:RUG",PRT_END
.windowmess  EQUB "A:WINDOW:FRAME",PRT_END

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Temporarily empty routines
.dozyrou
.dougrou
.dylanrou
.denzilrou
  RTS
