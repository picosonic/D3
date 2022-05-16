; 4 byte seeded "random" number generator
.rand
{
  LDA seed
  ROL A
  ROL A
  EOR #&41
  ROL A
  ROL A
  EOR #&93
  ADC seed+1
  STA seed
  ROL A
  ROL A
  EOR #&12
  ROL A
  ROL A
  ADC seed+2
  STA seed+1
  ADC seed
  INC seed+2
  BNE cont
  PHA
  LDA seed+3
  CLC
  ADC #&1D
  STA seed+3
  PLA

.cont
  EOR seed+3 
  RTS
}