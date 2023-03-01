; The heart demo

numhearts = 16

.heartdemo
{
  JSR resethearts

  LDA #0
.allhearts
  CLC:ADC #&01
  PHA
  JSR updatehearts
  PLA

  BNE allhearts

  RTS
}

.resethearts
{
  ; Alternate between add (clockwise) and subtract (anticlockwise)
  LDA addpatch:EOR #&20:STA addpatch ; &20 = SEC ^ CLC
  LDA addpatch+1:EOR #&80:STA addpatch+1 ; &80 = SBC abs,Y ^ ADC abs,Y

  LDY #PAL_RED+PLOT_XOR:STY frmattri ; Red / XOR

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
  JSR printheart ; rub out

  LDY #&00
  LDA (zptr4), Y
  CLC:ADC #&04 ; affects speed of rotation
  STA (zptr4), Y

  JSR printheart ; draw in new position

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

  ; determine heart size
  ROR A:ROR A:ROR A:ROR A:ROR A:AND #&03 ; Top 3 bits only (A/32)
  BEQ done ; Don't try printing NULL heart frame

  CLC:ADC #SPR_HEARTNULL
  STA frmno ; 1..3 + HEART offset

  LDY #&01:LDA (zptr4), Y ; path 0-255

  DEY
.^addpatch
  SEC:SBC (zptr4), Y ; count 0-255
  AND #&7F ; limit to <128
  PHA
  JSR getvalue

  ; position x around centre of playarea
  LSR A:CLC:ADC #62
  STA frmx
  PLA

  CLC:ADC #32 ; inverse sin
  AND #&7F ; limit to <128
  JSR getvalue

  ; A = A*3
  PHA:ASL A:STA ztmp1:PLA:CLC:ADC ztmp1

  ; position y around centre of playarea
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
  NEGATEACC ; Negate number, -ve to +ve
  TAX
  INC b+1

.waspos
  LDY #&00:LDA (zptr4), Y

  JSR multiply ; max value 127*64 / a=-63 to +63

.b
  LDX #&00
  BEQ done
  NEGATEACC ; Negate number, +ve to -ve

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

; Sin wave lookup
; Cos is 90' out of phase [+16]
; -Sin is 180' out of phase [+32]
.sincostable
  EQUB 0, 6,12,18,24,30,35,40,45,49,53,56,59,61,62,63  ; quad 0 (0' to 90')
  EQUB 64,63,62,61,59,56,53,49,45,40,35,30,24,18,12, 6  ; quad 1 (90' to 180')
  EQUB -0,-6,-12,-18,-24,-30,-35,-40,-45,-49,-53,-56,-59,-61,-62,-63  ; quad 2 (180' to 270')
  EQUB -64,-63,-62,-61,-59,-56,-53,-49,-45,-40,-35,-30,-24,-18,-12,-6  ; quad 3 (270' to 360')
}

; A=no to multiply
; X=multiplier
; A=answer high byte
.multiply
{
  STA multlp+2

  LDA #&00:STA ztmp4
.multlp
  CLC:ADC #&00

  BCC nooverflow ; Check for overflow
  INC ztmp4

.nooverflow

  DEX
  BNE multlp

  LDA ztmp4

  RTS
}
