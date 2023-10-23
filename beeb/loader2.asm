ORG MAIN_LOAD_ADDR

; Place in memory to check if writable
swrcheck=ROMSBASE+8

.basicstart

; Include preceding tokenised BASIC loader program
INCBIN "loadertok.bin"

; Align to next page boundary to allow space for BASIC
ALIGN &100

; Test slots to find first available SWRAM
.swrtest
{
  SEI

  LDA #&FF

  LDY #&FF
  STA SWR_PAGE, Y ; Mark as not found (yet)
  DEY:STA SWR_PAGE, Y:INY

  LDX #&00 ; Start at slot 0
.findswr
  STX ROMSEL
  LDA swrcheck:EOR #&55:STA swrcheck
  CMP swrcheck:BNE noswryet

  TXA:STA SWR_PAGE, Y:DEY
  CPY #&FD:BEQ swrdone ; Stop if we've found 2 SWR
 
.noswryet
  INX:CPX #SWR_SLOTS:BNE findswr ; Keep looking until we get to slot 16

  ; Re-select ROM (likely BASIC)
.swrdone
  LDX ROMSEL_CACHE:STX ROMSEL

  CLI

  RTS
}

; Copy from main RAM &4000..&7FFF into SWRAM &8000..&BFFF
.swrcopy
{
  SEI

  ; Select the SWRAM slot we found earlier
  LDA SWR_PAGE, Y:STA ROMSEL

  LDX #&00
.swrcpyloop
  ; Copy a page of data
  LDA SWR_CACHE, X:STA ROMSBASE, X
  INX
  CPX #&00:BNE swrcpyloop

  ; Advance src and dest pointers
  INC swrcpyloop+2:INC swrcpyloop+5

  ; See if src has got to the end
  LDA swrcpyloop+2
  CMP #hi(ROMSBASE):BNE swrcpyloop

  ; Re-select ROM (likely BASIC)
  LDY ROMSEL_CACHE:STY ROMSEL

  ; Put back source/dest incase further copies are done
  LDA #hi(SWR_CACHE):STA swrcpyloop+2
  LDA #hi(ROMSBASE):STA swrcpyloop+5

  CLI

  RTS
}

.basicend
