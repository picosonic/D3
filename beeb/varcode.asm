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

.check_debug
  TXA:AND #PAD_DEBUG
  BEQ case_right
  JMP resetcoins

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
  ; First check if there is any water in current room
  LDA noofwater:BEQ done

  ; Set water frame size for collision
  LDA #32:LSR A:LSR A:STA cw
  LDA #6:STA ch

  ; Save water count for loop
  TAX

  ; Get water colour, e.g. water or lava
  LDA watercolour
  AND #&E7:ORA #&10 ; Make sure it's set to EOR plot
  STA frmattri

  LDY #&00
.updatewaterlp

  LDA waterlist, Y:STA frmx:STA cx:INY
  LDA waterlist, Y:STA frmy:STA cy:INY
  LDA waterlist, Y
  STA zidx4:INC zidx4:LDA zidx4:AND #&03:STA waterlist, Y:INY
  CLC:ADC #SPR_WATER0:STA frmno

  JSR frame

  ; Check for collision with water or lava
  JSR collidewithdizzy3
  BEQ notdrowned

  LDA #STR_killedbyvolcano:STA deathmsg
  LDA roomno:CMP #77:BEQ yesfellinlava
  LDA #STR_killedbywater:STA deathmsg
.yesfellinlava
  LDA #01:STA killed
  ;JSR killdizzy1

.notdrowned
  DEX:BNE updatewaterlp

.done
  RTS
}

.updateflames
{
  ; First check if there are flames in current room
  LDA noofflames:BEQ done

  ; Set flame frame size for collision
  LDA #16:LSR A:LSR A:STA cw
  LDA #13:STA ch

  ; Save flame count for loop
  TAX

  ; Update flame loop
  LDA #SPR_FLAME:STA frmno
  LDA clock:AND #&01:TAY:LDA flamecolours, Y ; Set flame colour based on odd/even clock
  STA frmattri

  LDY #&00
.updateflamelp

  LDA flamelist, Y:STA frmx:STA cx:INY
  LDA flamelist, Y:STA frmy:STA cy:INY
  INY
  JSR frame

  ; Check for collision with flame
  JSR collidewithdizzy3
  BEQ notburnt

  LDA #STR_killedbyflame:STA deathmsg
  LDA #&01:STA killed
  ;JSR killdizzy1

.notburnt

  DEX:BNE updateflamelp

.done
  RTS

.flamecolours
  EQUB     &02  ; Red
  EQUB &80+&07  ; White (h-flip)
}
