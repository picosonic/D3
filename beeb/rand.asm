; Original "random" number generator
;   has a period of 1,100,896 after initial ~ 91,935 iterations
;
;   This 6502 code has been functionally verified against the original z80 code
.random
{
  LDA seed
  SEC:SBC #&01
  EOR seed+1
  ASL A
  PHA:LDA seed+2:ROR A:STA seed+2:PLA
  STA seed
  EOR #&FF ; CPL
  ROL A
  EOR #48
  EOR seed+1
  STA seed+1
  EOR seed+2

  RTS

.seed
  EQUB &59, &a3, &13
}
