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

INCLUDE "hearts.asm"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ODD MESSAGES

.inventory
  EQUB PRT_PEN+4,PRT_XY+6,56,PRT_DRAWBOX,22,6,PRT_XY+16,76

.carrymess
  EQUB PRT_PEN+5,"YOU:ARE:CARRYING",PRT_PEN+2,PRT_END

.inventorywithbag
  EQUB PRT_PEN+4,PRT_XY+6,48,PRT_DRAWBOX,22,8,PRT_XY+16,68,PRT_GOSUB
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.resetmoving
{
  LDX #lo(objresetcmd)
  LDY #hi(objresetcmd)
  JSR OSCLI

  ; Page in roomdata sideways RAM
  PAGE_ROOMDATA

  LDA #&00
  STA waterheight
  STA fireout
  STA ratcount

  LDY #&00
.scrubtalkbefore
  STA talkbefore, Y
  INY
  CPY #nooftalkbefore:BNE scrubtalkbefore

  RTS

.^resetmoving1
  LDA #&FF
  STA shopkeepercount

  LDA #&01
  STA ratcoll+1

  RTS

.objresetcmd
  EQUS "L.OBJDATA", &0D
}

.resetroommoving
{
  LDA patch_BEQ:STA patchpick
  JSR resetroommoving1
  LDA patch_BNE:STA patchpick
.resetroommoving1
  LDA #lo(movingdata):STA zptr4
  LDA #hi(movingdata):STA zptr4+1

  LDX #&00
.resetroommovinglp
  LDY #rou:LDA (zptr4), Y ; Get routine id for this object
  CMP #pickupable
.patchpick
  BEQ notprintyet

  LDY #room:LDA (zptr4), Y:CMP roomno:BNE notprintyet
  LDA #lo(resetrous):STA zptr5
  LDA #hi(resetrous):STA zptr5+1
  JSR jumptoroutine
.notprintyet

  ; Advance to next object
  LDA zptr4:CLC:ADC #movingsize:STA zptr4
  BCC samepage
  INC zptr4+1
.samepage

  INX:CPX #noofmoving:BNE resetroommovinglp ; Loop until done

.done
  RTS

  ; Just to get branch opcodes for patching above
.patch_BEQ
  BEQ done
.patch_BNE
  BNE done
}

; zptr4 = current object
; zptr5 = jump table to use
.jumptoroutine
{
  LDY #rou:LDA (zptr4), Y ; Get routine id for this object
  CMP #roucount-1
  BCS done

  ASL A:TAY
  LDA (zptr5), Y:STA jump+1:INY
  LDA (zptr5), Y:STA jump+2
.jump
  JMP duffmem

.done
  RTS
}

; Reset coins
.resetcoins
{
  LDA #&FF:STA coins

  ; Clear the top bit of the room number to indicate coin not collected
  LDX #totalcoins:LDY #0
.resetcoinslp
  LDA cointable+2, Y:AND #&7F:STA cointable+2, Y
  INY:INY:INY
  DEX:BNE resetcoinslp

  ; Fall through ...
}

.addtocoins
{
  INC coins

.^drawcoins

  ; Determine how many 10s
  LDX #0:SEC:LDA coins
.more10s
  SBC #10:BCC nomore10s
  INX
  BNE more10s
.nomore10s
  PHA:TXA:CLC:ADC #'0':STA noofcoinsmess

  PLA:CLC:ADC #'0'+10:STA noofcoinsmess+1

  ; Draw the full coins message
  LDA #hi(coinsmess):STA zptr5+1
  LDA #lo(coinsmess):STA zptr5
  JMP prtmessage

.coinsmess EQUB PRT_PEN+4, PRT_XY+46,8
.noofcoinsmess EQUB 0, 0, PRT_END
}

.subfromlives
{
  ; Subtract 1 from lives
  DEC lives

  .^drawlives

  ; Inject lives number into number of lives messages, using repeat count
  LDA lives:STA nooflivesmess+1

  ; Print number of lives (as eggs)
  LDA #hi(livesmess):STA zptr5+1
  LDA #lo(livesmess):STA zptr5

  JMP prtmessage

.livesmess EQUB PRT_PEN+4, PRT_XY+14,8, ":::", PRT_XY+14,8 ; Clear lives display
.nooflivesmess EQUB PRT_REP, 1, "/", PRT_ENDREP, PRT_END   ; Print lives count
}

.resetcarrying
{
  LDA #OBJ_EMPTY
  STA objectscarried+1
  STA objectscarried+3
  STA objectscarried+4

  LDA #OBJ_BAG:STA objectscarried+2 ; Bag (used as EOF)
  LDA #OBJ_APPLE:STA objectscarried ; Apple

  RTS
}
