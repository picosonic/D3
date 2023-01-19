;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Code in language workspace

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This is just for testing
.process_inputs
{
  LDX keys
  BEQ done ; Nothing pressed

.check_fire
  TXA:AND #PAD_FIRE
  BEQ case_right
  LDA #&01:STA killed

.case_right
  TXA:AND #PAD_RIGHT
  BEQ case_left
  INC roomno

.case_left
  TXA:AND #PAD_LEFT
  BEQ case_up
  DEC roomno

.case_up
  TXA:AND #PAD_UP
  BEQ case_down
  LDA roomno:CLC:ADC #&10:STA roomno

.case_down
  TXA:AND #PAD_DOWN
  BEQ checkno
  LDA roomno:SEC:SBC #&10:STA roomno

.checkno
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
