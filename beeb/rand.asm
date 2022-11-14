.random
{
  LDA seed
  SEC:SBC #&01:CLC
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
