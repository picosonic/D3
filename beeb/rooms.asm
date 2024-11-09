.roomdata
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ONE TIME INIT - Lost when first room loaded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.onetimeinit
  INCLUDE "init.asm"

  ; Default to drawing frames clipped to play area
  LDA #&01:STA cliptoplayarea

  ; Reset animation countdown
  LDA #&02:STA eggcount

  LDA #&00:STA dizzyfrm
  LDA #62:STA dizzyx
  LDA #136:STA dizzyy

  ; Load varcode
  LDX #lo(varcodecmd)
  LDY #hi(varcodecmd)
  JSR OSCLI

  JMP titlescreen

.varcodecmd
  EQUS "L.VARCODE", &0D

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.initend

.emptyroomname
EQUB "::::::::SKY:::::::::", PRT_END

.roomtable
INCBIN "RMTABLE"

treasurepic = 101
treasurelen = &3000

.cointable ;  x,   y,   room (top bit indicates collected)
  EQUB 58, 152, CRAFTYCLOUDROOM
  EQUB 38, 120, ILLUSIONROOM
  EQUB 52, 102, OAKTREEROOM
  EQUB 58, 136, TOPWELLROOM
  EQUB 76, 128, TOPWELLROOM
  EQUB 56, 72,  DAISYSHUTROOM
  EQUB 82, 152, LONGJUMPCLOUDROOM
  EQUB 44, 160, CHURCHROOM
  EQUB 36, 104, MARKETSQUAREROOM
  EQUB 44, 64,  MINESROOM
  EQUB 54, 112, ACTIVEVOLCANOROOM
  EQUB 82, 160, CASTLEDUNGEONROOM
  EQUB 86, 128, DOCKSROOM
  EQUB 68, 88,  MOREORRIBLECLOUDSROOM
  EQUB 62, 112, WESTWINGROOM
  EQUB 84, 112, BANQUETHALLROOM
  EQUB 40, 160, EASTWINGROOM
  EQUB 84, 128, LIFTCONTROLROOM
  EQUB 58, 96,  DIZZYSPARENTSHUTROOM
  EQUB 60, 152, DAISYSPRISONROOM
  EQUB 62, 160, GUARDHOUSEROOM
  EQUB 88, 152, MOATROOM
  EQUB 60, 96,  CASTLESTAIRCASEROOM
  EQUB 84, 160, MEETINGHALLROOM
  EQUB 72, 160, BASETREEHOUSEROOM
  EQUB 56, 88,  CLOUDROUTEROOM
  EQUB 50, 72,  DRAGONSLAIRROOM
  EQUB 76, 80,  DENZILSPADROOM
  EQUB 86, 88,  ENTRANCEHALLROOM
  EQUB 70, 64,  NEARVOLCANOROOM
.endcointable

totalcoins = (endcointable-cointable)/3
