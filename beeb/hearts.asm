; The heart demo

numhearts = 32

.heartdemo
{
  JSR resethearts

  LDA #0
.allhearts
  CLC:ADC #&01:PHA
  JSR updatehearts
  PLA
  BNE allhearts

  RTS
}

.resethearts
{
  LDY #&00:STY frmreverse
  INY:STY frmplot
  INY:STY frmattri

  LDX #0:TXA
.resetheartslp
  STA hearttable+0, Y:INY
  JSR random
  STA hearttable+1, Y:INY
  INX:CPX #numhearts:BNE resetheartslp

  RTS
}

.updatehearts
{
  ; TODO
  LDA #SPR_HEART3:STA frmno
  LDA #32/4:STA frmx
  LDA #160:STA frmy
  LDA #PAL_RED:STA frmattri
  JSR frame

  RTS
}

.printheart
{
  ; TODO
.addpatch
  ; TODO

  RTS
}

; zptr4 = pointer to poaition in hearttable
.getvalue
{
  JSR getsincos:TAX
  LDA #&00:STA b+1

  TXA:BPL waspos
  INC b+1

.waspos
  LDA zptr4

	JSR multiply ; max value 127*64 / a=-63 to +63

.b
  LDX #&00
  BEQ done
	EOR #&FF:CLC:ADC #&01 ; Negate number

.done
  RTS
}

; A=0..127
; return A=-64 to 64
.getsincos
{
  LSR A ; max=63
  TAY
  LDA sincostable, Y

  RTS

.sincostable
  EQUB 0, 6,12,18,24,30,35,40,45,49,53,56,59,61,62,63  ; quad 0
  EQUB 64,63,62,61,59,56,53,49,45,40,35,30,24,18,12, 6  ; quad 1
  EQUB -0,-6,-12,-18,-24,-30,-35,-40,-45,-49,-53,-56,-59,-61,-62,-63  ; quad 2
  EQUB -64,-63,-62,-61,-59,-56,-53,-49,-45,-40,-35,-30,-24,-18,-12,-6  ; quad 3
}

; A=no to multiply
; X=multiplier
; A=answer
.multiply
{
  STA multlp+2

  LDA #&00
.multlp
  CLC:ADC #&00
  DEX
  BNE multlp

  RTS
}
