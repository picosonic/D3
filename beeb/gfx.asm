; Clear play area
.clearplayarea
{
  LDA #(MODE8BASE+(12*256)) DIV 256:STA zptr1+1

  .outerloop
  LDY #&10 ; Avoid left border

  .leftloop
  LDA #&00:STA (zptr1), Y
  INY
  BNE leftloop

  INC zptr1+1

  .rightloop
  LDA #&00:STA (zptr1), Y
  INY
  CPY #&F0 ; Avoid right border
  BNE rightloop

  ; Next line
  INC zptr1+1
  LDA zptr1+1
  CMP #&7E ; Avoid bottom border
  BNE outerloop

  RTS
}

; Draw a frame to play area
.drawframe
{
  ; Get offset to frame data
  LDA frmno:ASL A:TAX

  LDA frametable+1, X
  CMP #&FF:BEQ done ; Don't draw NULL frames
  CLC:ADC #hi(framedefs):STA zptr1+1

  LDA frametable, X:CLC:ADC #lo(framedefs):STA zptr1
  BCC samepage
  INC zptr1+1
.samepage

  ; Get width
  LDY #&00:LDA (zptr1), Y:ASL A:ASL A:STA frmwidth

  ; Get height
  INY:LDA (zptr1), Y:STA frmheight

  LDX #&08
  INC zptr1:INC zptr1 ; Move on past frame header

  LDA #&00:TAY:STA zidx1:STA zidx2
.loop
  TXA:PHA

  ; High nibble
  LDY zidx1
  LDA (zptr1), Y
  AND #&F0
  LSR A:LSR A:LSR A:LSR A
  TAX:LDA convert_1bpp_to_2bpp, X
  LDY zidx2
  STA PLAYAREA, Y
  INC zidx2

  ; Low nibble
  LDY zidx1
  LDA (zptr1), Y
  AND #&0F
  TAX:LDA convert_1bpp_to_2bpp, X
  LDY zidx2
  STA PLAYAREA, Y
  INC zidx2

  INC zidx1

  PLA:TAX
  DEX
  BNE loop

.done
  RTS

; Table for 1bpp->2bpp graphics conversion
.convert_1bpp_to_2bpp
  EQUB &00, &11, &22, &33, &44, &55, &66, &77
  EQUB &88, &99, &AA, &BB, &CC, &DD, &EE, &FF

; Table for mask values to AND against 1bpp->2bpp values
.colourmask
  EQUB &00 ; Black
  EQUB &0F ; Red
  EQUB &F0 ; Green
  EQUB &FF ; White
}