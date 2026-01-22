; Idea and portions of code from :
;    https://scarybeastsecurity.blogspot.com/2020/06/sampled-sound-1980s-style-from-sn76489.html
;    https://github.com/scarybeasts/misc

; OS defines
INCLUDE "os.asm"

; Variable and constant defines
INCLUDE "consts.asm"

PLAYBACK_RATE = ((1000000 / 6615) - 2)

; Zero page vars
ORG &50

; Pointer
.sound_ptr
  EQUW &0000

; Current sample
.sound_temp
  EQUB &00

ORG EXO_LOAD_ADDR

; Program entry point
.start
{
  ; Make sure we are not in decimal mode
  CLD
  SEI

  ; Set sound pointer to start of sample
  LDA #speechdata MOD 256:STA sound_ptr
  LDA #speechdata DIV 256:STA sound_ptr+1

  ; Set up audio

  ; System VIA port A to all outputs
  LDA #%11111111:STA SYSVIA_DDRA

  ; Keyboard to auto-scan
  LDA #%00001011:STA SYSVIA_REGB

  ; Zero volumes on all SN76489 channels, just in case anything already playing
  LDA #%11111111:JSR sound_write_slow ; Channel 3 (Noise)
  LDA #%11011111:JSR sound_write_slow ; Channel 2
  LDA #%10111111:JSR sound_write_slow ; Channel 1
  LDA #%10011111:JSR sound_write_slow ; Channel 0

  ; Period to 1 on tone channel 0
  LDA #%10000001:JSR sound_write_slow ; Channel 0
  LDA #%00000000:JSR sound_write_slow

  ; Set up User VIA timer 1 in free-run mode
  LDA #%01000000:STA USERVIA_ACR ; T1 continuous interrupts, shift reg disabled, latches disabled
  LDA #PLAYBACK_RATE:STA USERVIA_T1CL
  LDA #%00000000:STA USERVIA_T1CH

  ; Clear IFR just in case
  LDA #%01111111:STA USERVIA_IFR

  ; Loop until end of sample data
.loop
  JSR sound_write_sample
  LDA #end DIV 256:CMP sound_ptr+1:BNE loop
  LDA #end MOD 256:CMP sound_ptr:BNE loop

  ;
  ; Playback completed - time to clean up
  ;

  ; Zero volumes on all SN76489 channels, just in case of corruption
  LDA #%11111111:JSR sound_write_slow ; Channel 3 (Noise)
  LDA #%11011111:JSR sound_write_slow ; Channel 2
  LDA #%10111111:JSR sound_write_slow ; Channel 1
  LDA #%10011111:JSR sound_write_slow ; Channel 0

  ; System VIA port A to all inputs
  LDA #%00000000:STA SYSVIA_DDRA

  ; End program, go back to OS
  CLI
  RTS
}

; Read next sample from buffer and write to sound chip
.sound_write_sample
{
  ; Read and cache next byte of sample data
  LDY #&00:LDA (sound_ptr), Y

  LSR A:LSR A:LSR A:LSR A ; Only 4-bit volumes supported on tone channels 0, 1 and 2
  STA sound_temp

  ; Move sample pointer onwards
  INC sound_ptr
  BNE samepage
  INC sound_ptr+1
.samepage

  ; Wait for timer 1 interrupt
  LDA #%01000000 ; Mask to only check for timer 1
.timer1_wait
  BIT USERVIA_IFR ; Is timer 1 set in IFR ?
  BEQ timer1_wait ;   - No, so keep waiting
  STA USERVIA_IFR ; Clear the timer 1 interrupt, to wait again

  ; Deliver sample data
  LDA sound_temp
  ORA #%10010000 ; bit-7 (latch/data), bits-6/5 (channel - 0), bit 4 (type - latch volume)

  JSR sound_write_slow

  RTS
}

; Write data to sound chip then add processing delay
.sound_write_slow
{
    STA SYSVIA_ORAS ; Write reg/data to SN76489

    LDX #%00000000:STX SYSVIA_REGB

    ; Sound write held low for 8us
    ; Seems to work at 6us, not 5us on an issue 3 beeb
    NOP
    NOP
    NOP
    NOP

    LDX #%00001000:STX SYSVIA_REGB

    RTS
}

; Original 8-bit PCM sampled sound data for Spectrum
;   - Coded by L.Sharp
;   - Digitized on a C64 by G.Raeburn
.speechdata
INCBIN "speech.bin"

.end

SAVE "SPEECH", start, end