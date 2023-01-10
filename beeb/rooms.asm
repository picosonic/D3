.roomdata
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ONE TIME INIT - Lost when first room loaded
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.onetimeinit
  INCLUDE "init.asm"

  ; Default to drawing frames clipped to play area
  LDA #&01:STA cliptoplayarea

  ; Reset loaded room number
  LDA #&FF:STA loadedroomno

  ; Reset animation countdown
  LDA #&02:STA eggcount

  LDA #&00:STA dizzyfrm
  LDA #184:STA dizzyx
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
  EQUB 58 ,152,63
  EQUB 38 ,120,31
  EQUB 52 ,102,59
  EQUB 58 ,136,55
  EQUB 76 ,128,55
  EQUB 56 ,72 ,73
  EQUB 82 ,152,86
  EQUB 44 ,160,24
  EQUB 36 ,104,22
  EQUB 44 ,64 ,41
  EQUB 54 ,112,77
  EQUB 82 ,160,36
  EQUB 86 ,128,46
  EQUB 68 ,88 ,92
  EQUB 62 ,112,67
  EQUB 84 ,112,68
  EQUB 40 ,160,69
  EQUB 84 ,128,56
  EQUB 58 ,96,89
  EQUB 60,152,94
  EQUB 62,160,49
  EQUB 88,152,51
  EQUB 60,96,84
  EQUB 84,160,87
  EQUB 72,160,57
  EQUB 56,88,75
  EQUB 50,72,40
  EQUB 76,80,72
  EQUB 86,88,52
  EQUB 70,64,76
.endcointable

totalcoins = (endcointable-cointable)/3
