.updatewater
{
  ; First check if there is any water
  LDA noofwater:BEQ done

  ; Save water count for loop
  TAX

  ; Get water colour, e.g. water or lava
  LDA watercolour
  AND #&E7:ORA #&10 ; Make sure it's set to EOR plot
  STA frmattri

  LDY #&00
.updatewaterlp

  LDA waterlist, Y:STA frmx:INY
  LDA waterlist, Y:STA frmy:INY
  LDA waterlist, Y
  STA zidx4:INC zidx4:LDA zidx4:AND #&03:STA waterlist, Y:INY
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

  ; Save flame count for loop
  TAX

  ; Update flame loop
  LDA #115:STA frmno
  LDA clock:AND #&01:TAY:LDA flamecolours, Y ; Set flame colour based on odd/even clock
  STA frmattri

  LDY #&00
.updateflamelp

  LDA flamelist, Y:STA frmx:INY
  LDA flamelist, Y:STA frmy:INY
  INY
  JSR frame

  DEX:BNE updateflamelp

.done
  RTS

.flamecolours
  EQUB     &02  ; Red
  EQUB &80+&07  ; White (h-flip)
}