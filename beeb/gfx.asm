; Clear graphics screen
.cls
{
  LDA #(MODE8BASE) MOD 256:STA zptr1
  LDA #(MODE8BASE) DIV 256:STA zptr1+1

  LDY #&00
.loop
  LDA #&00
  STA (zptr1), Y
  INY
  BNE loop
  INC zptr1+1
  LDA zptr1+1
  CMP #&80
  BNE loop

  RTS
}