.updatewater
{
  ; First check if there is any water
  LDA noofwater:BEQ done

  TAX
  LDA #lo(waterlist):STA zptr4
  LDA #hi(waterlist):STA zptr4+1  

  ; Get water colour, e.g. water or lava
  LDA watercolour:AND #&E7:ORA #&10:STA frmattri

  LDY #&00
.updatewaterlp

  LDA (zptr4), Y:STA frmx:INY
  LDA (zptr4), Y:STA frmy:INY
  LDA (zptr4), Y
  STA zidx4:INC zidx4:LDA zidx4:AND #&03:STA (zptr4), Y:INY
  CLC:ADC #92:STA frmno

  JSR frame

  ; ...

  DEX:BNE updatewaterlp

.done
  RTS
}

.updateflames
{
  ; First check if there are flames
  LDA noofflames:BEQ done

  TAX
  LDA #lo(flamelist):STA zptr4
  LDA #hi(flamelist):STA zptr4+1

  ; Update flame loop
  LDA #115:STA frmno
  LDA clock:AND #&01:TAY:LDA flamecolours, Y:STA frmattri

  LDY #&00
.updateflamelp

  LDA (zptr4), Y:STA frmx:INY
  LDA (zptr4), Y:STA frmy:INY
  INY
  JSR frame

  DEX:BNE updateflamelp

.done
  RTS

.flamecolours
  EQUB     &02  ; Red
  EQUB &80+&07  ; White (h-flip)
}