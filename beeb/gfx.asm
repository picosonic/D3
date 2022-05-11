; Clear graphics screen
.cls
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