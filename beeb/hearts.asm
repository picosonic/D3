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
  ;CMP #&04 ; Temporarily limit for debugging (later respond to keypress)
  BNE allhearts

  RTS
}

.resethearts
{
  ; Alternate between add and subtract
  LDA addpatch:EOR #&20:STA addpatch ; &20 = SEC ^ CLC
  LDA addpatch+1:EOR #&80:STA addpatch+1 ; &80 = SBC abs,Y ^ ADC abs,Y

  LDY #&00:STY frmreverse ; 0 - Not flipped
  INY:STY frmplot ; 1 - OR
  INY:STY frmattri ; 2 - Red

  ; Point to heart table
  LDA #lo(hearttable):STA zptr4
  LDA #hi(hearttable):STA zptr4+1

  LDX #0:TXA
.resetheartslp
  LDY #&00:STA (zptr4), Y
  JSR random
  INY:STA (zptr4), Y

  JSR printheart

  ; Move on to next heart
  INC zptr4:INC zptr4

  CLC:ADC #&08
  INX:CPX #numhearts:BNE resetheartslp

  RTS
}

.updatehearts
{
  ; Point to heart table
  LDA #lo(hearttable):STA zptr4
  LDA #hi(hearttable):STA zptr4+1

  LDX #0:TXA
.updateheartslp
  JSR printheart

  LDA (zptr4), Y
  CLC:ADC #&04
  STA (zptr4), Y

  JSR printheart

  ; Move on to next heart
  INC zptr4:INC zptr4

  INX:CPX #numhearts:BNE  updateheartslp

  RTS
}

; zptr4 = pointer to position in hearttable
.printheart
{
  PHA:TXA:PHA:TYA:PHA

  ; print single heart (if large)

  LDY #&00:LDA (zptr4), Y

  ROR A:ROR A:ROR A:ROR A:ROR A:AND #&03 ; Top 3 bits only (A/32)
  BEQ done ; Don't try printing NULL heart frame

  CLC:ADC #SPR_HEARTNULL
  STA frmno ; 1..3 + HEART offset

  LDY #&01:LDA (zptr4), Y ; path 0-255

  DEY
.^addpatch
  SEC:SBC (zptr4), Y ; count 0-255
  AND #&7F
  JSR getvalue

  CLC:ADC #62
  STA frmx

  CLC:ADC #32
  AND #&7F
  JSR getvalue

  ; A = A*3
  PHA:ASL A:STA ztmp1:PLA:CLC:ADC ztmp1

  CLC:ADC #110
  STA frmy

  JSR frame

.done
  PLA:TAY:PLA:TAX:PLA
  RTS
}

; A=index into sincos table
; zptr4 = pointer to position in hearttable
.getvalue
{
  JSR getsincos:TAX
  LDA #&00:STA b+1

  TXA:BPL waspos
  INC b+1

.waspos
  LDY #&00:LDA (zptr4), Y

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
