; Extra data

; Horizontal flip look up table
.flip_lut
  EQUB &00, &80, &40, &c0, &20, &a0, &60, &e0, &10, &90, &50, &d0, &30, &b0, &70, &f0
  EQUB &08, &88, &48, &c8, &28, &a8, &68, &e8, &18, &98, &58, &d8, &38, &b8, &78, &f8
  EQUB &04, &84, &44, &c4, &24, &a4, &64, &e4, &14, &94, &54, &d4, &34, &b4, &74, &f4
  EQUB &0c, &8c, &4c, &cc, &2c, &ac, &6c, &ec, &1c, &9c, &5c, &dc, &3c, &bc, &7c, &fc
  EQUB &02, &82, &42, &c2, &22, &a2, &62, &e2, &12, &92, &52, &d2, &32, &b2, &72, &f2
  EQUB &0a, &8a, &4a, &ca, &2a, &aa, &6a, &ea, &1a, &9a, &5a, &da, &3a, &ba, &7a, &fa
  EQUB &06, &86, &46, &c6, &26, &a6, &66, &e6, &16, &96, &56, &d6, &36, &b6, &76, &f6
  EQUB &0e, &8e, &4e, &ce, &2e, &ae, &6e, &ee, &1e, &9e, &5e, &de, &3e, &be, &7e, &fe
  EQUB &01, &81, &41, &c1, &21, &a1, &61, &e1, &11, &91, &51, &d1, &31, &b1, &71, &f1
  EQUB &09, &89, &49, &c9, &29, &a9, &69, &e9, &19, &99, &59, &d9, &39, &b9, &79, &f9
  EQUB &05, &85, &45, &c5, &25, &a5, &65, &e5, &15, &95, &55, &d5, &35, &b5, &75, &f5
  EQUB &0d, &8d, &4d, &cd, &2d, &ad, &6d, &ed, &1d, &9d, &5d, &dd, &3d, &bd, &7d, &fd
  EQUB &03, &83, &43, &c3, &23, &a3, &63, &e3, &13, &93, &53, &d3, &33, &b3, &73, &f3
  EQUB &0b, &8b, &4b, &cb, &2b, &ab, &6b, &eb, &1b, &9b, &5b, &db, &3b, &bb, &7b, &fb
  EQUB &07, &87, &47, &c7, &27, &a7, &67, &e7, &17, &97, &57, &d7, &37, &b7, &77, &f7
  EQUB &0f, &8f, &4f, &cf, &2f, &af, &6f, &ef, &1f, &9f, &5f, &df, &3f, &bf, &7f, &ff

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