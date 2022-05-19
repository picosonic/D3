; Return &FF in A if key is pressed
.scankey
{
  TAX ; Negative INKEY value to check for
  LDY #&FF ; Keyboard scan
  LDA #&81
  JSR OSBYTE
  TYA
  RTS
}

; Wait until specified key is not pressed
.unpressed
{
  PHA
  JSR scankey
  BEQ cleared
  PLA
  JMP unpressed

.cleared
  PLA
  RTS
}

; Flush all input buffers
.flushallbuffers
{
  LDA #&0F
  LDX #&00
  JSR OSBYTE
  RTS
}

; Select only keyboard as input stream
.selectkeyboard
{
  LDA #&02
  LDX #&00
  JSR OSBYTE
  RTS
}

; With help from tricky (Richard Broadhurst)
;
.read_input \\ X=11, Y=&FF, A=keys_state ; [ A B s S U D L R ]
{
  SEI

  ; Use internal key numbering
  LDX #&7F : STX SYSVIA_DDRA \\ when keyboard selected, write key val to b0-6 and read key STAte (1=down) from b7
  LDX #3+0 : STX SYSVIA_REGB \\ "enable" keyboard - allows reading keys: write key value to SYSVIA_REGA and read from b7:1=pressed

  ; Pack inputs to match NES 
  LDX #KEY_SPACE         : STX SYSVIA_REGA : ASL SYSVIA_REGA : LDA #0 : ROL A  ; "SPACE"  A
  LDX #KEY_OPENSQBRACKET : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "["      B
  LDX #KEY_TAB           : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "TAB"    SELECT
  LDX #KEY_RETURN        : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "RETURN" START
  LDX #KEY_COLON         : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; ":"      UP
  LDX #KEY_FWDSLASH      : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "/"      DOWN
  LDX #KEY_Z             : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "Z"      LEFT
  LDX #KEY_X             : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "X"      RIGHT

  STA keys

  ;LDX #&49 : STX SYSVIA_REGA : LDA SYSVIA_REGA : eor #&80 : STA fire_up ; [RETURN]
  ;LDX #&70 : STX SYSVIA_REGA : ASL SYSVIA_REGA : bcs reset              ; [ESCAPE]

  LDX #3+8 : STX SYSVIA_REGB \\ "disable" keyboard
  LDX #&FF : STX SYSVIA_DDRA \\ put back ready for sound (all 8 bits write only)

.reset
  CLI

  RTS
}
