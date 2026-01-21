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
.read_input \\ X=11, Y=&FF, A=keys_state
{
  SEI

  ; Use internal key numbering
  LDX #&7F : STX SYSVIA_DDRA \\ when keyboard selected, write key val to b0-6 and read key STAte (1=down) from b7
  LDX #3+0 : STX SYSVIA_REGB \\ "enable" keyboard - allows reading keys: write key value to SYSVIA_REGA and read from b7:1=pressed

  ; Pack inputs to match Dizzy
  ;
  ; Spectrum Dizzy uses
  ;
  ;  bit   3    2    1    0
  ;      fire left right jump
  ;
  ;  KEYS        ACTION        JOYSTICK
  ;  ----        ------        --------
  ; SPACE      START GAME        FIRE
  ;   Z           LEFT           LEFT
  ;   X           RIGHT         RIGHT
  ;   K            UP             UP
  ;   M           DOWN           DOWN
  ; SPACE         JUMP            UP
  ; ENTER   PICK UP/DROP/USE     FIRE
  ;   Q         QUIT GAME         -
  ;
  ; K M changed to : / as RETURN is too far away otherwise

  LDX #KEY_D             : STX SYSVIA_REGA : ASL SYSVIA_REGA : LDA #0 : ROL A  ; "D"      DEBUG

  LDX #KEY_COLON         : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; ":"      UP
  LDX #KEY_FWDSLASH      : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "/"      DOWN

  LDX #KEY_RETURN        : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "RETURN" FIRE
  LDX #KEY_Z             : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "Z"      LEFT
  LDX #KEY_X             : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "X"      RIGHT
  LDX #KEY_SPACE         : STX SYSVIA_REGA : ASL SYSVIA_REGA : ROL A           ; "SPACE"  JUMP

  STA keys

  ;LDX #&49 : STX SYSVIA_REGA : LDA SYSVIA_REGA : eor #&80 : STA fire_up ; [RETURN]
  ;LDX #&70 : STX SYSVIA_REGA : ASL SYSVIA_REGA : bcs reset              ; [ESCAPE]

  ; See if joystick is enabled
  LDA padfound:BEQ nojoy

  ; Read channel 0 - Master Joystick Left/Right
  LDX #&00:JSR adc_joystick
  ; Process horizontal axis (low=right)
  ASL A:STA joykey

  ; Read channel 1 - Master Joystick Up/Down
  LDX #&01:JSR adc_joystick
  ; Process vertical axis (low=down)
  ASL A:ASL A:ASL A:ASL A:ORA joykey:STA joykey

  ; Get fire button - PB4 (logic 0 when pressed)
  LDA SYSVIA_REGB
  AND #%00010000:EOR #%00010000:LSR A
  ORA keys:ORA joykey:STA keys

.nojoy

  LDX #3+8 : STX SYSVIA_REGB \\ "disable" keyboard
  LDX #&FF : STX SYSVIA_DDRA \\ put back ready for sound (all 8 bits write only)

.reset
  CLI

  RTS

.joykey
  EQUB &00
}

.adc_joystick
{
  ; Set input channel and start conversion
  STX ADC_LATCH

.wait_for_adc
  ; Wait for data to be "ready"
  LDA ADC_STATUS:AND #&80:BNE wait_for_adc

  ; 8-bit ADC value read
  LDA ADC_HIGH
  CMP #255-32:BCS joy_adc_high
  CMP #32:BCC joy_adc_low

  ; Within dead-zone (centred)
  LDA #&00:RTS

  ; Right / Down
.joy_adc_low
  LDA #&01:RTS

  ; Left / Up
.joy_adc_high
  LDA #&02:RTS
}

; Check for joystick presence by looking for FIRE button press
.scanjoy
{
  LDA #&80:LDX #&00:LDY #&00
  JSR OSBYTE
  TXA

  RTS
}
