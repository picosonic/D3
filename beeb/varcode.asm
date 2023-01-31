;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Code in language workspace

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This is just for testing
.goback
  RTS

.process_inputs
{
  LDX keys
  BEQ goback ; Nothing pressed

.check_fire
  TXA:AND #PAD_FIRE
  BEQ case_right
  JMP tryputtingdown

.case_right
  TXA:AND #PAD_RIGHT
  BEQ case_left
  INC dizzyx

.case_left
  TXA:AND #PAD_LEFT
  BEQ case_up
  DEC dizzyx

.case_up
  TXA:AND #PAD_UP
  BEQ case_down
  DEC dizzyy:DEC dizzyy:DEC dizzyy:DEC dizzyy

.case_down
  TXA:AND #PAD_DOWN
  BEQ checkno
  INC dizzyy:INC dizzyy:INC dizzyy:INC dizzyy

.checkno

  ; See if we've gone offscreen to the left
.chleft
  LDA dizzyx:CMP #32:BCS chright
  DEC roomno:LDA #92:STA dizzyx:JMP roomrange
  ; See if we've gone offscreen to the right
.chright
  LDA dizzyx:CMP #92:BCC chtop
  INC roomno:LDA #32:STA dizzyx:JMP roomrange
  ; See if we've gone offscreen to the top
.chtop
  LDA dizzyy:CMP #40:BCS chbottom
  LDA roomno:CLC:ADC #&10:STA roomno
  LDA #168:STA dizzyy:JMP roomrange
  ; See if we've gone offscreen to the bottom
.chbottom
  LDA dizzyy:CMP #168:BCC roomrange
  LDA roomno:SEC:SBC #&10:STA roomno
  LDA #40:STA dizzyy

.roomrange
  LDA roomno:CMP #101:BCC done
  LDA #STARTROOM:STA roomno ; Reset

.done
  RTS
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
  CLC:ADC #SPR_WATER0:STA frmno

  JSR frame

  ; TODO ... check for collision with water or lava ...

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
  LDA #SPR_FLAME:STA frmno
  LDA clock:AND #&01:TAY:LDA flamecolours, Y ; Set flame colour based on odd/even clock
  STA frmattri

  LDY #&00
.updateflamelp

  LDA flamelist, Y:STA frmx:INY
  LDA flamelist, Y:STA frmy:INY
  INY
  JSR frame

  ; TODO ... check for collision with flame ...

  DEX:BNE updateflamelp

.done
  RTS

.flamecolours
  EQUB     &02  ; Red
  EQUB &80+&07  ; White (h-flip)
}
